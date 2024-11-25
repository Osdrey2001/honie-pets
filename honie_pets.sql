-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-11-2024 a las 13:19:49
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `honie pets`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_peluqueria` (`id_cambio` INT, `nombre` VARCHAR(45), `direccion` VARCHAR(45), `telefono` VARCHAR(20), `email` VARCHAR(45), `horarios` VARCHAR(65), `tipo` VARCHAR(45))   BEGIN
UPDATE peluqueria
SET pelu_nombre=nombre, pelu_direccion=direccion, pelu_telefono=telefono, pelu_email=email, pelu_horarios=horarios, pelu_tipo=tipo
WHERE pelu_id=id_cambio;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_usuario` (`id_eliminar` INT)   BEGIN
DELETE FROM usuario
WHERE usuario.usu_id=id_eliminar;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_veterinaria` (`nombre` VARCHAR(45), `direccion` VARCHAR(45), `telefono` VARCHAR(20), `horario` VARCHAR(45), `especialidad` VARCHAR(45))   BEGIN
INSERT INTO veterinaria (vet_nombre, vet_direccion, vet_telefono, vet_horario, vet_especialidad)
VALUES (nombre, direccion, telefono, horario, especialidad);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_contacto_usuario_servicios_peluqueria` ()   BEGIN
SELECT  usu_nombre, usu_email, usu_telefono, serv_nombre, serv_categoria, serv_descripcion, pelu_nombre, pelu_direccion, pelu_telefono, pelu_email
FROM usuario
JOIN servicios_has_usuarios
ON usuario.usu_id = servicios_has_usuarios.copia_usu_id
JOIN servicio 
ON servicio.serv_id = servicios_has_usuarios.copia_serv_id 
JOIN peluqueria_has_servicio 
ON servicio.serv_id = peluqueria_has_servicio.copia_serv_id 
JOIN peluqueria 
ON peluqueria.pelu_id = peluqueria_has_servicio.copia_pelu_id; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_dueños_mascotas` ()   BEGIN
SELECT usu_nombre, usu_telefono, usu_direccion, mascota_nombre, mascota_raza, mascota_genero, mascota_edad
FROM usuario
INNER JOIN mascota
ON usuario.usu_id=mascota.usu_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `adopcion`
--

CREATE TABLE `adopcion` (
  `adop_id` int(11) NOT NULL,
  `adop_estado` varchar(45) DEFAULT NULL,
  `adop_fecha` date DEFAULT NULL,
  `mascota_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `adopcion`
--

