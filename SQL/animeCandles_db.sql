CREATE DATABASE  IF NOT EXISTS `animecandles_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `animecandles_db`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: animecandles_db
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'ADMIN - AnimeCandles','admin@mail.com','123','1231231234');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `pid` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid_idx` (`uid`),
  KEY `pid_idx` (`pid`),
  CONSTRAINT `pid` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`),
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `cid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (10,'Naruto','naruto_logo.png'),(11,'Dragon Ball','dragonball_logo.png'),(12,'Demon Slayer','demonSlayer_logo.png'),(13,'Pokemon','pokemon_logo.png'),(14,'My Hero Academia','Hero_Academia_Logo.png'),(15,'One Piece','OnePiece_logo.png');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fees`
--

DROP TABLE IF EXISTS `fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fees` (
  `fid` int NOT NULL AUTO_INCREMENT,
  `shipping_fee` decimal(10,2) NOT NULL,
  `packaging_fee` decimal(10,2) NOT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fees`
--

LOCK TABLES `fees` WRITE;
/*!40000 ALTER TABLE `fees` DISABLE KEYS */;
INSERT INTO `fees` VALUES (1,10.00,5.00);
/*!40000 ALTER TABLE `fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderid` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `paymentType` varchar(100) DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_suspicious` tinyint(1) NOT NULL DEFAULT '0',
  `suspicious_reason` varchar(255) DEFAULT NULL,
  `reviewed_by` varchar(100) DEFAULT NULL,
  `review_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId_idx` (`userId`),
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordered_product`
--

DROP TABLE IF EXISTS `ordered_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordered_product` (
  `oid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` varchar(45) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `orderid` int DEFAULT NULL,
  `productId` int DEFAULT NULL,
  PRIMARY KEY (`oid`),
  KEY `orderid_idx` (`orderid`),
  CONSTRAINT `orderid` FOREIGN KEY (`orderid`) REFERENCES `order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordered_product`
--

LOCK TABLES `ordered_product` WRITE;
/*!40000 ALTER TABLE `ordered_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordered_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `price` varchar(20) NOT NULL,
  `quantity` int DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `cid` int DEFAULT NULL,
  PRIMARY KEY (`pid`),
  KEY `cid_idx` (`cid`),
  CONSTRAINT `cid` FOREIGN KEY (`cid`) REFERENCES `category` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (15,'Pikachu Candle','Inspirado en Pikachu de Pokemon.<br><br>\r\n\r\nNotas: Pina, coco, cilantro<br>\r\nTamano: 7 oz (198g) / 4 oz (113g)<br>\r\nBurn time: 40 - 50 hours / 10 - 18 hours<br>\r\nWax tipo: Natural Vegana de Soya<br>','15.0',10,30,'pikachu_01.png',13),(16,'Gengar Candle','Inspirado en Gengar de Pokemon.<br><br>\r\n\r\nNotas:  lavender, bergamot, pine<br>\r\nTamano: 7 oz (198g) / 4 oz (113g)<br>\r\nBurn time: 40 - 50 hours / 10 - 18 hours<br>\r\nWax tipo: Natural Vegana de Soya<br>','15.0',20,10,'gengar_01.png',13),(17,'Jigglypuff Candle','Inspirado en Jigglypuff de Pokemon.<br><br>\r\n\r\nNotas: strawberry, raspberry, jasmine<br>\r\nTamano: 7 oz (198g) / 4 oz (113g)<br>\r\nBurn time: 40 - 50 hours / 10 - 18 hours<br>\r\nWax tipo: Natural Vegana de Soya<br>','15.0',0,0,'jigglypuff_01.png',13),(18,'Charmander Candle','Inspirado en Charmander de Pokemon.<br><br>\r\n\r\nNotas: mango, melon, peach, jasmine<br>\r\nTamano: 7 oz (198g) / 4 oz (113g)<br>\r\nBurn time: 40 - 50 hours / 10 - 18 hours<br>\r\nWax tipo: Natural Vegana de Soya<br>','20.0',15,50,'charmander_01.png',13),(19,'Bulbasaur Candle','Inspirado en Bulbasaur de Pokemon.<br><br>\r\n\r\nNotas: orange, citrus, coriander<br>\r\nTamano: 7 oz (198g) / 4 oz (113g)<br>\r\nBurn time: 40 - 50 hours / 10 - 18 hours<br>\r\nWax tipo: Natural Vegana de Soya<br>','20.0',12,40,'Bulbasaur_01.png',13),(20,'Squirtle Candle','Inspirado en Charmander de Pokemon.<br><br>\n\nNotas: mango, pineapple, coconut, orchids<br>\nTamano: 7 oz (198g) / 4 oz (113g)<br>\nBurn time: 40 - 50 hours / 10 - 18 hours<br>\nWax tipo: Natural Vegana de Soya<br>','20',15,10,'Squirtle_01.png',13),(21,'Nezuko Kamado Candle','Inspirada por Nezuko Kamado de Demon Slayer.<br><br>\r\n \r\nNotas: peach, vanilla<br>\r\nTamano: 7 oz (198g) / 4 oz (113g)<br>\r\nBurn time: 40 - 50 hours / 10 - 18 hours<br>\r\nWax tipo: Natural Vegana de Soya<br><br>\r\n \r\n\"Mmmmhmm Mmmmmm Mhhhhmmmmm Mmmmhhh.\"','25.0',10,40,'Nezuko_candle.jpg',12),(22,'Tanjiro Kamado Candle','Inspirada porTanjiro Kamado de Demon Slayer.<br><br>\r\n\r\nNotas: watermelon, cucumber, rose, jasmine<br>\r\nTamano: 7 oz (198g) / 4 oz (113g)<br>\r\nBurn time: 40 - 50 hours / 10 - 18 hours<br>\r\nWax tipo: Natural Vegana de Soya<br><br>\r\n\r\n\"El v�nculo entre Nezuko y el... no puede ser roto por nadie!\"','25.0',10,5,'Tanjiro_candle.jpg',12),(23,'Inosuke Hashibira Candle','Inspirada en Inosuke Hashibira de Demon Slayer.</br></br>\r\n\r\nNotas: apple, peach, grapefruit, tropical floral<br>\r\nTamano: 7 oz (198g) / 4 oz (113g)<br>\r\nBurn time: 40 - 50 hours / 10 - 18 hours<br>\r\nWax tipo: Natural Vegana de Soya<br><br>\r\n\r\n\"Better watch out! Cause\' ready or not, HERE I COME!!\"','20.0',15,10,'Inosuke_candle.jpg',12),(24,'Shinobu Kocho Candle','Inspirada en Shinobu Kocho de Demon Slayer.</br></br>\r\n\r\nNotas: peony, pine, raspberry, citrus<br>\r\nTamano: 7 oz (198g) / 4 oz (113g)<br>\r\nBurn time: 40 - 50 hours / 10 - 18 hours<br>\r\nWax tipo: Natural Vegana de Soya<br><br>\r\n\r\n\"Strength lies not in physical power, but in mental fortitude.\"<br>\r\n','25.0',4,10,'Shinobu_candle.jpg',12);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `registerdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `address` varchar(250) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `phone_UNIQUE` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (6,'Test User','t@t.com','123','12312312','Male','2026-02-19 20:11:49','Calle Arce y Avenida Espana','San Salvador','1101','San Salvador');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `idwishlist` int NOT NULL AUTO_INCREMENT,
  `iduser` int DEFAULT NULL,
  `idproduct` int DEFAULT NULL,
  PRIMARY KEY (`idwishlist`),
  KEY `idproduct_idx` (`idproduct`),
  KEY `iduser_idx` (`iduser`),
  CONSTRAINT `idproduct` FOREIGN KEY (`idproduct`) REFERENCES `product` (`pid`),
  CONSTRAINT `iduser` FOREIGN KEY (`iduser`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-04 18:02:58
