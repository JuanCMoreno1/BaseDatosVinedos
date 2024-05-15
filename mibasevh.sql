/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `mibasevh` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mibasevh`;

CREATE TABLE IF NOT EXISTS `clientes1` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID de cliente',
  `id_viniedos` int NOT NULL COMMENT 'ID de viniedo',
  `Nombre` varchar(50) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Nombre de Cliente:',
  `Correo_Electro` varchar(50) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Correo Electronico:',
  `N_Telefo` varchar(20) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Numero Telefonico:',
  PRIMARY KEY (`id`),
  KEY `id_viniedos` (`id_viniedos`),
  CONSTRAINT `clientes1_ibfk_1` FOREIGN KEY (`id_viniedos`) REFERENCES `viniedos` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `clientes1` (`id`, `id_viniedos`, `Nombre`, `Correo_Electro`, `N_Telefo`) VALUES
	(1, 2, 'Juan Camilo Moreno Rojas', 'camilo.moreno1@utp.edu.co', '3046184271'),
	(2, 3, 'Cristian', 'Cr@gmail.com', '1234568'),
	(3, 11, 'Madelin', 'Md@gmail.com', '31457845'),
	(4, 1, 'David', 'Dv@gmail.com', '5478451'),
	(5, 10, 'Santiago', 'St@outlook.com', '38781200'),
	(6, 8, 'Violeta', 'Vl@gmail.com', '784120'),
	(7, 9, 'Sebastian', 'Sb@gmail.com', '3484815'),
	(8, 6, 'Roma', 'Rm@gmail.com', '30154548'),
	(9, 11, 'Barney', 'Br@gmail.com', '30015453');

CREATE TABLE IF NOT EXISTS `climasuelo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_viniedos` int NOT NULL,
  `Temperatura(Celcius)` float(50,0) NOT NULL,
  `Precipitacion(mm)` float(50,0) NOT NULL,
  `Humedad(m^3)` float(50,0) NOT NULL,
  `Ph_suelo` float(50,0) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_viniedos` (`id_viniedos`) USING BTREE,
  CONSTRAINT `climasuelo_ibfk_1` FOREIGN KEY (`id_viniedos`) REFERENCES `viniedos` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `climasuelo` (`id`, `id_viniedos`, `Temperatura(Celcius)`, `Precipitacion(mm)`, `Humedad(m^3)`, `Ph_suelo`) VALUES
	(1, 1, 24, 20, 2, 7),
	(2, 2, 25, 10, 2, 8),
	(3, 3, 20, 13, 3, 6),
	(4, 5, 24, 11, 1, 7),
	(6, 6, 25, 13, 3, 9),
	(7, 8, 23, 10, 4, 10);

CREATE TABLE IF NOT EXISTS `costosfinanzas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_viniedos` int NOT NULL,
  `Tipo_Gasto` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `Descripcion` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `Monto` float(10,0) NOT NULL,
  `Fecha` date NOT NULL,
  `Categoria` varchar(30) COLLATE latin1_spanish_ci NOT NULL,
  `Proveedor` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `Metodo_Pago` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_viniedos` (`id_viniedos`) USING BTREE,
  CONSTRAINT `costosfinanzas_ibfk_1` FOREIGN KEY (`id_viniedos`) REFERENCES `viniedos` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `costosfinanzas` (`id`, `id_viniedos`, `Tipo_Gasto`, `Descripcion`, `Monto`, `Fecha`, `Categoria`, `Proveedor`, `Metodo_Pago`) VALUES
	(1, 1, 'Mano de obra', 'Tijeras de poda', 2000000, '2024-04-16', 'Operativos', 'Trabajo S.A.S', 'Transferencia Bancaria'),
	(2, 2, 'Insumos', 'Fertilizantes', 300000, '2024-04-28', 'Operativos', 'Agrosuministros', 'Tarjeta de credito'),
	(3, 3, 'Mantenimiento', 'Reparacion de Tractor', 8000000, '2024-03-18', 'Operativo', 'Taller de Mecanica', 'Efectivo'),
	(4, 6, 'Marketing', 'Publicidad en redes sociales', 2000000, '2024-02-12', 'Administrativo', 'Agencia de Marketing', 'Factura');

CREATE TABLE IF NOT EXISTS `equiposmaquinaria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_viniedos` int NOT NULL,
  `Equipo` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `Mantenimiento` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `Fecha_uso` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_viniedos` (`id_viniedos`) USING BTREE,
  CONSTRAINT `equiposmaquinaria_ibfk_1` FOREIGN KEY (`id_viniedos`) REFERENCES `viniedos` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `equiposmaquinaria` (`id`, `id_viniedos`, `Equipo`, `Mantenimiento`, `Fecha_uso`) VALUES
	(1, 1, 'Tractor', 'Arado de tierras', '2024-05-05'),
	(2, 2, 'Prensa', 'Cambio de filtros', '2024-04-24');

CREATE TABLE IF NOT EXISTS `produccionvino` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_viniedos` int NOT NULL,
  `Tipo_vino` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `Volm_Prod(Litros)` decimal(10,0) NOT NULL,
  `Fecha_Prod` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_viniedos` (`id_viniedos`) USING BTREE,
  CONSTRAINT `produccionvino_ibfk_1` FOREIGN KEY (`id_viniedos`) REFERENCES `viniedos` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `produccionvino` (`id`, `id_viniedos`, `Tipo_vino`, `Volm_Prod(Litros)`, `Fecha_Prod`) VALUES
	(1, 1, 'Tinto', 1000, '2024-05-01'),
	(2, 12, 'Blanco', 800, '2024-04-18'),
	(3, 3, 'Tinto', 450, '2024-05-02'),
	(4, 7, 'Tinto', 1200, '2024-04-13');

