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

