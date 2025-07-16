-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-07-2025 a las 08:57:53
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
-- Base de datos: `gimnasio`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clases`
--

CREATE TABLE `clases` (
  `id` int(11) NOT NULL,
  `id_entrenador` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `dia_semana` varchar(15) DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `duracion_minutos` int(11) DEFAULT NULL,
  `cupo_maximo` int(11) DEFAULT NULL,
  `imagen_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clases`
--

INSERT INTO `clases` (`id`, `id_entrenador`, `nombre`, `descripcion`, `dia_semana`, `hora`, `duracion_minutos`, `cupo_maximo`, `imagen_url`) VALUES
(9, 4, 'Bike', 'Clase de ciclismo indoor para mejorar resistencia cardiovascular', 'Lunes', '08:00:00', 45, 20, 'salaBikes.jpg'),
(10, 5, 'Body Dump', 'Entrenamiento de cuerpo completo con pesas y cardio', 'Martes', '19:00:00', 50, 18, 'salaBodydump.jpg'),
(11, 6, 'Yoga', 'Relajación y estiramiento con técnicas de respiración', 'Miércoles', '09:30:00', 60, 15, 'salaYoga.jpg'),
(12, 7, 'Zumba', 'Baile fitness al ritmo de música latina', 'Jueves', '18:30:00', 55, 25, 'salaZumba.jpg'),
(13, 8, 'Pilates', 'Fortalece el core, mejora tu postura y flexibilidad', 'Viernes', '10:00:00', 50, 12, 'salaPilates.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrenadores`
--

CREATE TABLE `entrenadores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `foto_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `entrenadores`
--