CREATE TABLE IF NOT EXISTS `trabajadores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_viniedos` int NOT NULL,
  `Nombre` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `Rol` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `Horas_Trabajo` decimal(10,0) NOT NULL,
  `Salario` float(10,0) NOT NULL,
  `Contrasenia` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_viniedos` (`id_viniedos`),
  CONSTRAINT `trabajadores_ibfk_1` FOREIGN KEY (`id_viniedos`) REFERENCES `viniedos` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `trabajadores` (`id`, `id_viniedos`, `Nombre`, `Rol`, `Horas_Trabajo`, `Salario`, `Contrasenia`) VALUES
	(3, 1, 'Carlos', 'Viticultor', 40, 80000, '12345'),
	(4, 2, 'Maria', 'Enologa', 35, 75000, '1508'),
	(5, 5, 'Snie', 'Tractorista', 25, 90000, '1204'),
	(6, 7, 'Ana', 'Vendimiadora', 28, 560000, '24941140');

CREATE TABLE IF NOT EXISTS `uvas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Variedad` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `uvas` (`id`, `Variedad`) VALUES
	(1, 'Tempranillo'),
	(2, 'Garnacha'),
	(3, 'Mencía'),
	(4, 'Monastrell'),
	(5, 'Cabernet Sauvignon'),
	(6, 'Merlot'),
	(7, 'Syrah'),
	(8, 'vhj');

CREATE TABLE IF NOT EXISTS `uvasviniedo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_viniedos` int NOT NULL,
  `id_uvas` int NOT NULL,
  `Cant_Cosechada` int NOT NULL,
  `Calidad` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `Fecha_Cosecha` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_viniedos` (`id_viniedos`) USING BTREE,
  UNIQUE KEY `id_uvas` (`id_uvas`),
  CONSTRAINT `uvasviniedo_ibfk_1` FOREIGN KEY (`id_viniedos`) REFERENCES `viniedos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `uvasviniedo_ibfk_2` FOREIGN KEY (`id_uvas`) REFERENCES `uvas` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `uvasviniedo` (`id`, `id_viniedos`, `id_uvas`, `Cant_Cosechada`, `Calidad`, `Fecha_Cosecha`) VALUES
	(1, 1, 5, 100, 'Excelente', '2024-04-18'),
	(2, 2, 3, 800, 'Regular', '2024-03-15');

CREATE TABLE IF NOT EXISTS `ventasdistribucion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_viniedos` int NOT NULL,
  `Cliente` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `Cant_Vendida(botellas)` float(10,0) NOT NULL,
  `Precio(por botella)` float(10,0) NOT NULL,
  `Fecha_Entrega` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_viniedos` (`id_viniedos`) USING BTREE,
  UNIQUE KEY `id_Clientes` (`Cliente`) USING BTREE,
  KEY `Clientes` (`Cliente`) USING BTREE,
  CONSTRAINT `ventasdistribucion_ibfk_1` FOREIGN KEY (`id_viniedos`) REFERENCES `viniedos` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `ventasdistribucion` (`id`, `id_viniedos`, `Cliente`, `Cant_Vendida(botellas)`, `Precio(por botella)`, `Fecha_Entrega`) VALUES
	(1, 1, '0', 500, 15, '2024-04-29');

CREATE TABLE IF NOT EXISTS `viniedos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `Ub_Geo` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `Hectareas` decimal(10,0) NOT NULL,
  `Variedades_uvas` varchar(150) COLLATE latin1_spanish_ci NOT NULL,
  `Fecha_Plantac` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `viniedos` (`id`, `Nombre`, `Ub_Geo`, `Hectareas`, `Variedades_uvas`, `Fecha_Plantac`) VALUES
	(1, 'Vinos La hacienda', 'Armenia', 4, 'Tempranillo, Mencía', '2006-05-16'),
	(2, 'Vinia Costeira', 'Val de Pereira', 8, 'Cabernet Sauvignon', '2017-08-15'),
	(3, 'Zuccardi Valle de Uco', 'Argentina', 145000, 'Malbec, Bonarda, Torrontes, Chardonnay, Cabernet Sauvignon', '2016-12-27'),
	(5, 'Bodega Garzon', 'Uruguay', 25000, 'Merlot, Tempranillo', '2018-03-20'),
	(6, 'Quinta do Crosto', 'Portugal', 48000, 'Monastrell', '2023-08-15'),
	(7, 'Vinia Montes', 'Chile', 168, 'Mencia', '2020-11-17'),
	(8, 'Rippon', 'Nueva Zelanda', 178000, 'Syrah, Bobal, Baga, Merlot', '2014-07-10'),
	(9, 'Dr. Loosen', 'Alemania', 4589, 'Garnacha, Merlot', '2018-05-18'),
	(10, 'Catena Zapata', 'Argentina', 1500, 'Verdejo, Albarinio', '2019-07-30'),
	(11, 'Vinia Tondonia', 'Haro', 120, 'Alicante, Rufete', '2021-09-19'),
	(12, 'El enemigo Wines', 'Argentina', 1200, 'Bobal, Cabernet Suavignon, Godello', '2016-02-13');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
