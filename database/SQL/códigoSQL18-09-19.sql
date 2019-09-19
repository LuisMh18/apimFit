/*
  *18/09/19 LuisMh
*/

USE apimfit;
/* Rol --------------*/
CREATE TABLE `rol` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY  AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `rol` 
(`id`, `nombre`, `created_at`, `updated_at`) 
VALUES 
(1, "Administrador", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, "Usuario", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
DELETE FROM rol WHERE id=1;
DESC rol;
SELECT * FROM rol;

/* usuario --------------*/
CREATE TABLE `usuario` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `rol_id` int(10) unsigned NOT NULL ,
  `usuario` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (rol_id) REFERENCES rol(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


SELECT * FROM usuario;
DESC usuario;

/* usuario detalle--------------*/
CREATE TABLE `usuario_detalle` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `usuario_id` int(10) unsigned NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `paterno` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `materno` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `imagen` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


/* detalle persona--------------*/
DROP TABLE IF EXISTS usuario_detalle_fit;

CREATE TABLE `usuario_detalle_fit` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `usuario_id` int(10) unsigned NOT NULL,
  `estatura` int,
  `peso_libras` int,
  `peso_kilos` int,
  `foto_actual` varchar(250),
  `descripcion` text,
  `fecha` date,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;



/* consultas para usuario, detalle y rol--------------*/
/*nOS TRAE LA UNION DE LAS DOS TABLAS PERO QUE NO TENGA NULOS*/
SELECT * FROM usuario jOIN usuario_detalle ON usuario.id = usuario_detalle.usuario_id;
/*nOS TRAE LA UNION DE LAS DOS TABLAS aún y tenga NULOS*/
SELECT * FROM usuario LEFT OUTER jOIN usuario_detalle ON usuario.id = usuario_detalle.usuario_id;

SELECT usuario.id,  usuario.usuario, usuario.email, usuario.created_at as FECHA, 
       CONCAT(usuario_detalle.nombre, ' ' ,usuario_detalle.paterno, ' ', usuario_detalle.materno) as nombre_usuario, usuario_detalle.imagen,
       rol.id as idRol, rol.nombre as rol
FROM usuario 
LEFT OUTER jOIN usuario_detalle ON usuario.id = usuario_detalle.usuario_id
LEFT OUTER jOIN rol ON usuario.rol_id = rol.id
ORDER BY usuario.id DESC;

/* vista para usuario, detalle y rol--------------*/
DROP VIEW IF EXISTS vistaUsuarioDetalle;
CREATE VIEW vistaUsuarioDetalle AS
SELECT usuario.id,  usuario.usuario, usuario.email, usuario.created_at as FECHA, 
       CONCAT(usuario_detalle.nombre, ' ' ,usuario_detalle.paterno, ' ', usuario_detalle.materno) as nombre_usuario, usuario_detalle.imagen,
       usuario_detalle_fit.estatura,  usuario_detalle_fit.peso_libras, usuario_detalle_fit.peso_kilos, usuario_detalle_fit.foto_actual, usuario_detalle_fit.descripcion, usuario_detalle_fit.fecha AS fecha_foto_actual,   
       rol.id as idRol, rol.nombre as rol
FROM usuario 
LEFT OUTER jOIN usuario_detalle ON usuario.id = usuario_detalle.usuario_id
LEFT OUTER jOIN usuario_detalle_fit ON usuario.id = usuario_detalle_fit.usuario_id
LEFT OUTER jOIN rol ON usuario.rol_id = rol.id
ORDER BY usuario.id DESC;

SELECT * FROM vistaUsuarioDetalle;

/* Catalogo para ejercicio--------------*/
DROP TABLE IF EXISTS ejercicios;
CREATE TABLE `ejercicios` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(250),
  `descripcion` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ejercicios` 
(`id`, `nombre`, `descripcion`, `created_at`, `updated_at`) 
VALUES 
(1, "Sentadilla", "Ejercicio para piernas", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, "Peso Muero", "Ejercicio para piernas", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, "Rueda abdominal", "Ejercicio para abdomen", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