INSERT INTO `adopcion` (`adop_id`, `adop_estado`, `adop_fecha`, `mascota_id`) VALUES
(1, 'En adopcion', '2024-10-11', 1),
(2, 'N/A', '2024-10-11', 2),
(3, 'N/A', '2024-10-12', 3),
(4, 'N/A', '2024-10-13', 4),
(5, 'N/A', '2024-10-14', 5),
(6, 'N/A', '2024-10-15', 6),
(7, 'N/A', '2024-10-16', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agendamiento_cita`
--

CREATE TABLE `agendamiento_cita` (
  `cita_id` int(11) NOT NULL,
  `cita_fecha` date DEFAULT NULL,
  `cita_hora` time DEFAULT NULL,
  `cita_anotaciones` varchar(45) DEFAULT NULL,
  `mascota_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `agendamiento_cita`
--

INSERT INTO `agendamiento_cita` (`cita_id`, `cita_fecha`, `cita_hora`, `cita_anotaciones`, `mascota_id`) VALUES
(1, '2024-10-11', '17:03:44', 'Anotaciones acerca de la cita traer bosal', 1),
(2, '2024-10-11', '17:03:44', 'Anotaciones acerca de la cita traer al gato e', 2),
(3, '2024-10-12', '17:03:44', 'Anotaciones acerca de la cita traer bosal', 3),
(4, '2024-10-13', '17:03:44', 'Anotaciones acerca de la cita traer bosal', 4),
(5, '2024-10-14', '17:03:44', 'Anotaciones acerca de la cita traer algo', 5),
(6, '2024-10-15', '17:03:44', 'Anotaciones acerca de la cita bosal', 6),
(7, '2024-10-16', '17:03:44', 'Anotaciones acerca de la cita bosal', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria_producto`
--

CREATE TABLE `auditoria_producto` (
  `audprod_id` int(11) NOT NULL,
  `prod_id` int(11) DEFAULT NULL,
  `prod_nombre_anterior` varchar(45) DEFAULT NULL,
  `prod_precio_anterior` float DEFAULT NULL,
  `prod_categoria_anterior` varchar(45) DEFAULT NULL,
  `prod_descripcion_anterior` varchar(45) DEFAULT NULL,
  `prod_nombre_nuevo` varchar(45) DEFAULT NULL,
  `prod_precio_nuevo` float DEFAULT NULL,
  `prod_categoria_nuevo` varchar(45) DEFAULT NULL,
  `prod_descripcion_nuevo` varchar(45) DEFAULT NULL,
  `audi_fecha` datetime DEFAULT NULL,
  `audi_usuario` varchar(10) DEFAULT NULL,
  `audi_accion` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificaciones_opiniones`
--

CREATE TABLE `calificaciones_opiniones` (
  `calop_id` int(11) NOT NULL,
  `calop_calificacion` int(5) DEFAULT NULL,
  `calop_comentario` varchar(45) DEFAULT NULL,
  `calop_fecha` date DEFAULT NULL,
  `copia_serv_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calificaciones_opiniones`
--

INSERT INTO `calificaciones_opiniones` (`calop_id`, `calop_calificacion`, `calop_comentario`, `calop_fecha`, `copia_serv_id`) VALUES
(1, 3, 'Sin comentarios', '2024-10-11', 2),
(2, 4, 'Muy buen servicio', '2024-10-12', 3),
(3, 1, 'Sin comentarios', '2024-10-13', 1),
(4, 3, 'La atencion deja que desear', '2024-10-14', 4),
(5, 5, 'Sin comentarios', '2024-10-15', 7),
(6, 3, 'Servicio regular', '2024-10-16', 5),
(7, 2, 'Sin comentarios', '2024-10-17', 6);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `citas_programadas_veterinaria`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `citas_programadas_veterinaria` (
`mascota_nombre` varchar(45)
,`cita_fecha` date
,`cita_hora` time
,`cita_anotaciones` varchar(45)
,`vet_nombre` varchar(45)
,`vet_direccion` varchar(45)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escuela`
--

CREATE TABLE `escuela` (
  `escuela_id` int(11) NOT NULL,
  `escuela_nombre` varchar(45) DEFAULT NULL,
  `escuela_direccion` varchar(45) DEFAULT NULL,
  `escuela_telefono` varchar(20) DEFAULT NULL,
  `escuela_email` varchar(45) DEFAULT NULL,
  `escuela_tipo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `escuela`
--

INSERT INTO `escuela` (`escuela_id`, `escuela_nombre`, `escuela_direccion`, `escuela_telefono`, `escuela_email`, `escuela_tipo`) VALUES
(1, 'Mascotas Entrenadas', 'carrera 148', '3105246598', 'Masct@gmail.com', 'Escuela de entrenamiento canino'),
(2, 'Paco mascotas', 'carrera 63', '3214568520', 'Paco@gmail.com', 'Escuela de gatos'),
(3, 'Escuela de mascotas Juan', 'carrera 42', '3521541215', 'Juan@gmail.com', 'Escuela de entrenamiento canino'),
(4, 'Training pets', 'carrera 85', '3214567410', 'TraPet@gmail.com', 'Escuela de perros para terapia'),
(5, 'Mascotas obedientes', 'carrera 52', '3215278495', 'Masob@gmail.com', 'Escuela de animales exoticos'),
(6, 'Pets school', 'carrera 24', '3105623410', 'Petschol@gmail.com', 'Escuela de gatos'),
(7, 'Pets university', 'carrera 65', '3136542982', 'Petsu@gmail.com', 'Escuela de socializacion canina');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escuela_has_servicio`
--

CREATE TABLE `escuela_has_servicio` (
  `copia_escuela_id` int(11) DEFAULT NULL,
  `copia_serv_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `escuela_has_servicio`
--

INSERT INTO `escuela_has_servicio` (`copia_escuela_id`, `copia_serv_id`) VALUES
(7, 3),
(3, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mascota`
--

CREATE TABLE `mascota` (
  `mascota_id` int(11) NOT NULL,
  `mascota_nombre` varchar(45) DEFAULT NULL,
  `mascota_raza` varchar(45) DEFAULT NULL,
  `mascota_genero` varchar(45) DEFAULT NULL,
  `mascota_edad` int(11) DEFAULT NULL,
  `usu_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mascota`
--

INSERT INTO `mascota` (`mascota_id`, `mascota_nombre`, `mascota_raza`, `mascota_genero`, `mascota_edad`, `usu_id`) VALUES
(1, 'Rex', 'Pibull', 'M', 3, 6),
(2, 'Pandora', 'Roth weiller', 'F', 2, 7),
(3, 'Poncho', 'Gato Siames', 'M', 1, 8),
(4, 'Luna', 'Pastor Caucasico', 'F', 5, 9),
(5, 'Naranja', 'Gato', 'M', 2, 10),
(6, 'Sasha', 'Chihuahua', 'F', 3, 11),
(7, 'Rosa', 'Guacamayo', 'F', 4, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `pago_id` int(11) NOT NULL,
  `pago_medio` varchar(45) DEFAULT NULL,
  `pego_num_cuenta` varchar(45) DEFAULT NULL,
  `pago_cantidad` float DEFAULT NULL,
  `pago_fecha` date DEFAULT NULL,
  `pago_estado` varchar(45) DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pago`
--

INSERT INTO `pago` (`pago_id`, `pago_medio`, `pego_num_cuenta`, `pago_cantidad`, `pago_fecha`, `pago_estado`, `venta_id`) VALUES
(1, 'Pasarelas de pago', '124913441', 60000, '2024-11-19', 'Aprobado', 1),
(2, 'Pasarelas de pago', '124124143', 56000, '2024-11-18', 'Aprobado', 2),
(3, 'Pasarelas de pago', '323534676', 15000, '2024-11-20', 'Aprobado', 3),
(4, 'Pasarelas de pago', '567564567', 30000, '2024-11-19', 'En proceso', 4),
(5, 'Pasarelas de pago', '345575777', 30000, '2024-11-20', 'Rechazado', 5),
(6, 'Pasarelas de pago', '235244567', 26400, '2024-11-19', 'Aprobado', 6),
(7, 'Pasarelas de pago', '091208348', 35000, '2024-10-19', 'Aprobado', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `peluqueria`
--

CREATE TABLE `peluqueria` (
  `pelu_id` int(11) NOT NULL,
  `pelu_nombre` varchar(45) DEFAULT NULL,
  `pelu_direccion` varchar(45) DEFAULT NULL,
  `pelu_telefono` varchar(20) DEFAULT NULL,
  `pelu_email` varchar(45) DEFAULT NULL,
  `pelu_horarios` varchar(65) DEFAULT NULL,
  `pelu_tipo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `peluqueria`
--

INSERT INTO `peluqueria` (`pelu_id`, `pelu_nombre`, `pelu_direccion`, `pelu_telefono`, `pelu_email`, `pelu_horarios`, `pelu_tipo`) VALUES
(1, 'tumascota', 'calle 63', '3214567891', 'osda@gmail.com', '7am a 8pm', 'Solo gatos'),
(2, 'Tijeritas', 'Calle 351', '3214548754', 'tras@gmail.com', '8AM a 7PM', 'De lujo'),
(3, 'Mascota nueva', 'Calle 256', '3102165465', 'tras@gmail.com', '8AM a 7PM', 'Simple'),
(4, 'Salon de belleza Perruno', 'Calle 757', '3215648155', 'tras@gmail.com', '6AM a 7PM', 'Todo tipo de mascotas'),
(5, 'Salon pets', 'Calle 184', '3105687511', 'tras@gmail.com', '8AM a 7PM', 'De lujo'),
(6, 'Mascotitas', 'Carrera 101', '3214152548', 'tras@gmail.com', '8AM a 10PM', 'Simple'),
(7, 'New styles', 'Carrera 582', '3112556451', 'tras@gmail.com', '10AM a 7PM', 'De lujo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `peluqueria_has_servicio`
--

CREATE TABLE `peluqueria_has_servicio` (
  `copia_pelu_id` int(11) DEFAULT NULL,
  `copia_serv_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `peluqueria_has_servicio`
--

INSERT INTO `peluqueria_has_servicio` (`copia_pelu_id`, `copia_serv_id`) VALUES
(5, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `prod_id` int(11) NOT NULL,
  `prod_nombre` varchar(45) DEFAULT NULL,
  `prod_precio` float DEFAULT NULL,
  `prod_categoria` varchar(45) DEFAULT NULL,
  `prod_descripcion` varchar(45) DEFAULT NULL,
  `vet_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`prod_id`, `prod_nombre`, `prod_precio`, `prod_categoria`, `prod_descripcion`, `vet_id`) VALUES
(1, 'Cepillo para perros', 20000, 'Accesorios', 'Collar negro de 2 mt para perros', 1),
(2, 'Shampoo para gatos', 30000, 'Producto de higiene', 'Shampoo especial para gatos', 2),
(3, 'Correa para gatos', 15000, 'Accesorios', 'Correa roja para gatos', 3),
(4, 'Jabon', 10000, 'Producto de higiene', 'Jabon para mascotas', 4),
(5, 'Collar antipulgas', 17500, 'Accesorios', 'Collar antipulgas para perros de color veige', 1),
(6, 'Gotas para los ojos', 13200, 'Medicamentos', 'Gotas para los ojos de los gatos', 2),
(7, 'Medicinas para mascotas', 28000, 'Medicamentos', 'Meidcinas varias', 6);

--
-- Disparadores `producto`
--
DELIMITER $$
CREATE TRIGGER `producto_before_insert` BEFORE INSERT ON `producto` FOR EACH ROW INSERT INTO auditoria_producto(
    prod_id,
    prod_nombre_nuevo,
    prod_precio_nuevo,
    prod_categoria_nuevo,
    prod_descripcion_nuevo,
    audi_fecha,
    audi_usuario,
    audi_accion)
VALUES(
    new.prod_id,
    new.prod_nombre,
    new.prod_precio,
    new.prod_categoria,
    new.prod_descripcion,
    NOW(),
    USER(),
    'Insertar')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `producto_before_update` BEFORE UPDATE ON `producto` FOR EACH ROW INSERT INTO auditoria_producto(
    prod_id,
    prod_nombre_anterior,
    prod_precio_anterior,
    prod_categoria_anterior,
    prod_descripcion_anterior,
    prod_nombre_nuevo,
    prod_precio_nuevo,
    prod_categoria_nuevo,
    prod_descripcion_nuevo,
    audi_fecha,
    audi_usuario,
    audi_accion)
VALUES(
    new.prod_id,
    old.prod_nombre,
    old.prod_precio,
    old.prod_categoria,
    old.prod_descripcion,
    new.prod_nombre,
    new.prod_precio,
    new.prod_categoria,
    new.prod_descripcion,
    NOW(),
    USER(),
    'Actualizar')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `productos_vendidos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `productos_vendidos` (
`prod_nombre` varchar(45)
,`prod_precio` float
,`prod_categoria` varchar(45)
,`venta_unidades` int(11)
,`venta_fecha` date
,`venta_hora` time
,`venta_valor_total` float
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

CREATE TABLE `servicio` (
  `serv_id` int(11) NOT NULL,
  `serv_nombre` varchar(45) DEFAULT NULL,
  `serv_categoria` varchar(45) DEFAULT NULL,
  `serv_descripcion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicio`
--

INSERT INTO `servicio` (`serv_id`, `serv_nombre`, `serv_categoria`, `serv_descripcion`) VALUES
(1, 'Servicios veterinarios', 'Servicios Veterinarios', 'Clinica veterinaria para el cuidado de la salud de las mascotas'),
(2, 'Antencion de urgencias', 'Servicios Veterinarios', 'Clinica veterinaria para atencion inmediata de situaciones de salud graves en las mascotas'),
(3, 'Entrenamiento de mascotas', 'Escuelas Para Mascotas', 'Escuela de entrenamiento para mascotas y dueños'),
(4, 'Servicios veterinarios a domicilio', 'Servicios Veterinarios', 'Veterinario con experiencia especializado en el cuidado de la salud de las mascotas domesticas'),
(5, 'Atencion canina especializada', 'Servicios Veterinarios', 'Clinica veterinaria especializada en la atencion canina con muchos años de experiencia cuidando la salud de tus mascotas'),
(6, 'Peluqueria de mascotas', 'Peluquerias Para Mascotas', 'Peluqueria especializada en el corte y estilismo de tus mascotas domesticas'),
(7, 'Entrenamiento de sociabilidad para perros', 'Escuelas Para Mascotas', 'Escuela para mascotas de gran calidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios_has_usuarios`
--

CREATE TABLE `servicios_has_usuarios` (
  `copia_serv_id` int(11) DEFAULT NULL,
  `copia_usu_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicios_has_usuarios`
--

INSERT INTO `servicios_has_usuarios` (`copia_serv_id`, `copia_usu_id`) VALUES
(1, 3),
(2, 3),
(5, 3),
(3, 4),
(7, 4),
(6, 5),
(4, 13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

CREATE TABLE `tipo_usuario` (
  `tipo_id` int(11) NOT NULL,
  `tipo_usuario` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`tipo_id`, `tipo_usuario`) VALUES
(1, 'Superadministrador'),
(2, 'Administrador veterinaria'),
(3, 'Cliente'),
(4, 'Veterinario'),
(5, 'Escuelas'),
(6, 'Peluquerias'),
(7, 'Veterinario-doctor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usu_id` int(11) NOT NULL,
  `usu_nombre` varchar(45) DEFAULT NULL,
  `usu_direccion` varchar(45) DEFAULT NULL,
  `usu_email` varchar(45) DEFAULT NULL,
  `usu_telefono` varchar(20) DEFAULT NULL,
  `usu_cuenta` varchar(30) DEFAULT NULL,
  `usu_contraseña` varchar(20) DEFAULT NULL,
  `tipo_usuario_tipo_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usu_id`, `usu_nombre`, `usu_direccion`, `usu_email`, `usu_telefono`, `usu_cuenta`, `usu_contraseña`, `tipo_usuario_tipo_id`) VALUES
(1, 'Felipe Castañeda', 'calle76', 'Fcastañeda@example.com', '3526789156', '4456412485657', 'F1234', 1),
(2, 'Jhoana Castro', 'calle16-8', 'Jcastro@example.com', '3226547893', '5446556545654', 'J6548', 2),
(3, 'Valentina Alonso', 'Carrera 16-8', 'Valosnos@example.com', '3204567896', '545118955', 'V54489', 4),
(4, 'Emmanuel Garcia', ' calle 13-889c', 'Egarcia@example.com', '31956478955', '541815648945', 'E455664', 5),
(5, 'Andrea Vergara', 'Carrera 56- 1c', 'Avergara@example.com', ' 3135689756', '556465156', 'Akme425', 6),
(6, 'Nicol lopez', 'calle 36', 'Nbuitrago@example.com', '3102348531', '56666885', 'Mdfsf54', 3),
(7, 'carol Buitrago', 'calle 26', 'carol@example.com', '3155367895', '566545', 'N4JF4', 3),
(8, 'Natalia Pavon', 'calle 46', 'pavon@example.com', '3114356743', '5222845', 'JDAF54', 3),
(9, 'Camila Gomez', 'calle 66', 'camigomez@example.com', '3123123456', '51114845', 'FGG154', 3),
(10, 'Juan Perez', 'calle 76', 'juan@example.com', '3214632423', '5661345', 'NURF4', 3),
(11, 'Santiago Leon', ' Av 16-99', 'santi@example.com', '3115564265', '54331441', 'FFSF54', 3),
(12, 'Camilo Pedraza', ' Av 16-129', 'cami@example.com', '3195653465', '54541', 'Sgfg4', 3),
(13, 'Daniela Niño', 'calle236', 'danielan@example.com', '3523489156', '4413134485657', 'Ff234', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `venta_id` int(11) NOT NULL,
  `venta_unidades` int(11) DEFAULT NULL,
  `venta_fecha` date DEFAULT NULL,
  `venta_hora` time DEFAULT NULL,
  `venta_valor_total` float DEFAULT NULL,
  `venta_descripcion` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`venta_id`, `venta_unidades`, `venta_fecha`, `venta_hora`, `venta_valor_total`, `venta_descripcion`) VALUES
(1, 3, '2024-11-19', '16:36:23', 60000, 'Descripcion de la venta'),
(2, 2, '2024-11-18', '16:36:23', 56000, 'Descripcion de la venta'),
(3, 1, '2024-11-20', '16:36:23', 15000, 'Descripcion de la venta'),
(4, 1, '2024-11-19', '16:36:23', 30000, 'Descripcion de la venta'),
(5, 1, '2024-11-20', '16:36:23', 30000, 'Descripcion de la venta'),
(6, 2, '2024-11-19', '16:36:23', 26400, 'Descripcion de la venta'),
(7, 2, '2024-10-19', '16:36:23', 35000, 'Descripcion de la venta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_has_producto`
--

CREATE TABLE `venta_has_producto` (
  `copia_venta_id` int(11) DEFAULT NULL,
  `copia_prod_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `venta_has_producto`
--

INSERT INTO `venta_has_producto` (`copia_venta_id`, `copia_prod_id`) VALUES
(1, 1),
(2, 7),
(3, 3),
(4, 2),
(5, 2),
(6, 6),
(7, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `veterinaria`
--

CREATE TABLE `veterinaria` (
  `vet_id` int(11) NOT NULL,
  `vet_nombre` varchar(45) DEFAULT NULL,
  `vet_direccion` varchar(45) DEFAULT NULL,
  `vet_telefono` varchar(20) DEFAULT NULL,
  `vet_horario` varchar(45) DEFAULT NULL,
  `vet_especialidad` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `veterinaria`
--

INSERT INTO `veterinaria` (`vet_id`, `vet_nombre`, `vet_direccion`, `vet_telefono`, `vet_horario`, `vet_especialidad`) VALUES
(1, 'Maspet', 'Calle 93 ', '3214856475', '12AM a 6PM', 'Mascotas domesticas'),
(2, 'Healpet', 'Calle 58', '32114574859', '8AM a 7PM', 'Mascotas exoticas'),
(3, 'Mundo Mascotas', 'Calle 25', '3102564589', '8AM a 7PM', 'Aves'),
(4, 'Love pets', 'Calle 75', '3215648958', '6AM a 7PM', 'Equinos'),
(5, 'Petsian', 'Calle 18', '3105687596', '8AM a 7PM', 'Todo'),
(6, 'Veterinaria Don Juan', 'Carrera 10', '3214152563', '8AM a 10PM', 'Mascotas domesticas'),
(7, 'Pet mas', 'Carrera 58', '3112562351', '10AM a 7PM', 'Mascotas exoticas'),
(8, 'petmed', 'calle 80', '3214567891', '8am a 8pm', 'Mascotas Exóticas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `veterinaria_has_agendamiento_cita`
--

CREATE TABLE `veterinaria_has_agendamiento_cita` (
  `copia_vet_id` int(11) DEFAULT NULL,
  `copia_cita_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `veterinaria_has_agendamiento_cita`
--

INSERT INTO `veterinaria_has_agendamiento_cita` (`copia_vet_id`, `copia_cita_id`) VALUES
(1, 7),
(2, 6),
(3, 5),
(4, 4),
(6, 2),
(7, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `veterinaria_has_servicio`
--

CREATE TABLE `veterinaria_has_servicio` (
  `copia_vet_id` int(11) DEFAULT NULL,
  `copia_serv_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `veterinaria_has_servicio`
--

INSERT INTO `veterinaria_has_servicio` (`copia_vet_id`, `copia_serv_id`) VALUES
(3, 1),
(5, 2),
(7, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `veterinario_doctor`
--

CREATE TABLE `veterinario_doctor` (
  `vetdoc_id` int(11) NOT NULL,
  `vetdoc_nombre` varchar(45) DEFAULT NULL,
  `vetdoc_telefono` varchar(20) DEFAULT NULL,
  `vetdoc_email` varchar(45) DEFAULT NULL,
  `vetdoc_direccion` varchar(45) DEFAULT NULL,
  `vetdoc_especialidad` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `veterinario_doctor`
--

INSERT INTO `veterinario_doctor` (`vetdoc_id`, `vetdoc_nombre`, `vetdoc_telefono`, `vetdoc_email`, `vetdoc_direccion`, `vetdoc_especialidad`) VALUES
(1, 'Juan Gomez', '3104859645', 'Juan@gmail.com', 'carrera 122', 'Dermatologia'),
(2, 'Jhon Gomez', '3214567891', 'Jhon@gmail.com', 'carrera 132', 'Cirugia'),
(3, 'Jason Alberto', '3215632145', 'Jason@gmail.com', 'carrera 152', 'Medicina interna'),
(4, 'Sara Lopez', '3105263456', 'Sara@gmail.com', 'carrera 72', 'Cardiologia'),
(5, 'Logan Paul', '3215624789', 'Logan@gmail.com', 'carrera 62', 'Odontologia'),
(6, 'Mike Tyson', '3216549685', 'Mike@gmail.com', 'carrera 92', 'Medicina Reproductiva'),
(7, 'Maria Perez', '3134578452', 'Maria@gmail.com', 'carrera 54', 'Oncologia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `veterinario_doctor_has_agendamiento_cita`
--

CREATE TABLE `veterinario_doctor_has_agendamiento_cita` (
  `copia_vetdoc_id` int(11) DEFAULT NULL,
  `copia_cita_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `veterinario_doctor_has_agendamiento_cita`
--

INSERT INTO `veterinario_doctor_has_agendamiento_cita` (`copia_vetdoc_id`, `copia_cita_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `veterinario_doctor_has_servicio`
--

CREATE TABLE `veterinario_doctor_has_servicio` (
  `copia_vetdoc_id` int(11) DEFAULT NULL,
  `copia_serv_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `veterinario_doctor_has_servicio`
--

INSERT INTO `veterinario_doctor_has_servicio` (`copia_vetdoc_id`, `copia_serv_id`) VALUES
(2, 4);

-- --------------------------------------------------------

--
-- Estructura para la vista `citas_programadas_veterinaria`
--
DROP TABLE IF EXISTS `citas_programadas_veterinaria`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `citas_programadas_veterinaria`  AS SELECT `mascota`.`mascota_nombre` AS `mascota_nombre`, `agendamiento_cita`.`cita_fecha` AS `cita_fecha`, `agendamiento_cita`.`cita_hora` AS `cita_hora`, `agendamiento_cita`.`cita_anotaciones` AS `cita_anotaciones`, `veterinaria`.`vet_nombre` AS `vet_nombre`, `veterinaria`.`vet_direccion` AS `vet_direccion` FROM (((`mascota` join `agendamiento_cita` on(`mascota`.`mascota_id` = `agendamiento_cita`.`mascota_id`)) join `veterinaria_has_agendamiento_cita` on(`agendamiento_cita`.`cita_id` = `veterinaria_has_agendamiento_cita`.`copia_cita_id`)) join `veterinaria` on(`veterinaria_has_agendamiento_cita`.`copia_vet_id` = `veterinaria`.`vet_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `productos_vendidos`
--
DROP TABLE IF EXISTS `productos_vendidos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `productos_vendidos`  AS SELECT `producto`.`prod_nombre` AS `prod_nombre`, `producto`.`prod_precio` AS `prod_precio`, `producto`.`prod_categoria` AS `prod_categoria`, `venta`.`venta_unidades` AS `venta_unidades`, `venta`.`venta_fecha` AS `venta_fecha`, `venta`.`venta_hora` AS `venta_hora`, `venta`.`venta_valor_total` AS `venta_valor_total` FROM ((`producto` join `venta_has_producto` on(`producto`.`prod_id` = `venta_has_producto`.`copia_prod_id`)) join `venta` on(`venta_has_producto`.`copia_venta_id` = `venta`.`venta_id`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `adopcion`
--
ALTER TABLE `adopcion`
  ADD PRIMARY KEY (`adop_id`),
  ADD KEY `mascota_id` (`mascota_id`),
  ADD KEY `estado_adopcion` (`adop_estado`);

--
-- Indices de la tabla `agendamiento_cita`
--
ALTER TABLE `agendamiento_cita`
  ADD PRIMARY KEY (`cita_id`),
  ADD KEY `mascota_id` (`mascota_id`);

--
-- Indices de la tabla `auditoria_producto`
--
ALTER TABLE `auditoria_producto`
  ADD PRIMARY KEY (`audprod_id`);

--
-- Indices de la tabla `calificaciones_opiniones`
--
ALTER TABLE `calificaciones_opiniones`
  ADD PRIMARY KEY (`calop_id`),
  ADD KEY `copia_serv_id` (`copia_serv_id`);

--
-- Indices de la tabla `escuela`
--
ALTER TABLE `escuela`
  ADD PRIMARY KEY (`escuela_id`);

--
-- Indices de la tabla `escuela_has_servicio`
--
ALTER TABLE `escuela_has_servicio`
  ADD KEY `copia_escuela_id` (`copia_escuela_id`),
  ADD KEY `copia_serv_id` (`copia_serv_id`);

--
-- Indices de la tabla `mascota`
--
ALTER TABLE `mascota`
  ADD PRIMARY KEY (`mascota_id`),
  ADD KEY `usu_id` (`usu_id`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`pago_id`),
  ADD KEY `venta_id` (`venta_id`);

--
-- Indices de la tabla `peluqueria`
--
ALTER TABLE `peluqueria`
  ADD PRIMARY KEY (`pelu_id`);

--
-- Indices de la tabla `peluqueria_has_servicio`
--
ALTER TABLE `peluqueria_has_servicio`
  ADD KEY `copia_pelu_id` (`copia_pelu_id`),
  ADD KEY `copia_serv_id` (`copia_serv_id`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`prod_id`),
  ADD KEY `vet_id` (`vet_id`);

--
-- Indices de la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`serv_id`);

--
-- Indices de la tabla `servicios_has_usuarios`
--
ALTER TABLE `servicios_has_usuarios`
  ADD KEY `copia_serv_id` (`copia_serv_id`),
  ADD KEY `copia_usu_id` (`copia_usu_id`);

--
-- Indices de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`tipo_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usu_id`),
  ADD KEY `tipo_usuario_tipo_id` (`tipo_usuario_tipo_id`),
  ADD KEY `usuario_cuenta` (`usu_cuenta`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`venta_id`);

--
-- Indices de la tabla `venta_has_producto`
--
ALTER TABLE `venta_has_producto`
  ADD KEY `copia_venta_id` (`copia_venta_id`),
  ADD KEY `copia_prod_id` (`copia_prod_id`);

--
-- Indices de la tabla `veterinaria`
--
ALTER TABLE `veterinaria`
  ADD PRIMARY KEY (`vet_id`);

--
-- Indices de la tabla `veterinaria_has_agendamiento_cita`
--
ALTER TABLE `veterinaria_has_agendamiento_cita`
  ADD KEY `copia_vet_id` (`copia_vet_id`),
  ADD KEY `copia_cita_id` (`copia_cita_id`);

--
-- Indices de la tabla `veterinaria_has_servicio`
--
ALTER TABLE `veterinaria_has_servicio`
  ADD KEY `copia_vet_id` (`copia_vet_id`),
  ADD KEY `copia_serv_id` (`copia_serv_id`);

--
-- Indices de la tabla `veterinario_doctor`
--
ALTER TABLE `veterinario_doctor`
  ADD PRIMARY KEY (`vetdoc_id`);

--
-- Indices de la tabla `veterinario_doctor_has_agendamiento_cita`
--
ALTER TABLE `veterinario_doctor_has_agendamiento_cita`
  ADD KEY `copia_vetdoc_id` (`copia_vetdoc_id`),
  ADD KEY `copia_cita_id` (`copia_cita_id`);

--
-- Indices de la tabla `veterinario_doctor_has_servicio`
--
ALTER TABLE `veterinario_doctor_has_servicio`
  ADD KEY `copia_vetdoc_id` (`copia_vetdoc_id`),
  ADD KEY `copia_serv_id` (`copia_serv_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `adopcion`
--
ALTER TABLE `adopcion`
  MODIFY `adop_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `agendamiento_cita`
--
ALTER TABLE `agendamiento_cita`
  MODIFY `cita_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `auditoria_producto`
--
ALTER TABLE `auditoria_producto`
  MODIFY `audprod_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `calificaciones_opiniones`
--
ALTER TABLE `calificaciones_opiniones`
  MODIFY `calop_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `escuela`
--
ALTER TABLE `escuela`
  MODIFY `escuela_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `mascota`
--
ALTER TABLE `mascota`
  MODIFY `mascota_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `pago_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `peluqueria`
--
ALTER TABLE `peluqueria`
  MODIFY `pelu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `prod_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `servicio`
--
ALTER TABLE `servicio`
  MODIFY `serv_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  MODIFY `tipo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `venta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `veterinaria`
--
ALTER TABLE `veterinaria`
  MODIFY `vet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `veterinario_doctor`
--
ALTER TABLE `veterinario_doctor`
  MODIFY `vetdoc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `adopcion`
--
ALTER TABLE `adopcion`
  ADD CONSTRAINT `adopcion_ibfk_1` FOREIGN KEY (`mascota_id`) REFERENCES `mascota` (`mascota_id`);

--
-- Filtros para la tabla `agendamiento_cita`
--
ALTER TABLE `agendamiento_cita`
  ADD CONSTRAINT `agendamiento_cita_ibfk_1` FOREIGN KEY (`mascota_id`) REFERENCES `mascota` (`mascota_id`);

--
-- Filtros para la tabla `calificaciones_opiniones`
--
ALTER TABLE `calificaciones_opiniones`
  ADD CONSTRAINT `calificaciones_opiniones_ibfk_1` FOREIGN KEY (`copia_serv_id`) REFERENCES `servicio` (`serv_id`);

--
-- Filtros para la tabla `escuela_has_servicio`
--
ALTER TABLE `escuela_has_servicio`
  ADD CONSTRAINT `escuela_has_servicio_ibfk_1` FOREIGN KEY (`copia_escuela_id`) REFERENCES `escuela` (`escuela_id`),
  ADD CONSTRAINT `escuela_has_servicio_ibfk_2` FOREIGN KEY (`copia_serv_id`) REFERENCES `servicio` (`serv_id`);

--
-- Filtros para la tabla `mascota`
--
ALTER TABLE `mascota`
  ADD CONSTRAINT `mascota_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`);

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`venta_id`);

--
-- Filtros para la tabla `peluqueria_has_servicio`
--
ALTER TABLE `peluqueria_has_servicio`
  ADD CONSTRAINT `peluqueria_has_servicio_ibfk_1` FOREIGN KEY (`copia_pelu_id`) REFERENCES `peluqueria` (`pelu_id`),
  ADD CONSTRAINT `peluqueria_has_servicio_ibfk_2` FOREIGN KEY (`copia_serv_id`) REFERENCES `servicio` (`serv_id`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`vet_id`) REFERENCES `veterinaria` (`vet_id`);

--
-- Filtros para la tabla `servicios_has_usuarios`
--
ALTER TABLE `servicios_has_usuarios`
  ADD CONSTRAINT `servicios_has_usuarios_ibfk_1` FOREIGN KEY (`copia_serv_id`) REFERENCES `servicio` (`serv_id`),
  ADD CONSTRAINT `servicios_has_usuarios_ibfk_2` FOREIGN KEY (`copia_usu_id`) REFERENCES `usuario` (`usu_id`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`tipo_usuario_tipo_id`) REFERENCES `tipo_usuario` (`tipo_id`);

--
-- Filtros para la tabla `venta_has_producto`
--
ALTER TABLE `venta_has_producto`
  ADD CONSTRAINT `venta_has_producto_ibfk_1` FOREIGN KEY (`copia_venta_id`) REFERENCES `venta` (`venta_id`),
  ADD CONSTRAINT `venta_has_producto_ibfk_2` FOREIGN KEY (`copia_prod_id`) REFERENCES `producto` (`prod_id`);

--
-- Filtros para la tabla `veterinaria_has_agendamiento_cita`
--
ALTER TABLE `veterinaria_has_agendamiento_cita`
  ADD CONSTRAINT `veterinaria_has_agendamiento_cita_ibfk_1` FOREIGN KEY (`copia_vet_id`) REFERENCES `veterinaria` (`vet_id`),
  ADD CONSTRAINT `veterinaria_has_agendamiento_cita_ibfk_2` FOREIGN KEY (`copia_cita_id`) REFERENCES `agendamiento_cita` (`cita_id`);

--
-- Filtros para la tabla `veterinaria_has_servicio`
--
ALTER TABLE `veterinaria_has_servicio`
  ADD CONSTRAINT `veterinaria_has_servicio_ibfk_1` FOREIGN KEY (`copia_vet_id`) REFERENCES `veterinaria` (`vet_id`),
  ADD CONSTRAINT `veterinaria_has_servicio_ibfk_2` FOREIGN KEY (`copia_serv_id`) REFERENCES `servicio` (`serv_id`);

--
-- Filtros para la tabla `veterinario_doctor_has_agendamiento_cita`
--
ALTER TABLE `veterinario_doctor_has_agendamiento_cita`
  ADD CONSTRAINT `veterinario_doctor_has_agendamiento_cita_ibfk_1` FOREIGN KEY (`copia_vetdoc_id`) REFERENCES `veterinario_doctor` (`vetdoc_id`),
  ADD CONSTRAINT `veterinario_doctor_has_agendamiento_cita_ibfk_2` FOREIGN KEY (`copia_cita_id`) REFERENCES `agendamiento_cita` (`cita_id`);

--
-- Filtros para la tabla `veterinario_doctor_has_servicio`
--
ALTER TABLE `veterinario_doctor_has_servicio`
  ADD CONSTRAINT `veterinario_doctor_has_servicio_ibfk_1` FOREIGN KEY (`copia_vetdoc_id`) REFERENCES `veterinario_doctor` (`vetdoc_id`),
  ADD CONSTRAINT `veterinario_doctor_has_servicio_ibfk_2` FOREIGN KEY (`copia_serv_id`) REFERENCES `servicio` (`serv_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
