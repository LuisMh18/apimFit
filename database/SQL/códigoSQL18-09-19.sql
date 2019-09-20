/*
  *18/09/19 LuisMh
*/

USE apimfit;
DROP VIEW IF EXISTS vistaComidasDias;
DROP TABLE IF EXISTS producto_comida_dia_a_dia;
DROP TABLE IF EXISTS comidas_dia;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS tipo_producto;
DROP TABLE IF EXISTS entrenamiento_ejercicio;
DROP TABLE IF EXISTS entrenamiento;
DROP TABLE IF EXISTS anio;
DROP VIEW IF EXISTS vistaMesDia;
DROP TABLE IF EXISTS mes_dia;
DROP TABLE IF EXISTS meses;
DROP TABLE IF EXISTS descripcion_dia;
DROP TABLE IF EXISTS dias;
DROP TABLE IF EXISTS tiempo;
DROP TABLE IF EXISTS equipo;
DROP TABLE IF EXISTS peso;
DROP TABLE IF EXISTS repeticiones;
DROP TABLE IF EXISTS series;
DROP TABLE IF EXISTS ejercicios;
DROP VIEW IF EXISTS vistaUsuarioDetalle;
DROP TABLE IF EXISTS usuario_detalle_fit;
DROP TABLE IF EXISTS objetivos;
DROP TABLE IF EXISTS usuario_detalle;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS rol;


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
/*DELETE FROM rol WHERE id=1;*/
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
  `status` tinyint(1) default 1,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (rol_id) REFERENCES rol(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `usuario` 
(`id`, `rol_id`, `usuario`, `password`, `email`, `remember_token`, `status`, `created_at`, `updated_at`) 
VALUES 
(1, 1, "Luis18", "12345", "test1@outlook.es", "123", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 1, "Ángel93", "12345", "test2@live.com", "123", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 2, "Perlita", "12345", "test3@hotmail.com", "123", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 1, "Diana93", "12345", "test4@outlook.es", "123", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 2, "Yerai", "12345", "test5@outlook.es", "123", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM usuario;
DELETE FROM usuario WHERE id=6;
DESC usuario;

/* usuario detalle--------------*/
CREATE TABLE `usuario_detalle` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `usuario_id` int(10) unsigned NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `paterno` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `materno` varchar(100) DEFAULT " ",
  `imagen` varchar(250) COLLATE utf8_unicode_ci NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `usuario_detalle` 
(`id`, `usuario_id`, `nombre`, `paterno`, `materno`, `imagen`) 
VALUES 
(1, 1, "Luis", "Reyez", "Peregil", "dsc sdcds"),
(2, 3, "Perlita", "Senz", "Osuna", "sdcsdc"),
(3, 4, "Diana", "Vela", "Twin", "sdcsdc");

SELECT * FROM usuario_detalle;


/* objetivos--------------*/
CREATE TABLE `objetivos` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `descripción` varchar(200),
  `notas` text,
  `status` tinyint(1) default 1, /*para saber los reuqrimientos que se necesitan, esto se va ir actualizando cuando el usuario suba de peso*/
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `objetivos` 
(`id`, `descripción`, `notas`, `status`, `created_at`, `updated_at`) 
VALUES 
(1, "Aumneto de masa muscular", "", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, "Perder grasa", "", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, "Perder grasa y ganar musculo", "", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, "Mantenerse", "", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM objetivos;



/* detalle persona--------------*/
CREATE TABLE `usuario_detalle_fit` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `usuario_id` int(10) unsigned NOT NULL,
  `estatura` double,
  `peso_libras` double,
  `peso_kilos` double,
  `foto_actual` varchar(250),
  `descripcion` text,
  `objetivo_id` int(10) unsigned NOT NULL,
  `requerimineto_proteinas` varchar(200),
  `requerimineto_calorias` varchar(200),
  `fecha` date,
  `status` tinyint(1) default 1, /*para saber los reuqrimientos que se necesitan, esto se va ir actualizando cuando el usuario suba de peso*/
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
  FOREIGN KEY (objetivo_id) REFERENCES objetivos(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `usuario_detalle_fit` 
(`id`, `usuario_id`, `estatura`, `peso_libras`, `peso_kilos`, `foto_actual`, `descripcion`, `objetivo_id`, `requerimineto_proteinas`, `requerimineto_calorias`, `fecha`, `status`,  `created_at`, `updated_at`) 
VALUES 
(1, 1, "1.62", 80, 60, "cdcsdcsdc", "No lo se :v", 1, "", "", "2019-09-19", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, "1.60", 70, 50, "cdcsdcsdc", "No lo se :v", 2, "", "", "2019-09-19", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, "1.50", 60, 40, "cdcsdcsdc", "No lo se :v", 3, "", "", "2019-09-19", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM usuario_detalle_fit;


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
SELECT usuario.id,  usuario.usuario, usuario.email, usuario.status, usuario.created_at as FECHA, 
       CONCAT(usuario_detalle.nombre, ' ' ,usuario_detalle.paterno, ' ', usuario_detalle.materno) as nombre_completo, usuario_detalle.imagen,
       usuario_detalle_fit.estatura,  usuario_detalle_fit.peso_libras, usuario_detalle_fit.peso_kilos, usuario_detalle_fit.foto_actual, usuario_detalle_fit.descripcion, usuario_detalle_fit.fecha AS fecha_foto_actual,   
       rol.id as idRol, rol.nombre as rol
FROM usuario 
LEFT OUTER jOIN usuario_detalle ON usuario.id = usuario_detalle.usuario_id
LEFT OUTER jOIN usuario_detalle_fit ON usuario.id = usuario_detalle_fit.usuario_id
LEFT OUTER jOIN rol ON usuario.rol_id = rol.id
ORDER BY usuario.id DESC;

SELECT * FROM vistaUsuarioDetalle;

/* Catalogo para ejercicio--------------*/
CREATE TABLE `ejercicios` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(250),
  `descripcion` text,
  `status` tinyint(1) default 1,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ejercicios` 
(`id`, `nombre`, `descripcion`, `status`, `created_at`, `updated_at`) 
VALUES 
(1, "Sentadilla", "Ejercicio para piernas", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, "Peso Muero", "Ejercicio para piernas", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, "Rueda abdominal", "Ejercicio para abdomen", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM ejercicios;

/* Catalogo para series--------------*/
CREATE TABLE `series` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `ejercicio_id` int(10) unsigned NOT NULL,
  `series` int,
  `notas` text,
  `status` tinyint(1) default 1,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ejercicio_id) REFERENCES ejercicios(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `series` 
(`id`, `ejercicio_id`, `series`, `notas`, `status`, `created_at`, `updated_at`) 
VALUES 
(1, 1, 3, "3 series", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 1, 5, "5 series", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, 10, "10 series", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM series;


/* Catalogo para repeticiones--------------*/
CREATE TABLE `repeticiones` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `serie_id` int(10) unsigned NOT NULL,
  `repeticiones` int,
  `notas` text,
  `status` tinyint(1) default 1,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (serie_id) REFERENCES series(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `repeticiones` 
(`id`, `serie_id`, `repeticiones`, `notas`, `status`, `created_at`, `updated_at`) 
VALUES 
(1, 1, 3, "3 repeticiones", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, 5, "5 repeticiones", 1,  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, 10, "10 repeticiones", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM repeticiones;



/* Catalogo para peso--------------*/
CREATE TABLE `peso` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `repeticion_id` int(10) unsigned NOT NULL,
  `peso_libras` double,
  `peso_kilos` double,
  `notas` text,
  `status` tinyint(1) default 1,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (repeticion_id) REFERENCES repeticiones(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `peso` 
(`id`, `repeticion_id`, `peso_libras`, `peso_kilos`, `notas`, `status`, `created_at`, `updated_at`) 
VALUES 
(1, 1, 5, 2, "", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, 10, 5, "", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 2, 25, 15, "", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM peso;


/* Catalogo para equipo--------------*/
CREATE TABLE `equipo` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `peso_id` int(10) unsigned NOT NULL,
  `descripcion` varchar(250),
  `notas` text,
  `status` tinyint(1) default 1,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (peso_id) REFERENCES peso(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `equipo` 
(`id`, `peso_id`, `descripcion`, `notas`, `status`, `created_at`, `updated_at`) 
VALUES 
(1, 1, "Disco de 5 libras", "", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, "Disco de 10 libras", "", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, "Disco de 25 libras", "", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 3, "Barra olimpica profesional", "", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM equipo;




/* Catalogo para tiempo--------------*/
/* 
  * desde el fron, cuando se inserte el tiempo de inicio, que por defecto debe de ser la hora actual, que haya un botón para
  * dar inicio al entrenamiento, mientras tanto que el campo de tiempo_fin y tiempo_total_diferencia esten deshabilitados, y que cuando termine el
  * entrenamiento se llenen esos campos automaticamente con el tiempo fin, es decir la hora actual, y en automatico se obtenga la diferencia de 
  * tiempo_inicio y tiempo_fin
*/
CREATE TABLE `tiempo` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `ejercicio_id` int(10) unsigned NOT NULL,
  `tiempo_inicio` TIME,
  `tiempo_fin` TIME,
  `tiempo_total_diferencia` TIME,
  `descripcion` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ejercicio_id) REFERENCES ejercicios(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `tiempo` 
(`id`, `ejercicio_id`, `tiempo_inicio`, `tiempo_fin`, `tiempo_total_diferencia`, `descripcion`, `created_at`, `updated_at`) 
VALUES 
(1, 1, "04:00:00", "05:00:00", "01:00:00", "", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 1, "04:00:00", "05:00:00", "01:00:00", "", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 2, "04:00:00", "05:00:00", "01:00:00", "", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM tiempo;



/* Catalogo para dias--------------*/
CREATE TABLE `dias` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(100),
  `status` tinyint(1) default 1,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `dias` 
(`id`, `nombre`, `status`, `created_at`, `updated_at`) 
VALUES 
(1, "Lunes", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, "Martes", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, "Miercoles", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, "Jueves", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, "Viernes", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, "Sabado", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(7, "Domingo", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM dias;

/* Catalogo para descripción_día--------------*/
CREATE TABLE `descripcion_dia` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `dia_id` int(10) unsigned NOT NULL,
  `descripcion` varchar(250),
  `completado` tinyint(1) default 0,
  `notas` text,
  `fecha` DATE,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (dia_id) REFERENCES dias(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `descripcion_dia` 
(`id`, `dia_id`, `descripcion`, `completado`, `notas`, `fecha`,`created_at`, `updated_at`) 
VALUES 
(1, 1, "Brazo y pecho", 0, "No pude entrenar esté dia porque me dio flojera", "2019-09-19", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, "Día de pierna", 1, "Entrenamiento completado", "2019-09-19", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, "Abdomen(core)", 1, "Entrenamiento completado", "2019-09-19", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM descripcion_dia;



/* Catalogo para meses-------------*/
CREATE TABLE `meses` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(100),
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `meses` 
(`id`, `nombre`, `created_at`, `updated_at`) 
VALUES 
(1, "Enero", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, "Febrero", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, "Marzo", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, "Abril", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, "Mayo", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, "Junio", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(7, "Julio", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(8, "Agosto", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(9, "Septiembre", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(10, "Octubre", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(11, "Noviembre", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(12, "Diciembre", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM meses;

/*Tabla para relacionar meses con días*/
CREATE TABLE `mes_dia` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `mes_id` int(10) unsigned NOT NULL,
  `dia_id` int(10) unsigned NOT NULL,
  `numero_dia` int,
  FOREIGN KEY (mes_id) REFERENCES meses(id) ON DELETE CASCADE,
  FOREIGN KEY (dia_id) REFERENCES dias(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

/*Enero --- 31 días*/
INSERT INTO `mes_dia` 
(`id`, `mes_id`, `dia_id`, `numero_dia`) 
VALUES 
(1, 1, 1, 01),
(2, 1, 2, 02),
(3, 1, 3, 03),
(4, 1, 4, 04),
(5, 1, 5, 05),
(6, 1, 6, 06),
(7, 1, 7, 07),
(8, 1, 1, 08),
(9, 1, 2, 09),
(10, 1, 3, 10),
(11, 1, 4, 11),
(12, 1, 5, 12),
(13, 1, 6, 13),
(14, 1, 7, 14),
(15, 1, 1, 15),
(16, 1, 2, 16),
(17, 1, 3, 17),
(18, 1, 4, 18),
(19, 1, 5, 19),
(20, 1, 6, 20),
(21, 1, 7, 21),
(22, 1, 1, 22),
(23, 1, 2, 23),
(24, 1, 3, 24),
(25, 1, 4, 25),
(26, 1, 5, 26),
(27, 1, 6, 27),
(28, 1, 7, 28),
(29, 1, 1, 29),
(30, 1, 2, 30),
(31, 1, 3, 31);

/*Febrero --- 28 días*/
INSERT INTO `mes_dia` 
(`id`, `mes_id`, `dia_id`, `numero_dia`) 
VALUES 
(32, 2, 1, 01),
(33, 2, 2, 02),
(34, 2, 3, 03),
(35, 2, 4, 04),
(36, 2, 5, 05),
(37, 2, 6, 06),
(38, 2, 7, 07),
(39, 2, 1, 08),
(40, 2, 2, 09),
(41, 2, 3, 10),
(42, 2, 4, 11),
(43, 2, 5, 12),
(44, 2, 6, 13),
(45, 2, 7, 14),
(46, 2, 1, 15),
(47, 2, 2, 16),
(48, 2, 3, 17),
(49, 2, 4, 18),
(50, 2, 5, 19),
(51, 2, 6, 20),
(52, 2, 7, 21),
(53, 2, 1, 22),
(54, 2, 2, 23),
(55, 2, 3, 24),
(56, 2, 4, 25),
(57, 2, 5, 26),
(58, 2, 6, 27),
(59, 2, 7, 28);


/*Vista para obtener mes con su respectivos días*/
CREATE VIEW vistaMesDia AS
SELECT meses.id AS idMes, meses.nombre AS nombreMes, meses.created_at as fecha_mes,
mes_dia.id idMesDia, mes_dia.numero_dia,
dias.nombre AS nombreDia, dias.status AS status_dia, dias.created_at AS fecha_dia
FROM mes_dia  
LEFT OUTER jOIN dias ON mes_dia.dia_id = dias.id
LEFT OUTER jOIN meses ON mes_dia.mes_id = meses.id
ORDER BY mes_dia.id ASC;

SELECT * FROM vistaMesDia;




/* Catalogo para años-------------*/
CREATE TABLE `anio` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `anio` int,
  `status` tinyint(1) default 1,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `anio` 
(`id`, `anio`, `status`, `created_at`, `updated_at`) 
VALUES 
(1, 2018, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2019, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 2010, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM anio;



/* Catalogo para entrenamiento(motor)--------------*/
CREATE TABLE `entrenamiento` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `hora` time,
  `dia_id` int(10) unsigned NOT NULL,
  `mes_id` int(10) unsigned NOT NULL,
  `anio_id` int(10) unsigned NOT NULL,/*por defecto el año actual*/
  `fecha` date,/*por defecto la actual*/
  `usuario_id` int(10) unsigned NOT NULL, /*por defecto usuario que inicio sesión solo si no eres administrador*/
  `notas` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (dia_id) REFERENCES dias(id) ON DELETE CASCADE,
  FOREIGN KEY (mes_id) REFERENCES meses(id) ON DELETE CASCADE,
  FOREIGN KEY (anio_id) REFERENCES anio(id) ON DELETE CASCADE,
  FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `entrenamiento` 
(`id`, `hora`, `dia_id`, `mes_id`, `anio_id`, `fecha`,  `usuario_id`, `notas`, `created_at`, `updated_at`) 
VALUES 
(1, "04:00:00", 1, 10, 2, "2019-09-19", 1, "", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, "04:00:00", 2, 10, 2, "2019-09-19", 2, "", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, "04:00:00", 3, 10, 2, "2019-09-19", 3, "", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM entrenamiento;


/* Catalogo para entrenamiento_ejercicio(motor)--------------*/
CREATE TABLE `entrenamiento_ejercicio` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `entrenamiento_id` int(10) unsigned NOT NULL,
  `ejercicio_id` int(10) unsigned NOT NULL,
  FOREIGN KEY (entrenamiento_id) REFERENCES entrenamiento(id) ON DELETE CASCADE,
  FOREIGN KEY (ejercicio_id) REFERENCES ejercicios(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `entrenamiento_ejercicio` 
(`id`, `entrenamiento_id`, `ejercicio_id`) 
VALUES 
(1, 1, 1),
(2, 2, 1),
(3, 3, 2);

SELECT * FROM entrenamiento_ejercicio;


/* Catalogo para tipo productos--------------*/
CREATE TABLE `tipo_producto` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `tipo` varchar(250),
  `origen` varchar(200),
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `tipo_producto` 
(`id`, `tipo`, `origen`, `created_at`, `updated_at`) 
VALUES 
(1, "fruta", "Origen frutal", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, "verdura", "Origen vegetal", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, "carne", "Origen animal", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, "cereal", "Origen vegetal", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, "Legumbre", "Origen vegetal", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM tipo_producto;

/* Catalogo para productos--------------*/
/*
 * Se va registrar la comida por pieza o gramos, ejemplo 1 huevo tiene tanta proteina y grasa
 * 100 g de avena tiene tal proteina o grasa
 * y asi desde el front se va realizar la operación, si eleige 3 huevos ps se multiplva la proteina de 1 huevo por 3
*/
CREATE TABLE `productos` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(250),
  `tipo_producto_id` int(10) unsigned NOT NULL,
  `porcion_o_gramos` double,/*aqui se agrega la porcion o gramos*/
  `proteina` double,
  `calorias` double,
  `grasas` double,
  `proteina_completa` tinyint(1),
  `notas` text,
  `status` tinyint(1) default 1,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (tipo_producto_id) REFERENCES tipo_producto(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `productos` 
(`id`, `nombre`, `tipo_producto_id`, `porcion_o_gramos`, `proteina`,  `calorias`, `grasas`, `proteina_completa`, `notas`, `status`, `created_at`, `updated_at`) 
VALUES 
(1, "huevo", 3, 1, 8, 25, 4, 1, "Proteina de origen animal", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, "avena", 4, 100, 30, 95, 0, 0, "Proteina de origen vegetal(no es una proteina completa)", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM productos;


/* Catalogo para comidas del día--------------*/
CREATE TABLE `comidas_dia` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `descripcion` varchar(250),
  `hora` time,
  `notas` text,
  `status` tinyint(1) default 1,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `comidas_dia` 
(`id`, `descripcion`, `hora`, `notas`,`status`, `created_at`, `updated_at`) 
VALUES 
(1, "vitaminas", "04:00:00", "vitaminas en ayunas", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, "desayuno", "04:00:00", "primera comida", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, "colación", "04:00:00", "colacion a medio dia", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, "comida", "04:00:00", "comida", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, "colacion", "04:00:00", "colacion por la tarde", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, "cena", "04:00:00", "cena", 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM comidas_dia;



/* Catalogo para producto_comida_dia_a_dia--------------*/
CREATE TABLE `producto_comida_dia_a_dia` (
  `id` int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `fecha` date,
  `producto_id` int(10) unsigned NOT NULL,
  `dia_id` int(10) unsigned NOT NULL,
  `comidas_dia_id` int(10) unsigned NOT NULL,
  `usuario_id` int(10) unsigned NOT NULL,
  `notas` text, /*por defecto usuario que inicio sesión solo si no eres administrador*/
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
  FOREIGN KEY (dia_id) REFERENCES dias(id) ON DELETE CASCADE,
  FOREIGN KEY (comidas_dia_id) REFERENCES comidas_dia(id) ON DELETE CASCADE,
  FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `producto_comida_dia_a_dia` 
(`id`, `fecha`, `producto_id`, `dia_id`, `comidas_dia_id`, `usuario_id`,  `notas`, `created_at`, `updated_at`) 
VALUES 
(1, "2019-09-19", 1, 1, 2, 1, "", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, "2019-09-19", 2, 1, 3, 1, "", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, "2019-09-19", 1, 1, 4, 1, "", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM producto_comida_dia_a_dia;

DROP VIEW IF EXISTS vistaComidasDias;
/*Vista para obtener las comidas del día*/
CREATE VIEW vistaComidasDias AS
SELECT producto_comida_dia_a_dia.id as idProductoComidaDia, producto_comida_dia_a_dia.fecha as fechaComida,
dias.nombre AS nombreDia, dias.created_at AS fecha_dia,
comidas_dia.descripcion AS descripcionComida, comidas_dia.hora, comidas_dia.notas AS notasComida,
productos.id AS idProducto, productos.nombre AS nombreProducto, tipo_producto.tipo AS tipoProducto, tipo_producto.origen AS tipoProductoOrigen, productos.porcion_o_gramos, productos.proteina, productos.calorias, productos.grasas, productos.proteina_completa, productos.notas AS notasProdcuto
FROM producto_comida_dia_a_dia  
LEFT OUTER jOIN productos ON producto_comida_dia_a_dia.producto_id = productos.id
LEFT OUTER jOIN dias ON producto_comida_dia_a_dia.dia_id = dias.id
LEFT OUTER jOIN comidas_dia ON producto_comida_dia_a_dia.comidas_dia_id = comidas_dia.id
LEFT OUTER jOIN tipo_producto ON productos.tipo_producto_id = tipo_producto.id
ORDER BY producto_comida_dia_a_dia.id ASC;


SELECT * FROM vistaComidasDias;