INSERT INTO `entrenadores` (`id`, `nombre`, `especialidad`, `email`, `foto_url`) VALUES
(4, 'Mario Sánchez', 'Bike', 'mario@bike.com', 'entrenadorBike.avif'),
(5, 'Lucía Torres', 'Body Dump', 'lucia@bodydump.com', 'entrenadorabodydump.png'),
(6, 'Paula Díaz', 'Yoga', 'paula@yoga.com', 'entrenadoraYoga.avif'),
(7, 'Jorge Ramos', 'Zumba', 'jorge@zumba.com', 'entrenadorZumba.jpg'),
(8, 'Natalia Fernández', 'Pilates', 'natalia@pilates.com', 'entrenadoraPilates.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripciones_clases`
--

CREATE TABLE `inscripciones_clases` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_clase` int(11) DEFAULT NULL,
  `fecha_inscripcion` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inscripciones_clases`
--

INSERT INTO `inscripciones_clases` (`id`, `id_usuario`, `id_clase`, `fecha_inscripcion`) VALUES
(1, 1, 9, '2025-07-07'),
(2, 2, 10, '2025-07-07'),
(3, 3, 11, '2025-07-08'),
(4, 4, 12, '2025-07-08'),
(5, 5, 13, '2025-07-08'),
(6, 6, 9, '2025-07-09'),
(7, 7, 10, '2025-07-09'),
(8, 8, 11, '2025-07-10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes_contacto`
--

CREATE TABLE `mensajes_contacto` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `fecha` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mensajes_contacto`
--

INSERT INTO `mensajes_contacto` (`id`, `nombre`, `email`, `mensaje`, `fecha`) VALUES
(1, 'sofia', 'sofia@gmail.com', 'hola, me gustaría hablar con el dueño para agradecerle la creación del gimnasio, me puedes decir cuando se pasará?', '2025-07-03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `testimonios`
--

CREATE TABLE `testimonios` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `fecha` date DEFAULT curdate(),
  `visible` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `testimonios`
--

INSERT INTO `testimonios` (`id`, `id_usuario`, `mensaje`, `fecha`, `visible`) VALUES
(1, 1, 'Me encanta el ambiente del gimnasio y las clases de yoga con Paula Díaz.', '2025-07-04', 1),
(2, 2, 'Jorge es un excelente entrenador, exigente pero motivador.', '2025-07-04', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fecha_registro` date NOT NULL DEFAULT current_timestamp(),
  `token` varchar(64) NOT NULL,
  `token_recuperacion` varchar(64) NOT NULL,
  `verificado` int(11) NOT NULL,
  `intentos_fallidos` int(11) NOT NULL,
  `bloqueado` tinyint(4) NOT NULL,
  `ultima_conexion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `email`, `password`, `fecha_registro`, `token`, `token_recuperacion`, `verificado`, `intentos_fallidos`, `bloqueado`, `ultima_conexion`) VALUES
(1, 'María', 'López', 'maria@gmail.com', '123456', '2025-07-05', '', '', 1, 0, 0, NULL),
(2, 'Javier', 'Pérez', 'javier@gmail.com', '123456', '2025-07-05', '', '', 1, 0, 0, NULL),
(3, 'marisol', 'robles', 'marisolroblesnunez@gmail.com', '$2y$10$cbApdcEMAYDaBnnjpku2SOBPhE1BWXMLWVL..2Tea24a7vakGE1RO', '2025-07-05', 'b9606fd8ab49f89b746d19c86868777615c41863ca5e97f758e43f3c9897f028', 'b901e4ff3687966ab2368b35350d5249b915e6de7493d59379749181961bf0b3', 0, 0, 0, NULL),
(4, 'Lola', 'nuñez', 'lolita@gmail.com', '$2y$10$iWbR00VCFKWF8JeceBkOiuZEazwbQXM.WehFBG6hn7cbFDYDS0DaS', '2025-07-05', '44ed923f6bde099e1779227faf116080c5876f853d43993791d999c74e1bfbf9', '', 0, 0, 0, NULL),
(5, 'Mariluz', 'ávila', 'chulita@gmail.com', '$2y$10$EsA6lyXMvRXW5Swz3CnN4eLnbCB50hBujy0ZwR3qv115oiErpuW6u', '2025-07-06', '7b22b16fe9c56c03b7ccc7bcfcbc62fed7a1790d7673e27a54ef9b206d2d3cde', '', 0, 0, 0, NULL),
(6, 'sofia', 'ayllon', 'sofia@gmail.com', '$2y$10$FJQBdxEe4dTKg0jKPHU5MecmXQTCbzyXVZ7TXhilmGSqc/SubUviK', '2025-07-06', '2d9b33d7a0851c0853ddb3c0ea5180871e85de6172ce85bb9dda6db4db7a9251', '', 0, 0, 0, NULL),
(7, 'Lorena', 'Sevilla', 'ss@gmail.com', '$2y$10$qgDi3qD2OSoktBD92zUx..EYIcHoTZcn16/8DSD0Nbz8A8lki.lBC', '2025-07-06', '', '', 1, 0, 0, '2025-07-06 00:18:06'),
(8, 'Alberto', 'Barranco', 'alberto@gmail.com', '$2y$10$s3aK4tf8F8YCerI0jwypseTlvhTytvoTFoWLfTWIy5Zhk8Ul8CzTC', '2025-07-06', '', '', 1, 0, 0, '2025-07-06 00:20:00'),
(11, '', '', 'jj@gmail.com', '$2y$10$h32f9Sijyzg3Qo5HcW7m1.p1Q6kFdCyvxhXyglm8rSNTVu5cXQD7K', '2025-07-10', 'd5f482f010c0b2a562f0e5f46d1400e0a62143a6669ef654b47609f257bbb593', '', 0, 0, 0, NULL),
(12, '', '', 'ui@gmail.com', '$2y$10$p4vYWHTRlCGjNYII8Hq6neLBbFhUY92cvcqIaOz0ywMUbNXGYGJNK', '2025-07-10', '', '', 1, 0, 0, '2025-07-11 08:41:40');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clases`
--
ALTER TABLE `clases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_entrenador` (`id_entrenador`);

--
-- Indices de la tabla `entrenadores`
--
ALTER TABLE `entrenadores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `inscripciones_clases`
--
ALTER TABLE `inscripciones_clases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cliente` (`id_usuario`),
  ADD KEY `id_clase` (`id_clase`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `mensajes_contacto`
--
ALTER TABLE `mensajes_contacto`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `testimonios`
--
ALTER TABLE `testimonios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cliente` (`id_usuario`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clases`
--
ALTER TABLE `clases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `entrenadores`
--
ALTER TABLE `entrenadores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `inscripciones_clases`
--
ALTER TABLE `inscripciones_clases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `mensajes_contacto`
--
ALTER TABLE `mensajes_contacto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `testimonios`
--
ALTER TABLE `testimonios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inscripciones_clases`
--
ALTER TABLE `inscripciones_clases`
  ADD CONSTRAINT `inscripciones_clases_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `inscripciones_clases_ibfk_2` FOREIGN KEY (`id_clase`) REFERENCES `clases` (`id`);

--
-- Filtros para la tabla `testimonios`
--
ALTER TABLE `testimonios`
  ADD CONSTRAINT `testimonios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
