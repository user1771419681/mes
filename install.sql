-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2026 at 01:58 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `xooiduyr_mes`
--
CREATE DATABASE IF NOT EXISTS `xooiduyr_mes` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `xooiduyr_mes`;

-- --------------------------------------------------------

--
-- Table structure for table `adjustment`
--

DROP TABLE IF EXISTS `adjustment`;
CREATE TABLE `adjustment` (
  `AdjustmentID` int(11) NOT NULL,
  `ProductionOrderID` int(11) NOT NULL,
  `ArticleID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `adjustment`
--

TRUNCATE TABLE `adjustment`;
--
-- Dumping data for table `adjustment`
--

INSERT INTO `adjustment` (`AdjustmentID`, `ProductionOrderID`, `ArticleID`, `Quantity`) VALUES
(0, 1, 1, 2),
(2, 1, 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `api_audit_log`
--

DROP TABLE IF EXISTS `api_audit_log`;
CREATE TABLE `api_audit_log` (
  `AuditID` int(11) NOT NULL,
  `KeyID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `Action` enum('Created','Updated','Deleted','Used','PermissionChange','ScopeChange') NOT NULL,
  `Endpoint` varchar(255) DEFAULT NULL,
  `IPAddress` varchar(45) DEFAULT NULL,
  `Details` text DEFAULT NULL,
  `Timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `api_audit_log`
--

TRUNCATE TABLE `api_audit_log`;
--
-- Dumping data for table `api_audit_log`
--

INSERT INTO `api_audit_log` (`AuditID`, `KeyID`, `UserID`, `Action`, `Endpoint`, `IPAddress`, `Details`, `Timestamp`) VALUES
(1, 1, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2025-12-26 22:40:09'),
(2, 2, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2025-12-26 22:40:41'),
(3, 3, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2025-12-27 12:31:49'),
(4, 4, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2025-12-27 18:18:08'),
(5, 5, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2025-12-29 12:40:25'),
(6, 6, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2025-12-30 09:48:49'),
(7, 7, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-01-05 14:51:25'),
(8, 8, 1, 'Created', NULL, '141.85.192.61', 'Generated via Login/Admin', '2026-01-12 17:20:54'),
(9, 9, 1, 'Created', NULL, '141.85.144.221', 'Generated via Login/Admin', '2026-01-14 13:08:45'),
(10, 10, 1, 'Created', NULL, '86.105.218.196', 'Generated via Login/Admin', '2026-01-14 13:10:31'),
(11, 11, 1, 'Created', NULL, '141.85.192.24', 'Generated via Login/Admin', '2026-01-14 18:20:37'),
(12, 12, 1, 'Created', NULL, '188.26.174.158', 'Generated via Login/Admin', '2026-01-15 09:23:33'),
(13, 13, 1, 'Created', NULL, '141.85.192.24', 'Generated via Login/Admin', '2026-01-15 16:06:43'),
(14, 14, 1, 'Created', NULL, '188.26.174.158', 'Generated via Login/Admin', '2026-01-15 20:06:21'),
(15, 15, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-01-20 13:16:24'),
(16, 16, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-01-22 11:12:39'),
(17, 17, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-01-22 17:16:35'),
(18, 18, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-01-22 22:01:19'),
(19, 19, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-01-23 12:21:39'),
(20, 20, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-01-24 08:34:29'),
(21, 21, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-01-24 09:25:34'),
(22, 22, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-01-25 09:36:32'),
(23, 23, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-02-04 18:05:03'),
(24, 24, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-02-23 10:47:59'),
(25, 25, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-02-25 10:53:46'),
(26, 26, 1, 'Created', NULL, '127.0.0.1', 'Generated via Login/Admin', '2026-03-22 20:13:57'),
(27, 27, 1, 'Created', NULL, '127.0.0.1', 'Generated via Login/Admin', '2026-03-23 11:56:42'),
(28, 28, 1, 'Created', NULL, '127.0.0.1', 'Generated via Login/Admin', '2026-04-21 17:15:46'),
(29, 29, 1, 'Created', NULL, '127.0.0.1', 'Generated via Login/Admin', '2026-05-06 08:58:10'),
(30, 30, 1, 'Created', NULL, '127.0.0.1', 'Generated via Login/Admin', '2026-05-08 09:16:15'),
(31, 31, 1, 'Created', NULL, '127.0.0.1', 'Generated via Login/Admin', '2026-05-12 14:04:41'),
(32, 32, 1, 'Created', NULL, '127.0.0.1', 'Generated via Login/Admin', '2026-05-14 20:57:15'),
(33, 33, 1, 'Created', NULL, '127.0.0.1', 'Generated via Login/Admin', '2026-05-15 08:23:22'),
(34, 34, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-05-22 20:42:36'),
(35, 34, NULL, 'Used', 'get-filter-options.php', '::1', NULL, '2026-05-22 20:45:34'),
(36, 34, NULL, 'Used', 'get-filter-options.php', '::1', NULL, '2026-05-22 20:45:37'),
(37, 35, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-06-13 17:06:43'),
(38, 36, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-06-14 15:18:58'),
(39, 34, NULL, 'Used', 'get-filter-options.php', '::1', NULL, '2026-06-14 19:22:49'),
(40, 34, NULL, 'Used', 'get-filter-options.php', '::1', NULL, '2026-06-14 19:22:57'),
(41, 37, 1, 'Created', NULL, '::1', 'Generated via Login/Admin', '2026-06-24 14:20:44');

-- --------------------------------------------------------

--
-- Table structure for table `api_keys`
--

DROP TABLE IF EXISTS `api_keys`;
CREATE TABLE `api_keys` (
  `KeyID` int(11) NOT NULL,
  `KeyString` varchar(64) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `UserID` int(11) NOT NULL,
  `Permissions` text DEFAULT NULL,
  `ScopePlants` text DEFAULT NULL,
  `IsActive` tinyint(1) DEFAULT 1,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `LastUsedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `api_keys`
--

TRUNCATE TABLE `api_keys`;
--
-- Dumping data for table `api_keys`
--

INSERT INTO `api_keys` (`KeyID`, `KeyString`, `Name`, `UserID`, `Permissions`, `ScopePlants`, `IsActive`, `CreatedAt`, `LastUsedAt`) VALUES
(1, 'c6c9186151e9287af39142108ebab65d', 'Session Key 2025-12-26 21:40', 1, 'ALL', 'ALL', 1, '2025-12-26 22:40:09', NULL),
(2, '6906495193834cc7316e1c46a8226623', 'Session Key 2025-12-26 21:40', 1, 'ALL', 'ALL', 1, '2025-12-26 22:40:41', NULL),
(3, 'a9b1940e31719abab5e20ad58b9880e4', 'Session Key 2025-12-27 11:31', 1, 'ALL', 'ALL', 1, '2025-12-27 12:31:49', NULL),
(4, '32e75f342e5375a0869d0026cc8e4073', 'Session Key 2025-12-27 17:18', 1, 'ALL', 'ALL', 1, '2025-12-27 18:18:08', NULL),
(5, 'a5e517e065bdd1b8d0a7a2019d586616', 'Session Key 2025-12-29 11:40', 1, 'ALL', 'ALL', 1, '2025-12-29 12:40:25', NULL),
(6, 'a5a4f0f6d26557ca75f91244be9c1b62', 'Session Key 2025-12-30 08:48', 1, 'ALL', 'ALL', 1, '2025-12-30 09:48:49', NULL),
(7, '3d511bf440c41c22165af692c52ba07b', 'Session Key 2026-01-05 13:51', 1, 'ALL', 'ALL', 1, '2026-01-05 14:51:25', NULL),
(8, '54662576c8ac8b287f418b1d6c31b806', 'Session Key 2026-01-12 17:20', 1, 'ALL', 'ALL', 1, '2026-01-12 17:20:54', NULL),
(9, '1333f50c4c0a952bf1665733779a2fb1', 'Session Key 2026-01-14 13:08', 1, 'ALL', 'ALL', 1, '2026-01-14 13:08:45', NULL),
(10, 'c0d2ea22d5d38d65eeb55c03efdb63a6', 'Session Key 2026-01-14 13:10', 1, 'ALL', 'ALL', 1, '2026-01-14 13:10:31', NULL),
(11, '9eab16768f9ca1a05f2af183515929cc', 'Session Key 2026-01-14 18:20', 1, 'ALL', 'ALL', 1, '2026-01-14 18:20:37', NULL),
(12, '0a54b1be9e3dc634a074731a3b2b3e33', 'Session Key 2026-01-15 09:23', 1, 'ALL', 'ALL', 1, '2026-01-15 09:23:33', NULL),
(13, '31689ad7d9c2d578f3da1e7afb278cf1', 'Session Key 2026-01-15 16:06', 1, 'ALL', 'ALL', 1, '2026-01-15 16:06:43', NULL),
(14, 'd73047933473ea70854f1ef210ab5b20', 'Session Key 2026-01-15 20:06', 1, 'ALL', 'ALL', 1, '2026-01-15 20:06:21', NULL),
(15, '920a453f165318bb025cead1f6d97c82', 'Session Key 2026-01-20 12:16', 1, 'ALL', 'ALL', 1, '2026-01-20 13:16:24', NULL),
(16, '6ec4ef7ef7a888f139d8720db2b3356f', 'Session Key 2026-01-22 10:12', 1, 'ALL', 'ALL', 1, '2026-01-22 11:12:39', NULL),
(17, 'b126687ac77173ea66c3a55016357303', 'Session Key 2026-01-22 16:16', 1, 'ALL', 'ALL', 1, '2026-01-22 17:16:35', NULL),
(18, '5e8741a831f3bc883e10d264bd6fc95e', 'Session Key 2026-01-22 21:01', 1, 'ALL', 'ALL', 1, '2026-01-22 22:01:19', NULL),
(19, '49cd6d7c07685a217e9c4e1a784e9195', 'Session Key 2026-01-23 11:21', 1, 'ALL', 'ALL', 1, '2026-01-23 12:21:39', NULL),
(20, '21d2a1b085b7d85e267a9c0d8626722d', 'Session Key 2026-01-24 07:34', 1, 'ALL', 'ALL', 1, '2026-01-24 08:34:29', NULL),
(21, '7c889ab9139950cc5de6a9d36739b7ef', 'Session Key 2026-01-24 08:25', 1, 'ALL', 'ALL', 1, '2026-01-24 09:25:34', NULL),
(22, '203719d105e9c1a87666c4cb5c5255b3', 'Session Key 2026-01-25 08:36', 1, 'ALL', 'ALL', 1, '2026-01-25 09:36:32', NULL),
(23, 'abdcd9137fbff7fd12b5e15875ebf9ed', 'Session Key 2026-02-04 17:05', 1, 'ALL', 'ALL', 1, '2026-02-04 18:05:03', NULL),
(24, '0f66ea847af9748b59a6c4b883ee7f61', 'Session Key 2026-02-23 09:47', 1, 'ALL', 'ALL', 1, '2026-02-23 10:47:59', NULL),
(25, '7c5ac287eba69fa0ec8358b6365331a0', 'Session Key 2026-02-25 09:53', 1, 'ALL', 'ALL', 1, '2026-02-25 10:53:46', NULL),
(26, 'e6a9b5418afd6c0f0399365a03a0c2e3', 'Session Key 2026-03-22 19:13', 1, 'ALL', 'ALL', 1, '2026-03-22 20:13:57', NULL),
(27, '4afb9808024f7e03034bd1ed13514088', 'Session Key 2026-03-23 10:56', 1, 'ALL', 'ALL', 1, '2026-03-23 11:56:42', NULL),
(28, '18999acf2273ae5bf7033688a495a68a', 'Session Key 2026-04-21 16:15', 1, 'ALL', 'ALL', 1, '2026-04-21 17:15:46', NULL),
(29, 'e6ae1f90c8333a2f852de981869ec49b', 'Session Key 2026-05-06 07:58', 1, 'ALL', 'ALL', 1, '2026-05-06 08:58:10', NULL),
(30, '1f88a3b25197413799b22c0977ee485a', 'Session Key 2026-05-08 08:16', 1, 'ALL', 'ALL', 1, '2026-05-08 09:16:15', NULL),
(31, 'e0df7101d0586c910c5c05ac53828994', 'Session Key 2026-05-12 13:04', 1, 'ALL', 'ALL', 1, '2026-05-12 14:04:41', NULL),
(32, '0083c3a57a192d99fa9790f8df622152', 'Session Key 2026-05-14 19:57', 1, 'ALL', 'ALL', 1, '2026-05-14 20:57:15', NULL),
(33, '523438beca2fbaf58d3aa62e8d0dea08', 'Session Key 2026-05-15 07:23', 1, 'ALL', 'ALL', 1, '2026-05-15 08:23:22', NULL),
(34, '3f144c303a7730187ffce7d1250baf48', 'Session Key 2026-05-22 19:42', 1, 'ALL', 'ALL', 1, '2026-05-22 20:42:36', '2026-06-14 19:22:57'),
(35, '5b0d9a55e7f608b01ab46f6033ebfe65', 'Session Key 2026-06-13 16:06', 1, 'ALL', 'ALL', 1, '2026-06-13 17:06:43', NULL),
(36, '822ec314242c0af0975d08436127d4e7', 'Session Key 2026-06-14 14:18', 1, 'ALL', 'ALL', 1, '2026-06-14 15:18:58', NULL),
(37, 'eb4d530ada679491273678e9296b04cf', 'Session Key 2026-06-24 13:20', 1, 'ALL', 'ALL', 1, '2026-06-24 14:20:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `ArticleID` int(11) NOT NULL,
  `Name` varchar(150) NOT NULL,
  `Description` text DEFAULT NULL,
  `ImagePath` varchar(255) DEFAULT NULL,
  `QualityControl` enum('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `article`
--

TRUNCATE TABLE `article`;
--
-- Dumping data for table `article`
--

INSERT INTO `article` (`ArticleID`, `Name`, `Description`, `ImagePath`, `QualityControl`, `CreatedAt`, `UpdatedAt`) VALUES
(2, '10001543-SM', '10001543-SemiManufactured', NULL, 'Approved', '2025-12-23 13:15:41', '2025-12-23 13:15:41'),
(3, '10001543-W', '10001543-Washed', NULL, 'Approved', '2025-12-23 13:16:04', '2025-12-23 13:16:04'),
(4, '10001543-P', '10001543-Packaged', NULL, 'Approved', '2025-12-23 13:16:33', '2025-12-23 13:16:33'),
(5, 'IN1543', 'Inox Coils for 10001543-SM', NULL, 'Approved', '2025-12-23 13:17:18', '2025-12-23 13:17:18');

-- --------------------------------------------------------

--
-- Table structure for table `batch_log`
--

DROP TABLE IF EXISTS `batch_log`;
CREATE TABLE `batch_log` (
  `BatchID` int(11) NOT NULL,
  `BatchCode` varchar(50) NOT NULL,
  `BatchType` enum('Finished Product','Partial Product','Raw Material Remnant') NOT NULL DEFAULT 'Finished Product',
  `ProductionOrderID` int(11) NOT NULL,
  `ArticleID` int(11) NOT NULL,
  `OperatorID` int(11) NOT NULL,
  `MachineID` int(11) NOT NULL,
  `Quantity` decimal(10,2) NOT NULL DEFAULT 0.00,
  `PrintTime` datetime DEFAULT current_timestamp(),
  `Notes` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `batch_log`
--

TRUNCATE TABLE `batch_log`;
--
-- Dumping data for table `batch_log`
--

INSERT INTO `batch_log` (`BatchID`, `BatchCode`, `BatchType`, `ProductionOrderID`, `ArticleID`, `OperatorID`, `MachineID`, `Quantity`, `PrintTime`, `Notes`, `CreatedAt`, `UpdatedAt`) VALUES
(3, 'DEV0000123', 'Finished Product', 6, 2, 1, 4, 500.00, '2026-01-23 14:55:00', '', '2026-01-23 13:56:28', '2026-01-23 13:56:28'),
(4, 'DEV0000124', 'Raw Material Remnant', 6, 5, 1, 4, 532.00, '2026-01-23 14:56:00', '', '2026-01-23 13:56:52', '2026-01-23 13:56:52'),
(5, 'DEV0000125', 'Raw Material Remnant', 7, 5, 1, 4, 123.00, '2026-01-23 14:56:00', '', '2026-01-23 13:57:07', '2026-01-23 13:57:19');

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `CityID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `CountryID` int(11) NOT NULL,
  `PostalCode` varchar(20) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `city`
--

TRUNCATE TABLE `city`;
--
-- Dumping data for table `city`
--

INSERT INTO `city` (`CityID`, `Name`, `CountryID`, `PostalCode`, `CreatedAt`) VALUES
(1, 'Vienna', 1, NULL, '2025-12-26 19:24:46'),
(2, 'Graz', 1, NULL, '2025-12-26 19:24:46'),
(3, 'Linz', 1, NULL, '2025-12-26 19:24:46'),
(4, 'Brussels', 2, NULL, '2025-12-26 19:24:46'),
(5, 'Antwerp', 2, NULL, '2025-12-26 19:24:46'),
(6, 'Ghent', 2, NULL, '2025-12-26 19:24:46'),
(7, 'Sofia', 3, NULL, '2025-12-26 19:24:46'),
(8, 'Plovdiv', 3, NULL, '2025-12-26 19:24:46'),
(9, 'Varna', 3, NULL, '2025-12-26 19:24:46'),
(10, 'Zagreb', 4, NULL, '2025-12-26 19:24:46'),
(11, 'Split', 4, NULL, '2025-12-26 19:24:46'),
(12, 'Rijeka', 4, NULL, '2025-12-26 19:24:46'),
(13, 'Nicosia', 5, NULL, '2025-12-26 19:24:46'),
(14, 'Limassol', 5, NULL, '2025-12-26 19:24:46'),
(15, 'Larnaca', 5, NULL, '2025-12-26 19:24:46'),
(16, 'Prague', 6, NULL, '2025-12-26 19:24:46'),
(17, 'Brno', 6, NULL, '2025-12-26 19:24:46'),
(18, 'Ostrava', 6, NULL, '2025-12-26 19:24:46'),
(19, 'Copenhagen', 7, NULL, '2025-12-26 19:24:46'),
(20, 'Aarhus', 7, NULL, '2025-12-26 19:24:46'),
(21, 'Odense', 7, NULL, '2025-12-26 19:24:46'),
(22, 'Tallinn', 8, NULL, '2025-12-26 19:24:46'),
(23, 'Tartu', 8, NULL, '2025-12-26 19:24:46'),
(24, 'Narva', 8, NULL, '2025-12-26 19:24:46'),
(25, 'Helsinki', 9, NULL, '2025-12-26 19:24:46'),
(26, 'Espoo', 9, NULL, '2025-12-26 19:24:46'),
(27, 'Tampere', 9, NULL, '2025-12-26 19:24:46'),
(28, 'Paris', 10, NULL, '2025-12-26 19:24:46'),
(29, 'Marseille', 10, NULL, '2025-12-26 19:24:46'),
(30, 'Lyon', 10, NULL, '2025-12-26 19:24:46'),
(31, 'Berlin', 11, NULL, '2025-12-26 19:24:46'),
(32, 'Hamburg', 11, NULL, '2025-12-26 19:24:46'),
(33, 'Munich', 11, NULL, '2025-12-26 19:24:46'),
(34, 'Athens', 12, NULL, '2025-12-26 19:24:46'),
(35, 'Thessaloniki', 12, NULL, '2025-12-26 19:24:46'),
(36, 'Patras', 12, NULL, '2025-12-26 19:24:46'),
(37, 'Budapest', 13, NULL, '2025-12-26 19:24:46'),
(38, 'Debrecen', 13, NULL, '2025-12-26 19:24:46'),
(39, 'Szeged', 13, NULL, '2025-12-26 19:24:46'),
(40, 'Dublin', 14, NULL, '2025-12-26 19:24:46'),
(41, 'Cork', 14, NULL, '2025-12-26 19:24:46'),
(42, 'Limerick', 14, NULL, '2025-12-26 19:24:46'),
(43, 'Rome', 15, NULL, '2025-12-26 19:24:46'),
(44, 'Milan', 15, NULL, '2025-12-26 19:24:46'),
(45, 'Naples', 15, NULL, '2025-12-26 19:24:46'),
(46, 'Riga', 16, NULL, '2025-12-26 19:24:46'),
(47, 'Daugavpils', 16, NULL, '2025-12-26 19:24:46'),
(48, 'Liepāja', 16, NULL, '2025-12-26 19:24:46'),
(49, 'Vilnius', 17, NULL, '2025-12-26 19:24:46'),
(50, 'Kaunas', 17, NULL, '2025-12-26 19:24:46'),
(51, 'Klaipėda', 17, NULL, '2025-12-26 19:24:46'),
(52, 'Luxembourg City', 18, NULL, '2025-12-26 19:24:46'),
(53, 'Esch-sur-Alzette', 18, NULL, '2025-12-26 19:24:46'),
(54, 'Differdange', 18, NULL, '2025-12-26 19:24:46'),
(55, 'Birkirkara', 19, NULL, '2025-12-26 19:24:46'),
(56, 'Qormi', 19, NULL, '2025-12-26 19:24:46'),
(57, 'Mosta', 19, NULL, '2025-12-26 19:24:46'),
(58, 'Amsterdam', 20, NULL, '2025-12-26 19:24:46'),
(59, 'Rotterdam', 20, NULL, '2025-12-26 19:24:46'),
(60, 'The Hague', 20, NULL, '2025-12-26 19:24:46'),
(61, 'Warsaw', 21, NULL, '2025-12-26 19:24:46'),
(62, 'Kraków', 21, NULL, '2025-12-26 19:24:46'),
(63, 'Łódź', 21, NULL, '2025-12-26 19:24:46'),
(64, 'Lisbon', 22, NULL, '2025-12-26 19:24:46'),
(65, 'Porto', 22, NULL, '2025-12-26 19:24:46'),
(66, 'Vila Nova de Gaia', 22, NULL, '2025-12-26 19:24:46'),
(67, 'Bucharest', 23, NULL, '2025-12-26 19:24:46'),
(68, 'Cluj-Napoca', 23, NULL, '2025-12-26 19:24:46'),
(69, 'Timișoara', 23, NULL, '2025-12-26 19:24:46'),
(70, 'Bratislava', 24, NULL, '2025-12-26 19:24:46'),
(71, 'Košice', 24, NULL, '2025-12-26 19:24:46'),
(72, 'Prešov', 24, NULL, '2025-12-26 19:24:46'),
(73, 'Ljubljana', 25, NULL, '2025-12-26 19:24:46'),
(74, 'Maribor', 25, NULL, '2025-12-26 19:24:46'),
(75, 'Kranj', 25, NULL, '2025-12-26 19:24:46'),
(76, 'Madrid', 26, NULL, '2025-12-26 19:24:46'),
(77, 'Barcelona', 26, NULL, '2025-12-26 19:24:46'),
(78, 'Valencia', 26, NULL, '2025-12-26 19:24:46'),
(79, 'Stockholm', 27, NULL, '2025-12-26 19:24:46'),
(80, 'Gothenburg', 27, NULL, '2025-12-26 19:24:46'),
(81, 'Malmö', 27, NULL, '2025-12-26 19:24:46');

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `CountryID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `ISOCode` varchar(3) NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `country`
--

TRUNCATE TABLE `country`;
--
-- Dumping data for table `country`
--

INSERT INTO `country` (`CountryID`, `Name`, `ISOCode`, `CreatedAt`) VALUES
(1, 'Austria', 'AUT', '2025-12-26 19:24:46'),
(2, 'Belgium', 'BEL', '2025-12-26 19:24:46'),
(3, 'Bulgaria', 'BGR', '2025-12-26 19:24:46'),
(4, 'Croatia', 'HRV', '2025-12-26 19:24:46'),
(5, 'Cyprus', 'CYP', '2025-12-26 19:24:46'),
(6, 'Czech Republic', 'CZE', '2025-12-26 19:24:46'),
(7, 'Denmark', 'DNK', '2025-12-26 19:24:46'),
(8, 'Estonia', 'EST', '2025-12-26 19:24:46'),
(9, 'Finland', 'FIN', '2025-12-26 19:24:46'),
(10, 'France', 'FRA', '2025-12-26 19:24:46'),
(11, 'Germany', 'DEU', '2025-12-26 19:24:46'),
(12, 'Greece', 'GRC', '2025-12-26 19:24:46'),
(13, 'Hungary', 'HUN', '2025-12-26 19:24:46'),
(14, 'Ireland', 'IRL', '2025-12-26 19:24:46'),
(15, 'Italy', 'ITA', '2025-12-26 19:24:46'),
(16, 'Latvia', 'LVA', '2025-12-26 19:24:46'),
(17, 'Lithuania', 'LTU', '2025-12-26 19:24:46'),
(18, 'Luxembourg', 'LUX', '2025-12-26 19:24:46'),
(19, 'Malta', 'MLT', '2025-12-26 19:24:46'),
(20, 'Netherlands', 'NLD', '2025-12-26 19:24:46'),
(21, 'Poland', 'POL', '2025-12-26 19:24:46'),
(22, 'Portugal', 'PRT', '2025-12-26 19:24:46'),
(23, 'Romania', 'ROU', '2025-12-26 19:24:46'),
(24, 'Slovakia', 'SVK', '2025-12-26 19:24:46'),
(25, 'Slovenia', 'SVN', '2025-12-26 19:24:46'),
(26, 'Spain', 'ESP', '2025-12-26 19:24:46'),
(27, 'Sweden', 'SWE', '2025-12-26 19:24:46');

-- --------------------------------------------------------

--
-- Table structure for table `machine`
--

DROP TABLE IF EXISTS `machine`;
CREATE TABLE `machine` (
  `MachineID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Status` enum('Active','Inactive','Maintenance') DEFAULT 'Active',
  `Capacity` decimal(10,2) NOT NULL DEFAULT 0.00,
  `SPM` int(11) DEFAULT NULL,
  `LastMaintenanceDate` date DEFAULT NULL,
  `Location` varchar(100) NOT NULL,
  `Model` varchar(100) NOT NULL,
  `PlantID` int(11) DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `machine`
--

TRUNCATE TABLE `machine`;
--
-- Dumping data for table `machine`
--

INSERT INTO `machine` (`MachineID`, `Name`, `Status`, `Capacity`, `SPM`, `LastMaintenanceDate`, `Location`, `Model`, `PlantID`, `SectionID`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 'PR-03', 'Active', 450.00, NULL, '2025-10-13', 'PR-03', 'Stamping Press', 161, 479, '2025-10-13 16:06:48', '2026-01-23 18:25:19'),
(3, 'PR-02', 'Active', 1500.00, NULL, '2025-10-29', 'PR-02', 'Stamping Press', 159, 476, '2025-10-13 16:42:04', '2026-01-23 18:25:28'),
(4, 'PR-01', 'Active', 2000.00, NULL, '2025-10-16', 'PR-01', 'Stamping Press 01', 158, 476, '2025-10-13 16:42:55', '2026-01-23 18:25:33'),
(5, 'PR-04', 'Active', 0.00, NULL, '3222-12-31', 'PR-04', 'Stamping Press', 159, 476, '2025-11-08 13:54:53', '2026-01-23 18:25:48'),
(6, 'PR-05', 'Active', 3000.00, NULL, '2025-12-25', 'Line 2', 'TMX-S4-30000', 161, 476, '2025-12-25 13:27:10', '2026-01-23 18:25:58'),
(7, 'PR-06', 'Active', 3000.00, NULL, '2025-12-25', 'Line 2', 'TMX-S4-30000', 159, 482, '2025-12-25 13:27:16', '2026-01-23 18:26:08');

-- --------------------------------------------------------

--
-- Table structure for table `machine_planning`
--

DROP TABLE IF EXISTS `machine_planning`;
CREATE TABLE `machine_planning` (
  `id` int(11) NOT NULL,
  `machine_code` varchar(3) NOT NULL,
  `machine_name` varchar(50) NOT NULL,
  `plan_date` date NOT NULL,
  `shift1_enabled` tinyint(1) DEFAULT 0,
  `shift1_start` time DEFAULT NULL,
  `shift1_break_start` time DEFAULT NULL,
  `shift1_break_end` time DEFAULT NULL,
  `shift1_end` time DEFAULT NULL,
  `shift2_enabled` tinyint(1) DEFAULT 0,
  `shift2_start` time DEFAULT NULL,
  `shift2_break_start` time DEFAULT NULL,
  `shift2_break_end` time DEFAULT NULL,
  `shift2_end` time DEFAULT NULL,
  `shift3_enabled` tinyint(1) DEFAULT 0,
  `shift3_start` time DEFAULT NULL,
  `shift3_break_start` time DEFAULT NULL,
  `shift3_break_end` time DEFAULT NULL,
  `shift3_end` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `machine_planning`
--

TRUNCATE TABLE `machine_planning`;
--
-- Dumping data for table `machine_planning`
--

INSERT INTO `machine_planning` (`id`, `machine_code`, `machine_name`, `plan_date`, `shift1_enabled`, `shift1_start`, `shift1_break_start`, `shift1_break_end`, `shift1_end`, `shift2_enabled`, `shift2_start`, `shift2_break_start`, `shift2_break_end`, `shift2_end`, `shift3_enabled`, `shift3_start`, `shift3_break_start`, `shift3_break_end`, `shift3_end`) VALUES
(1, 'M00', 'sadadasdasd', '2025-11-08', 0, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 0, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(11, 'M00', 'sadadasdasd', '2025-10-27', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(12, 'M00', 'sadadasdasd', '2025-10-28', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(13, 'M00', 'sadadasdasd', '2025-10-29', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(14, 'M00', 'sadadasdasd', '2025-10-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(15, 'M00', 'sadadasdasd', '2025-10-31', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(16, 'M00', 'sadadasdasd', '2025-11-01', 0, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 0, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(17, 'M00', 'sadadasdasd', '2025-11-02', 0, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 0, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(18, 'M00', 'sadadasdasd', '2025-11-03', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(19, 'M00', 'sadadasdasd', '2025-11-04', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(20, 'M00', 'sadadasdasd', '2025-11-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(21, 'M00', 'sadadasdasd', '2025-11-06', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(22, 'M00', 'sadadasdasd', '2025-11-07', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(115, 'M00', 'sadadasdasd', '2025-12-09', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(119, 'M00', 'sadadasdasd', '2025-12-10', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(135, 'M00', 'sadadasdasd', '2025-12-20', 0, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 0, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(139, 'M00', 'sadadasdasd', '2025-12-22', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(143, 'M00', 'sadadasdasd', '2025-12-25', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(169, 'M00', 'PR-03', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(177, 'M01', 'Cut-to-Length Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(187, 'M02', 'Stamping Press 300T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(197, 'M03', 'Vibratory Deburrer', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(207, 'M04', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(217, 'M05', 'Stamping Press 300T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(227, 'M06', 'Anodizing Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(237, 'M07', 'Stamping Press 200T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(247, 'M08', 'Vibratory Deburrer', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(257, 'M09', 'Slitting Line - Steel', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(267, 'M10', 'Cut-to-Length Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(277, 'M11', 'Stamping Press 300T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(287, 'M12', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(297, 'M13', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(307, 'M14', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(317, 'M15', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(327, 'M16', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(337, 'M17', 'Stamping Press 200T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(347, 'M18', 'Slitting Line - Aluminum', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(357, 'M19', 'Stamping Press 200T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(367, 'M20', 'Industrial Washer', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(377, 'M21', 'Slitting Line - Copper', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(387, 'M22', 'Cut-to-Length Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(397, 'M23', 'Stamping Press 300T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(407, 'M24', 'Slitting Line - Steel', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(417, 'M25', 'Stamping Press 200T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(427, 'M26', 'Slitting Line - Copper', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(437, 'M27', 'Stamping Press 200T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(447, 'M28', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(457, 'M29', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(467, 'M30', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(477, 'M31', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(487, 'M32', 'Stamping Press 300T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(497, 'M33', 'Slitting Line - Steel', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(507, 'M34', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(517, 'M35', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(527, 'M36', 'Vibratory Deburrer', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(537, 'M37', 'Anodizing Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(547, 'M38', 'Cut-to-Length Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(557, 'M39', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(567, 'M40', 'Slitting Line - Aluminum', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(577, 'M41', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(587, 'M42', 'Stamping Press 200T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(597, 'M43', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(607, 'M44', 'Stamping Press 200T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(617, 'M45', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(627, 'M46', 'Slitting Line - Aluminum', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(637, 'M47', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(647, 'M48', 'Stamping Press 300T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(657, 'M49', 'Powder Coating Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(667, 'M50', 'Stamping Press 300T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(677, 'M51', 'Industrial Washer', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(687, 'M52', 'Powder Coating Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(697, 'M53', 'Stamping Press 200T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(707, 'M54', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(717, 'M55', 'Industrial Washer', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(727, 'M56', 'Anodizing Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(737, 'M57', 'Cut-to-Length Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(747, 'M58', 'Stamping Press 200T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(757, 'M59', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(767, 'M60', 'Cut-to-Length Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(777, 'M61', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(787, 'M62', 'Stamping Press 300T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(797, 'M63', 'Slitting Line - Copper', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(807, 'M64', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(817, 'M65', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(827, 'M66', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(837, 'M67', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(847, 'M68', 'Slitting Line - Aluminum', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(857, 'M69', 'Cut-to-Length Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(867, 'M70', 'Stamping Press 300T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(877, 'M71', 'Industrial Washer', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(887, 'M72', 'Anodizing Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(897, 'M73', 'Stamping Press 200T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(907, 'M74', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(917, 'M75', 'Slitting Line - Steel', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(927, 'M76', 'Cut-to-Length Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(937, 'M77', 'Stamping Press 200T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(947, 'M78', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(957, 'M79', 'Galvanizing Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(967, 'M80', 'Stamping Press 300T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(977, 'M81', 'Vibratory Deburrer', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(987, 'M82', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(997, 'M83', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1007, 'M84', 'Slitting Line - Copper', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1017, 'M85', 'Stamping Press 200T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1027, 'M86', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1037, 'M87', 'Vibratory Deburrer', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1047, 'M88', 'Stamping Press 200T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1057, 'M89', 'Industrial Washer', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1067, 'M90', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1077, 'M91', 'Stamping Press 300T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1087, 'M92', 'Industrial Washer', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1097, 'M93', 'Stamping Press 100T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1107, 'M94', 'Stamping Press 300T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1117, 'M95', 'Stamping Press 400T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1127, 'M96', 'Cut-to-Length Line', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1137, 'M97', 'Stamping Press 300T', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1147, 'M98', 'Industrial Washer', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1157, 'M99', 'Slitting Line - Steel', '2025-12-26', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1525, 'M00', 'PR-03', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1533, 'M01', 'Cut-to-Length Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1543, 'M02', 'Stamping Press 300T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1553, 'M03', 'Vibratory Deburrer', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1563, 'M04', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1573, 'M05', 'Stamping Press 300T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1583, 'M06', 'Anodizing Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1593, 'M07', 'Stamping Press 200T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1603, 'M08', 'Vibratory Deburrer', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1613, 'M09', 'Slitting Line - Steel', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1623, 'M10', 'Cut-to-Length Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1633, 'M11', 'Stamping Press 300T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1643, 'M12', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1653, 'M13', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1663, 'M14', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1673, 'M15', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1683, 'M16', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1693, 'M17', 'Stamping Press 200T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1703, 'M18', 'Slitting Line - Aluminum', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1713, 'M19', 'Stamping Press 200T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1723, 'M20', 'Industrial Washer', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1733, 'M21', 'Slitting Line - Copper', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1743, 'M22', 'Cut-to-Length Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1753, 'M23', 'Stamping Press 300T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1763, 'M24', 'Slitting Line - Steel', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1773, 'M25', 'Stamping Press 200T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1783, 'M26', 'Slitting Line - Copper', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1793, 'M27', 'Stamping Press 200T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1803, 'M28', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1813, 'M29', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1823, 'M30', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1833, 'M31', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1843, 'M32', 'Stamping Press 300T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1853, 'M33', 'Slitting Line - Steel', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1863, 'M34', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1873, 'M35', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1883, 'M36', 'Vibratory Deburrer', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1893, 'M37', 'Anodizing Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1903, 'M38', 'Cut-to-Length Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1913, 'M39', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1923, 'M40', 'Slitting Line - Aluminum', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1933, 'M41', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1943, 'M42', 'Stamping Press 200T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1953, 'M43', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1963, 'M44', 'Stamping Press 200T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1973, 'M45', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1983, 'M46', 'Slitting Line - Aluminum', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(1993, 'M47', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2003, 'M48', 'Stamping Press 300T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2013, 'M49', 'Powder Coating Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2023, 'M50', 'Stamping Press 300T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2033, 'M51', 'Industrial Washer', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2043, 'M52', 'Powder Coating Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2053, 'M53', 'Stamping Press 200T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2063, 'M54', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2073, 'M55', 'Industrial Washer', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2083, 'M56', 'Anodizing Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2093, 'M57', 'Cut-to-Length Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2103, 'M58', 'Stamping Press 200T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2113, 'M59', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2123, 'M60', 'Cut-to-Length Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2133, 'M61', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2143, 'M62', 'Stamping Press 300T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2153, 'M63', 'Slitting Line - Copper', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2163, 'M64', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2173, 'M65', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2183, 'M66', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2193, 'M67', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2203, 'M68', 'Slitting Line - Aluminum', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2213, 'M69', 'Cut-to-Length Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2223, 'M70', 'Stamping Press 300T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2233, 'M71', 'Industrial Washer', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2243, 'M72', 'Anodizing Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2253, 'M73', 'Stamping Press 200T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2263, 'M74', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2273, 'M75', 'Slitting Line - Steel', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2283, 'M76', 'Cut-to-Length Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2293, 'M77', 'Stamping Press 200T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2303, 'M78', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2313, 'M79', 'Galvanizing Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2323, 'M80', 'Stamping Press 300T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2333, 'M81', 'Vibratory Deburrer', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2343, 'M82', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2353, 'M83', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2363, 'M84', 'Slitting Line - Copper', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2373, 'M85', 'Stamping Press 200T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2383, 'M86', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2393, 'M87', 'Vibratory Deburrer', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2403, 'M88', 'Stamping Press 200T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2413, 'M89', 'Industrial Washer', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2423, 'M90', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2433, 'M91', 'Stamping Press 300T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2443, 'M92', 'Industrial Washer', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2453, 'M93', 'Stamping Press 100T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2463, 'M94', 'Stamping Press 300T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2473, 'M95', 'Stamping Press 400T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2483, 'M96', 'Cut-to-Length Line', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2493, 'M97', 'Stamping Press 300T', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2503, 'M98', 'Industrial Washer', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2513, 'M99', 'Slitting Line - Steel', '2025-12-30', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2881, 'M00', 'PR-03', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2889, 'M01', 'Cut-to-Length Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2899, 'M02', 'Stamping Press 300T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2909, 'M03', 'Vibratory Deburrer', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2919, 'M04', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2929, 'M05', 'Stamping Press 300T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2939, 'M06', 'Anodizing Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2949, 'M07', 'Stamping Press 200T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2959, 'M08', 'Vibratory Deburrer', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2969, 'M09', 'Slitting Line - Steel', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2979, 'M10', 'Cut-to-Length Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2989, 'M11', 'Stamping Press 300T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(2999, 'M12', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3009, 'M13', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3019, 'M14', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3029, 'M15', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3039, 'M16', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3049, 'M17', 'Stamping Press 200T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3059, 'M18', 'Slitting Line - Aluminum', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3069, 'M19', 'Stamping Press 200T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3079, 'M20', 'Industrial Washer', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3089, 'M21', 'Slitting Line - Copper', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3099, 'M22', 'Cut-to-Length Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3109, 'M23', 'Stamping Press 300T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3119, 'M24', 'Slitting Line - Steel', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3129, 'M25', 'Stamping Press 200T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3139, 'M26', 'Slitting Line - Copper', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3149, 'M27', 'Stamping Press 200T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3159, 'M28', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3169, 'M29', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3179, 'M30', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3189, 'M31', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3199, 'M32', 'Stamping Press 300T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3209, 'M33', 'Slitting Line - Steel', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3219, 'M34', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3229, 'M35', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3239, 'M36', 'Vibratory Deburrer', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3249, 'M37', 'Anodizing Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3259, 'M38', 'Cut-to-Length Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3269, 'M39', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3279, 'M40', 'Slitting Line - Aluminum', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3289, 'M41', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3299, 'M42', 'Stamping Press 200T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3309, 'M43', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3319, 'M44', 'Stamping Press 200T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3329, 'M45', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3339, 'M46', 'Slitting Line - Aluminum', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3349, 'M47', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3359, 'M48', 'Stamping Press 300T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3369, 'M49', 'Powder Coating Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3379, 'M50', 'Stamping Press 300T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3389, 'M51', 'Industrial Washer', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3399, 'M52', 'Powder Coating Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3409, 'M53', 'Stamping Press 200T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3419, 'M54', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3429, 'M55', 'Industrial Washer', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3439, 'M56', 'Anodizing Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3449, 'M57', 'Cut-to-Length Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3459, 'M58', 'Stamping Press 200T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3469, 'M59', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3479, 'M60', 'Cut-to-Length Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3489, 'M61', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3499, 'M62', 'Stamping Press 300T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3509, 'M63', 'Slitting Line - Copper', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3519, 'M64', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3529, 'M65', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3539, 'M66', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3549, 'M67', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3559, 'M68', 'Slitting Line - Aluminum', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3569, 'M69', 'Cut-to-Length Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3579, 'M70', 'Stamping Press 300T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3589, 'M71', 'Industrial Washer', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3599, 'M72', 'Anodizing Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3609, 'M73', 'Stamping Press 200T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3619, 'M74', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3629, 'M75', 'Slitting Line - Steel', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3639, 'M76', 'Cut-to-Length Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3649, 'M77', 'Stamping Press 200T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3659, 'M78', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3669, 'M79', 'Galvanizing Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3679, 'M80', 'Stamping Press 300T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3689, 'M81', 'Vibratory Deburrer', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3699, 'M82', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3709, 'M83', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3719, 'M84', 'Slitting Line - Copper', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3729, 'M85', 'Stamping Press 200T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3739, 'M86', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3749, 'M87', 'Vibratory Deburrer', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3759, 'M88', 'Stamping Press 200T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3769, 'M89', 'Industrial Washer', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3779, 'M90', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3789, 'M91', 'Stamping Press 300T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3799, 'M92', 'Industrial Washer', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3809, 'M93', 'Stamping Press 100T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3819, 'M94', 'Stamping Press 300T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3829, 'M95', 'Stamping Press 400T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3839, 'M96', 'Cut-to-Length Line', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3849, 'M97', 'Stamping Press 300T', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3859, 'M98', 'Industrial Washer', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3869, 'M99', 'Slitting Line - Steel', '2026-01-05', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3870, 'M00', 'PR-03', '2026-01-12', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3876, 'M10', 'Vibratory Deburrer', '2026-01-12', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3974, 'M11', 'Slitting Line - Copper', '2026-01-12', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3976, 'M00', 'PR-03', '2026-01-14', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(3982, 'M10', 'Vibratory Deburrer', '2026-01-14', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(4080, 'M11', 'Slitting Line - Copper', '2026-01-14', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(4506, 'M00', 'PR-03', '2026-01-15', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(4512, 'M10', 'Vibratory Deburrer', '2026-01-15', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(4610, 'M11', 'Slitting Line - Copper', '2026-01-15', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(4611, 'M00', 'PR-03', '2026-01-24', 0, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 0, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(4635, 'M00', 'PR-03', '2026-01-25', 0, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 0, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(4641, 'M00', 'PR-03', '2026-02-25', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(4642, 'M00', 'PR-03', '2026-03-22', 0, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 0, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL),
(4648, 'M00', 'PR-03', '2026-03-23', 1, '06:00:00', '10:00:00', '10:15:00', '14:00:00', 1, '14:00:00', '18:00:00', '18:15:00', '22:00:00', 0, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `machine_stop_category`
--

DROP TABLE IF EXISTS `machine_stop_category`;
CREATE TABLE `machine_stop_category` (
  `CategoryID` int(11) NOT NULL,
  `CategoryName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `machine_stop_category`
--

TRUNCATE TABLE `machine_stop_category`;
--
-- Dumping data for table `machine_stop_category`
--

INSERT INTO `machine_stop_category` (`CategoryID`, `CategoryName`) VALUES
(2, 'Electrical Failure'),
(4, 'Logistics / Material'),
(1, 'Mechanical Failure'),
(5, 'Planned Downtime'),
(3, 'Process / Setup');

-- --------------------------------------------------------

--
-- Table structure for table `machine_stop_log`
--

DROP TABLE IF EXISTS `machine_stop_log`;
CREATE TABLE `machine_stop_log` (
  `StopID` int(11) NOT NULL,
  `MachineID` int(11) NOT NULL,
  `OperatorID` int(11) NOT NULL,
  `ProductionOrderID` int(11) DEFAULT NULL,
  `StartTime` datetime NOT NULL,
  `EndTime` datetime DEFAULT NULL,
  `DurationMinutes` float GENERATED ALWAYS AS (if(`EndTime` is not null,timestampdiff(MINUTE,`StartTime`,`EndTime`),NULL)) VIRTUAL,
  `CategoryID` int(11) DEFAULT NULL,
  `ReasonID` int(11) DEFAULT NULL,
  `Notes` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `machine_stop_log`
--

TRUNCATE TABLE `machine_stop_log`;
--
-- Dumping data for table `machine_stop_log`
--

INSERT INTO `machine_stop_log` (`StopID`, `MachineID`, `OperatorID`, `ProductionOrderID`, `StartTime`, `EndTime`, `CategoryID`, `ReasonID`, `Notes`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 4, 1, NULL, '2025-12-25 18:15:00', '2025-12-25 18:15:00', 2, 8, '', '2025-12-25 17:15:22', '2025-12-25 17:15:32');

-- --------------------------------------------------------

--
-- Table structure for table `machine_stop_reason`
--

DROP TABLE IF EXISTS `machine_stop_reason`;
CREATE TABLE `machine_stop_reason` (
  `ReasonID` int(11) NOT NULL,
  `ReasonName` varchar(255) NOT NULL,
  `CategoryID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `machine_stop_reason`
--

TRUNCATE TABLE `machine_stop_reason`;
--
-- Dumping data for table `machine_stop_reason`
--

INSERT INTO `machine_stop_reason` (`ReasonID`, `ReasonName`, `CategoryID`) VALUES
(1, 'Motor Overheat', 1),
(2, 'Belt/Chain Break', 1),
(3, 'Hydraulic Leak', 1),
(4, 'Tool Jam', 1),
(5, 'Sensor Error', 2),
(6, 'PLC Crash', 2),
(7, 'Power Outage', 2),
(8, 'Changeover / Setup', 3),
(9, 'Cleaning', 3),
(10, 'Quality Adjustment', 3),
(11, 'Waiting for Material', 4),
(12, 'Waiting for Operator', 4),
(13, 'Forklift Delay', 4),
(14, 'Scheduled Maintenance', 5),
(15, 'Lunch Break', 5),
(16, 'Shift Change', 5);

-- --------------------------------------------------------

--
-- Table structure for table `operator_log`
--

DROP TABLE IF EXISTS `operator_log`;
CREATE TABLE `operator_log` (
  `LogID` int(11) NOT NULL,
  `OperatorID` int(11) NOT NULL,
  `MachineID` int(11) NOT NULL,
  `LoginTime` datetime DEFAULT current_timestamp(),
  `LogoutTime` datetime DEFAULT NULL,
  `DurationMinutes` float GENERATED ALWAYS AS (if(`LogoutTime` is not null,timestampdiff(MINUTE,`LoginTime`,`LogoutTime`),NULL)) VIRTUAL,
  `Notes` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `operator_log`
--

TRUNCATE TABLE `operator_log`;
--
-- Dumping data for table `operator_log`
--

INSERT INTO `operator_log` (`LogID`, `OperatorID`, `MachineID`, `LoginTime`, `LogoutTime`, `Notes`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 1, 4, '2025-12-01 17:10:00', '2025-12-07 21:10:00', '', '2025-12-25 15:10:57', '2025-12-25 15:10:57'),
(2, 1, 3, '2025-12-02 17:11:00', '2025-12-31 17:16:00', '', '2025-12-25 15:11:36', '2025-12-25 15:11:36'),
(3, 3, 4, '2026-01-24 09:48:00', NULL, NULL, '2026-01-24 07:48:00', '2026-01-24 07:48:00'),
(4, 2, 4, '2026-01-24 10:00:29', NULL, NULL, '2026-01-24 08:00:29', '2026-01-24 08:00:29');

-- --------------------------------------------------------

--
-- Table structure for table `plant`
--

DROP TABLE IF EXISTS `plant`;
CREATE TABLE `plant` (
  `PlantID` int(11) NOT NULL,
  `Name` varchar(150) NOT NULL,
  `Description` text DEFAULT NULL,
  `CityID` int(11) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `ContactEmail` varchar(100) DEFAULT NULL,
  `ContactPhone` varchar(50) DEFAULT NULL,
  `ManagerName` varchar(100) DEFAULT NULL,
  `Status` enum('Active','Inactive','Construction') DEFAULT 'Active',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `plant`
--

TRUNCATE TABLE `plant`;
--
-- Dumping data for table `plant`
--

INSERT INTO `plant` (`PlantID`, `Name`, `Description`, `CityID`, `Address`, `ContactEmail`, `ContactPhone`, `ManagerName`, `Status`, `CreatedAt`, `UpdatedAt`) VALUES
(158, 'Romania SteelWorks Bucharest 1', 'Specialized steel processing facility in Bucharest', 67, '923 Industrial Blvd, Sector 5', 'contact@romaniasteel.com', '+32 546114074', 'Manager 2bcc8', 'Active', '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(159, 'Romania SteelWorks Bucharest 2', 'Specialized steel processing facility in Bucharest', 67, '748 Industrial Blvd, Sector 10', 'contact@romaniasteel.com', '+32 578813382', 'Manager 73668', 'Active', '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(160, 'Romania SteelWorks Bucharest 3', 'Specialized steel processing facility in Bucharest', 67, '681 Industrial Blvd, Sector 6', 'contact@romaniasteel.com', '+32 669088149', 'Manager 0f8b1', 'Active', '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(161, 'Romania SteelWorks Bucharest 4', 'Specialized steel processing facility in Bucharest', 67, '924 Industrial Blvd, Sector 2', 'contact@romaniasteel.com', '+32 282975299', 'Manager 42316', 'Active', '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(162, 'Romania SteelWorks Cluj-Napoca 5', 'Specialized steel processing facility in Cluj-Napoca', 68, '845 Industrial Blvd, Sector 6', 'contact@romaniasteel.com', '+32 120674746', 'Manager cc434', 'Active', '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(163, 'Romania SteelWorks Cluj-Napoca 6', 'Specialized steel processing facility in Cluj-Napoca', 68, '133 Industrial Blvd, Sector 2', 'contact@romaniasteel.com', '+32 468320259', 'Manager 2a4af', 'Active', '2025-12-26 19:35:42', '2025-12-26 19:35:42');

-- --------------------------------------------------------

--
-- Table structure for table `processed_production`
--

DROP TABLE IF EXISTS `processed_production`;
CREATE TABLE `processed_production` (
  `ProcessedID` int(11) NOT NULL,
  `LogID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `AssignedQuantity` int(11) NOT NULL,
  `AssignmentDate` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `processed_production`
--

TRUNCATE TABLE `processed_production`;
-- --------------------------------------------------------

--
-- Table structure for table `production_log`
--

DROP TABLE IF EXISTS `production_log`;
CREATE TABLE `production_log` (
  `LogID` int(11) NOT NULL,
  `ProductionOrderID` int(11) NOT NULL,
  `MachineID` int(11) NOT NULL,
  `StartOperatorID` int(11) NOT NULL,
  `EndOperatorID` int(11) DEFAULT NULL,
  `StartTime` datetime DEFAULT current_timestamp(),
  `EndTime` datetime DEFAULT NULL,
  `DurationMinutes` float GENERATED ALWAYS AS (if(`EndTime` is not null,timestampdiff(MINUTE,`StartTime`,`EndTime`),NULL)) VIRTUAL,
  `ShiftCount` decimal(4,2) DEFAULT 0.00,
  `Status` enum('Active','Closed') DEFAULT 'Active',
  `Notes` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `production_log`
--

TRUNCATE TABLE `production_log`;
--
-- Dumping data for table `production_log`
--

INSERT INTO `production_log` (`LogID`, `ProductionOrderID`, `MachineID`, `StartOperatorID`, `EndOperatorID`, `StartTime`, `EndTime`, `ShiftCount`, `Status`, `Notes`, `CreatedAt`, `UpdatedAt`) VALUES
(3, 7, 4, 1, 1, '2026-01-23 14:55:00', '2026-01-23 14:55:00', 0.00, 'Closed', '', '2026-01-23 13:55:34', '2026-01-23 13:55:39'),
(4, 6, 4, 3, NULL, '2026-01-24 08:53:32', NULL, 0.00, 'Active', NULL, '2026-01-24 07:53:32', '2026-01-24 07:53:32');

-- --------------------------------------------------------

--
-- Table structure for table `production_order`
--

DROP TABLE IF EXISTS `production_order`;
CREATE TABLE `production_order` (
  `OrderID` int(11) NOT NULL,
  `ArticleID` int(11) NOT NULL,
  `RecipeID` int(11) DEFAULT NULL,
  `TargetQuantity` int(11) NOT NULL,
  `ProducedQuantity` int(11) DEFAULT 0,
  `RejectQuantity` int(11) DEFAULT 0,
  `Status` enum('Planned','Active','Suspended','Closed') DEFAULT 'Planned',
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `DeletedAt` datetime DEFAULT NULL,
  `DeletedBy` int(11) DEFAULT NULL,
  `PlannedStartDate` date NOT NULL,
  `ActualStartDate` datetime DEFAULT NULL,
  `PlannedEndDate` date NOT NULL,
  `ActualEndDate` datetime DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `production_order`
--

TRUNCATE TABLE `production_order`;
--
-- Dumping data for table `production_order`
--

INSERT INTO `production_order` (`OrderID`, `ArticleID`, `RecipeID`, `TargetQuantity`, `ProducedQuantity`, `RejectQuantity`, `Status`, `IsDeleted`, `DeletedAt`, `DeletedBy`, `PlannedStartDate`, `ActualStartDate`, `PlannedEndDate`, `ActualEndDate`, `CreatedAt`) VALUES
(6, 4, 1, 1234, 0, 0, 'Active', 0, NULL, NULL, '2026-01-22', '2026-01-24 09:53:32', '2026-01-22', NULL, '2026-01-22 10:42:37'),
(7, 4, 1, 5000, 0, 0, 'Planned', 0, NULL, NULL, '2026-01-22', NULL, '2026-01-22', NULL, '2026-01-22 12:46:21'),
(8, 4, 3, 500, 0, 0, 'Planned', 0, NULL, NULL, '2026-01-24', NULL, '2026-01-26', NULL, '2026-01-24 08:02:48'),
(9, 4, 1, 500, 0, 0, 'Planned', 0, NULL, NULL, '2026-02-23', NULL, '2026-02-23', NULL, '2026-02-23 08:48:20');

-- --------------------------------------------------------

--
-- Table structure for table `production_order_progress`
--

DROP TABLE IF EXISTS `production_order_progress`;
CREATE TABLE `production_order_progress` (
  `ProgressID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `ArticleID` int(11) NOT NULL,
  `UnprintedQuantity` int(11) NOT NULL DEFAULT 0,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `production_order_progress`
--

TRUNCATE TABLE `production_order_progress`;
-- --------------------------------------------------------

--
-- Table structure for table `production_recipes`
--

DROP TABLE IF EXISTS `production_recipes`;
CREATE TABLE `production_recipes` (
  `RecipeID` int(11) NOT NULL,
  `ArticleID` int(11) NOT NULL,
  `MachineID` int(11) NOT NULL,
  `Sequence` int(11) NOT NULL DEFAULT 0,
  `OperationDescription` text DEFAULT NULL,
  `EstimatedTime` decimal(5,2) DEFAULT NULL,
  `Version` varchar(50) NOT NULL DEFAULT '1.0',
  `IsActive` tinyint(1) NOT NULL DEFAULT 1,
  `Notes` text DEFAULT NULL,
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `production_recipes`
--

TRUNCATE TABLE `production_recipes`;
--
-- Dumping data for table `production_recipes`
--

INSERT INTO `production_recipes` (`RecipeID`, `ArticleID`, `MachineID`, `Sequence`, `OperationDescription`, `EstimatedTime`, `Version`, `IsActive`, `Notes`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 4, 4, 0, 'Finished part', 5.00, '0', 1, '', '2026-01-22 11:28:36', '2026-01-22 11:28:36'),
(2, 2, 3, 0, 'Semimanufactured part', 5.00, '0', 1, '', '2026-01-22 11:28:53', '2026-01-22 11:28:53'),
(3, 4, 4, 0, 'asdasdasd', 300.00, 'RevA', 1, 'sadasdasd', '2026-01-24 10:02:30', '2026-01-24 10:02:30');

-- --------------------------------------------------------

--
-- Table structure for table `raw_material_log`
--

DROP TABLE IF EXISTS `raw_material_log`;
CREATE TABLE `raw_material_log` (
  `LogID` int(11) NOT NULL,
  `ProductionOrderID` int(11) NOT NULL,
  `OperatorID` int(11) NOT NULL,
  `BatchCode` varchar(100) NOT NULL,
  `ArticleID` int(11) DEFAULT NULL,
  `MachineID` int(11) DEFAULT NULL,
  `Quantity` decimal(10,2) DEFAULT 1.00,
  `ScanTime` datetime DEFAULT current_timestamp(),
  `Notes` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `raw_material_log`
--

TRUNCATE TABLE `raw_material_log`;
-- --------------------------------------------------------

--
-- Table structure for table `recipe_inputs`
--

DROP TABLE IF EXISTS `recipe_inputs`;
CREATE TABLE `recipe_inputs` (
  `InputID` int(11) NOT NULL,
  `RecipeID` int(11) NOT NULL,
  `ArticleID` int(11) NOT NULL,
  `Quantity` decimal(10,4) NOT NULL DEFAULT 1.0000,
  `Unit` varchar(50) NOT NULL DEFAULT 'unit',
  `InputType` enum('part','resource','consumable') NOT NULL DEFAULT 'part',
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `recipe_inputs`
--

TRUNCATE TABLE `recipe_inputs`;
-- --------------------------------------------------------

--
-- Table structure for table `recipe_outputs`
--

DROP TABLE IF EXISTS `recipe_outputs`;
CREATE TABLE `recipe_outputs` (
  `OutputID` int(11) NOT NULL,
  `RecipeID` int(11) NOT NULL,
  `ArticleID` int(11) NOT NULL,
  `Quantity` decimal(10,4) NOT NULL DEFAULT 1.0000,
  `Unit` varchar(50) NOT NULL DEFAULT 'unit',
  `IsPrimary` tinyint(1) NOT NULL DEFAULT 1,
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `recipe_outputs`
--

TRUNCATE TABLE `recipe_outputs`;
-- --------------------------------------------------------

--
-- Table structure for table `reject`
--

DROP TABLE IF EXISTS `reject`;
CREATE TABLE `reject` (
  `RejectID` int(11) NOT NULL,
  `ArticleID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `OperatorID` int(11) NOT NULL,
  `MachineID` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  `ReasonID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Notes` text DEFAULT NULL,
  `RejectDate` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `reject`
--

TRUNCATE TABLE `reject`;
--
-- Dumping data for table `reject`
--

INSERT INTO `reject` (`RejectID`, `ArticleID`, `OrderID`, `OperatorID`, `MachineID`, `CategoryID`, `ReasonID`, `Quantity`, `Notes`, `RejectDate`) VALUES
(2, 4, 6, 3, 4, 3, 12, 50, '', '2026-02-04 17:09:56'),
(3, 4, 6, 3, 4, 3, 13, 1500, '', '2026-02-04 17:10:07'),
(4, 4, 6, 3, 4, 2, 2, 1777, '', '2026-02-04 17:10:18'),
(5, 4, 6, 3, 4, 3, 12, 6, '', '2026-03-06 08:24:00'),
(6, 4, 6, 3, 4, 3, 13, 1, 'test', '2026-05-22 19:48:25');

-- --------------------------------------------------------

--
-- Table structure for table `reject_category`
--

DROP TABLE IF EXISTS `reject_category`;
CREATE TABLE `reject_category` (
  `CategoryID` int(11) NOT NULL,
  `CategoryName` varchar(255) NOT NULL,
  `PlantID` int(11) DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `reject_category`
--

TRUNCATE TABLE `reject_category`;
--
-- Dumping data for table `reject_category`
--

INSERT INTO `reject_category` (`CategoryID`, `CategoryName`, `PlantID`, `SectionID`) VALUES
(1, 'Surface Defects', NULL, NULL),
(2, 'Mechanical Issues', NULL, NULL),
(3, 'Material Defect', NULL, NULL),
(4, 'Machine Malfunction', NULL, NULL),
(5, 'Operator Error', NULL, NULL),
(6, 'Process Deviation', NULL, NULL),
(7, 'Quality Assurance', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reject_reason`
--

DROP TABLE IF EXISTS `reject_reason`;
CREATE TABLE `reject_reason` (
  `ReasonID` int(11) NOT NULL,
  `ReasonName` varchar(255) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  `PlantID` int(11) DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `reject_reason`
--

TRUNCATE TABLE `reject_reason`;
--
-- Dumping data for table `reject_reason`
--

INSERT INTO `reject_reason` (`ReasonID`, `ReasonName`, `CategoryID`, `PlantID`, `SectionID`) VALUES
(1, 'Scratches', 1, NULL, NULL),
(2, 'Dents', 2, NULL, NULL),
(3, 'Scratch / Dent', 1, NULL, NULL),
(4, 'Wrong Color / Shade', 1, NULL, NULL),
(5, 'Material Contamination', 1, NULL, NULL),
(6, 'Dimension Out of Tolerance', 1, NULL, NULL),
(7, 'Tool Breakage', 2, NULL, NULL),
(8, 'Overheating', 2, NULL, NULL),
(9, 'Power Failure', 2, NULL, NULL),
(10, 'Calibration Drift', 2, NULL, NULL),
(11, 'Handling Damage', 3, NULL, NULL),
(12, 'Incorrect Setup', 3, NULL, NULL),
(13, 'Packaging Error', 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
CREATE TABLE `section` (
  `SectionID` int(11) NOT NULL,
  `Name` varchar(150) NOT NULL,
  `PlantID` int(11) NOT NULL,
  `Description` text DEFAULT NULL,
  `FloorAreaSqM` decimal(10,2) DEFAULT 0.00,
  `MaxCapacity` int(11) DEFAULT 0,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `section`
--

TRUNCATE TABLE `section`;
--
-- Dumping data for table `section`
--

INSERT INTO `section` (`SectionID`, `Name`, `PlantID`, `Description`, `FloorAreaSqM`, `MaxCapacity`, `CreatedAt`, `UpdatedAt`) VALUES
(472, 'Raw Materials & Coil Storage', 158, 'Incoming coil storage area', 1500.00, 500, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(473, 'Processing Floor', 158, 'Main manufacturing line', 3000.00, 50, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(474, 'Packaging & Shipping', 158, 'Final goods preparation', 1000.00, 20, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(475, 'Raw Materials & Coil Storage', 159, 'Incoming coil storage area', 1500.00, 500, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(476, 'Processing Floor', 159, 'Main manufacturing line', 3000.00, 50, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(477, 'Packaging & Shipping', 159, 'Final goods preparation', 1000.00, 20, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(478, 'Raw Materials & Coil Storage', 160, 'Incoming coil storage area', 1500.00, 500, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(479, 'Processing Floor', 160, 'Main manufacturing line', 3000.00, 50, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(480, 'Packaging & Shipping', 160, 'Final goods preparation', 1000.00, 20, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(481, 'Raw Materials & Coil Storage', 161, 'Incoming coil storage area', 1500.00, 500, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(482, 'Processing Floor', 161, 'Main manufacturing line', 3000.00, 50, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(483, 'Packaging & Shipping', 161, 'Final goods preparation', 1000.00, 20, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(484, 'Raw Materials & Coil Storage', 162, 'Incoming coil storage area', 1500.00, 500, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(485, 'Processing Floor', 162, 'Main manufacturing line', 3000.00, 50, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(486, 'Packaging & Shipping', 162, 'Final goods preparation', 1000.00, 20, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(487, 'Raw Materials & Coil Storage', 163, 'Incoming coil storage area', 1500.00, 500, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(488, 'Processing Floor', 163, 'Main manufacturing line', 3000.00, 50, '2025-12-26 19:35:42', '2025-12-26 19:35:42'),
(489, 'Packaging & Shipping', 163, 'Final goods preparation', 1000.00, 20, '2025-12-26 19:35:42', '2025-12-26 19:35:42');

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

DROP TABLE IF EXISTS `shifts`;
CREATE TABLE `shifts` (
  `ShiftID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `StartDate` datetime NOT NULL,
  `EndDate` datetime DEFAULT NULL,
  `OperatorID` int(11) DEFAULT NULL,
  `ShiftProduction` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `shifts`
--

TRUNCATE TABLE `shifts`;
-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `OperatorID` int(11) NOT NULL,
  `OperatorUsername` varchar(50) NOT NULL,
  `OperatorPassword` varchar(255) NOT NULL,
  `OperatorRoles` varchar(255) NOT NULL DEFAULT 'operator',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `user`
--

TRUNCATE TABLE `user`;
--
-- Dumping data for table `user`
--

INSERT INTO `user` (`OperatorID`, `OperatorUsername`, `OperatorPassword`, `OperatorRoles`, `CreatedAt`, `UpdatedAt`) VALUES
(1, '__BO__ADMIN', '$2y$10$vmKrs6Z/urZHVJOTu/BeDeeIDsdibrfzuDCZQTNEeSx33L0R.sfs6', 'admin', '2025-10-04 11:36:07', '2026-04-21 14:15:46'),
(2, 'Operator2', '0000', 'operator', '2026-01-23 16:06:30', '2026-01-23 16:06:30'),
(3, 'Operator1', '0000', 'operator', '2026-01-23 16:06:38', '2026-01-23 16:06:38');

-- --------------------------------------------------------

--
-- Table structure for table `wago`
--

DROP TABLE IF EXISTS `wago`;
CREATE TABLE `wago` (
  `LogID` int(11) NOT NULL,
  `MachineID` int(11) DEFAULT 1,
  `Timestamp` datetime NOT NULL,
  `ProductionCount` int(11) NOT NULL DEFAULT 1,
  `Processed` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `wago`
--

TRUNCATE TABLE `wago`;
--
-- Dumping data for table `wago`
--

INSERT INTO `wago` (`LogID`, `MachineID`, `Timestamp`, `ProductionCount`, `Processed`) VALUES
(1, 1, '2025-10-03 12:00:00', 1, 0),
(2, 1, '2025-10-03 12:01:00', 1, 0),
(3, 7, '2026-01-23 15:51:05', 3, 0),
(4, 4, '2026-01-23 15:51:07', 3, 0),
(5, 3, '2026-01-23 15:51:09', 2, 0),
(6, 6, '2026-01-23 15:51:11', 3, 0),
(7, 1, '2026-01-23 15:51:13', 3, 0),
(8, 5, '2026-01-23 15:51:14', 5, 0),
(9, 6, '2026-02-23 09:20:11', 4, 0),
(10, 7, '2026-02-23 09:20:12', 4, 0),
(11, 1, '2026-02-23 09:20:13', 5, 0),
(12, 6, '2026-02-23 09:20:16', 3, 0),
(13, 6, '2026-02-23 09:20:18', 2, 0),
(14, 3, '2026-02-23 09:20:20', 3, 0),
(15, 4, '2026-02-23 09:20:21', 1, 0),
(16, 6, '2026-02-23 09:20:22', 5, 0),
(17, 5, '2026-02-23 09:20:23', 3, 0),
(18, 5, '2026-02-23 09:20:24', 5, 0),
(19, 1, '2026-02-23 09:20:25', 1, 0),
(20, 3, '2026-02-23 09:20:27', 1, 0),
(21, 4, '2026-02-23 09:20:27', 5, 0),
(22, 7, '2026-02-23 09:20:28', 1, 0),
(23, 7, '2026-02-23 09:20:29', 5, 0),
(24, 7, '2026-02-23 09:20:30', 2, 0),
(25, 3, '2026-02-23 09:20:32', 2, 0),
(26, 6, '2026-02-23 09:20:33', 5, 0),
(27, 5, '2026-02-23 09:20:34', 2, 0),
(28, 5, '2026-02-23 09:20:36', 3, 0),
(29, 3, '2026-02-23 09:20:38', 5, 0),
(30, 4, '2026-02-23 09:20:39', 4, 0),
(31, 4, '2026-02-23 09:20:40', 5, 0),
(32, 1, '2026-02-23 09:20:41', 4, 0),
(33, 5, '2026-02-23 09:20:42', 2, 0),
(34, 1, '2026-02-23 09:20:44', 1, 0),
(35, 6, '2026-02-23 09:20:45', 5, 0),
(36, 3, '2026-02-23 09:20:48', 4, 0),
(37, 6, '2026-02-23 09:20:50', 1, 0),
(38, 4, '2026-02-23 09:20:52', 5, 0),
(39, 6, '2026-02-23 09:20:54', 1, 0),
(40, 3, '2026-02-23 09:20:55', 5, 0),
(41, 4, '2026-02-23 09:20:58', 3, 0),
(42, 4, '2026-02-23 09:20:59', 1, 0),
(43, 7, '2026-02-23 09:21:01', 4, 0),
(44, 6, '2026-02-23 09:21:02', 3, 0),
(45, 1, '2026-02-23 09:21:04', 3, 0),
(46, 4, '2026-02-23 09:21:06', 4, 0),
(47, 5, '2026-02-23 09:21:08', 4, 0),
(48, 7, '2026-02-23 09:21:08', 5, 0),
(49, 7, '2026-02-23 09:21:10', 1, 0),
(50, 3, '2026-02-23 09:21:12', 5, 0),
(51, 7, '2026-02-23 09:21:13', 4, 0),
(52, 1, '2026-02-23 09:21:14', 3, 0),
(53, 3, '2026-02-23 09:21:16', 4, 0),
(54, 1, '2026-02-23 09:21:18', 2, 0),
(55, 1, '2026-02-23 09:21:19', 1, 0),
(56, 7, '2026-02-23 09:21:20', 2, 0),
(57, 7, '2026-02-23 09:21:23', 2, 0),
(58, 6, '2026-02-23 09:21:24', 1, 0),
(59, 3, '2026-02-23 09:21:25', 5, 0),
(60, 6, '2026-02-23 09:21:26', 1, 0),
(61, 3, '2026-02-23 09:21:29', 5, 0),
(62, 1, '2026-02-23 09:21:31', 2, 0),
(63, 4, '2026-02-23 09:21:32', 3, 0),
(64, 4, '2026-02-23 09:21:33', 4, 0),
(65, 4, '2026-02-23 09:21:35', 2, 0),
(66, 7, '2026-02-23 09:21:36', 1, 0),
(67, 7, '2026-02-23 09:21:38', 5, 0),
(68, 7, '2026-02-23 09:21:39', 3, 0),
(69, 7, '2026-02-23 09:21:40', 3, 0),
(70, 4, '2026-02-23 09:21:42', 5, 0),
(71, 5, '2026-02-23 09:21:44', 2, 0),
(72, 1, '2026-02-23 09:21:46', 4, 0),
(73, 5, '2026-02-23 09:21:48', 4, 0),
(74, 5, '2026-02-23 09:21:49', 5, 0),
(75, 3, '2026-02-23 09:21:50', 2, 0),
(76, 7, '2026-02-23 09:21:52', 4, 0),
(77, 5, '2026-02-23 09:21:55', 2, 0),
(78, 6, '2026-02-23 09:21:55', 3, 0),
(79, 4, '2026-02-23 09:21:56', 4, 0),
(80, 6, '2026-02-23 09:21:59', 5, 0),
(81, 5, '2026-02-23 09:22:02', 3, 0),
(82, 6, '2026-02-23 09:22:03', 5, 0),
(83, 5, '2026-02-23 09:22:05', 1, 0),
(84, 4, '2026-02-23 09:22:07', 5, 0),
(85, 3, '2026-02-23 09:22:09', 5, 0),
(86, 3, '2026-02-23 09:22:11', 4, 0),
(87, 3, '2026-02-23 09:22:13', 4, 0),
(88, 7, '2026-02-23 09:22:15', 3, 0),
(89, 1, '2026-02-23 09:22:17', 4, 0),
(90, 1, '2026-02-23 09:22:20', 4, 0),
(91, 5, '2026-02-23 09:22:21', 2, 0),
(92, 3, '2026-02-23 09:22:22', 5, 0),
(93, 6, '2026-02-23 09:22:24', 2, 0),
(94, 7, '2026-02-23 09:22:25', 2, 0),
(95, 3, '2026-02-23 09:22:25', 1, 0),
(96, 6, '2026-02-23 09:22:27', 3, 0),
(97, 3, '2026-02-23 09:22:28', 5, 0),
(98, 6, '2026-02-23 09:22:30', 5, 0),
(99, 6, '2026-02-23 09:22:30', 3, 0),
(100, 5, '2026-02-23 09:22:31', 5, 0),
(101, 1, '2026-02-23 09:22:33', 5, 0),
(102, 5, '2026-02-23 09:22:34', 4, 0),
(103, 4, '2026-02-23 09:22:35', 2, 0),
(104, 5, '2026-02-23 09:22:36', 3, 0),
(105, 1, '2026-02-23 09:22:37', 5, 0),
(106, 5, '2026-02-23 09:22:39', 4, 0),
(107, 3, '2026-02-23 09:22:40', 2, 0),
(108, 1, '2026-02-23 09:22:41', 5, 0),
(109, 4, '2026-02-23 09:22:42', 3, 0),
(110, 6, '2026-02-23 09:22:44', 2, 0),
(111, 4, '2026-02-23 09:22:46', 1, 0),
(112, 5, '2026-02-23 09:22:48', 1, 0),
(113, 5, '2026-02-23 09:22:51', 3, 0),
(114, 6, '2026-02-23 09:22:53', 1, 0),
(115, 3, '2026-02-23 09:22:55', 4, 0),
(116, 6, '2026-02-23 09:22:58', 2, 0),
(117, 3, '2026-02-23 09:23:01', 5, 0),
(118, 6, '2026-02-23 09:23:04', 2, 0),
(119, 6, '2026-02-23 09:23:05', 4, 0),
(120, 7, '2026-02-23 09:23:07', 1, 0),
(121, 6, '2026-02-23 09:23:09', 3, 0),
(122, 4, '2026-02-23 09:23:10', 4, 0),
(123, 3, '2026-02-23 09:23:11', 3, 0),
(124, 6, '2026-02-23 09:23:12', 1, 0),
(125, 7, '2026-02-23 09:23:13', 4, 0),
(126, 7, '2026-02-23 09:23:13', 3, 0),
(127, 4, '2026-02-23 09:23:14', 2, 0),
(128, 4, '2026-02-23 09:23:16', 4, 0),
(129, 5, '2026-02-23 09:23:18', 5, 0),
(130, 5, '2026-02-23 09:23:19', 3, 0),
(131, 5, '2026-02-23 09:23:20', 4, 0),
(132, 1, '2026-02-23 09:23:22', 3, 0),
(133, 7, '2026-02-23 09:23:24', 4, 0),
(134, 4, '2026-02-23 09:23:26', 4, 0),
(135, 7, '2026-02-23 09:23:27', 5, 0),
(136, 3, '2026-02-23 09:23:29', 5, 0),
(137, 7, '2026-02-23 09:23:31', 2, 0),
(138, 4, '2026-02-23 09:23:32', 2, 0),
(139, 6, '2026-02-23 09:23:34', 3, 0),
(140, 3, '2026-02-23 09:23:35', 4, 0),
(141, 3, '2026-02-23 09:23:38', 4, 0),
(142, 1, '2026-02-23 09:23:39', 5, 0),
(143, 4, '2026-02-23 09:23:41', 1, 0),
(144, 1, '2026-02-23 09:23:42', 3, 0),
(145, 7, '2026-02-23 09:23:44', 5, 0),
(146, 5, '2026-02-23 09:23:45', 3, 0),
(147, 6, '2026-02-23 09:23:48', 3, 0),
(148, 4, '2026-02-23 09:23:49', 1, 0),
(149, 6, '2026-02-23 09:23:51', 2, 0),
(150, 5, '2026-02-23 09:23:53', 1, 0),
(151, 3, '2026-02-23 09:23:54', 1, 0),
(152, 5, '2026-02-23 09:23:57', 2, 0),
(153, 1, '2026-02-23 09:23:58', 3, 0),
(154, 5, '2026-02-23 09:24:00', 1, 0),
(155, 5, '2026-02-23 09:24:00', 5, 0),
(156, 4, '2026-02-23 09:24:02', 3, 0),
(157, 6, '2026-02-23 09:24:05', 2, 0),
(158, 3, '2026-02-23 09:24:07', 3, 0),
(159, 1, '2026-02-23 09:24:09', 3, 0),
(160, 5, '2026-02-23 09:24:12', 3, 0),
(161, 7, '2026-02-23 09:24:13', 5, 0),
(162, 1, '2026-02-23 09:24:16', 3, 0),
(163, 5, '2026-02-23 09:24:18', 5, 0),
(164, 1, '2026-02-23 09:24:19', 1, 0),
(165, 6, '2026-02-23 09:24:21', 1, 0),
(166, 4, '2026-02-23 09:24:24', 1, 0),
(167, 1, '2026-02-23 09:24:25', 5, 0),
(168, 5, '2026-02-23 09:24:26', 5, 0),
(169, 3, '2026-02-23 09:24:27', 4, 0),
(170, 7, '2026-02-23 09:24:29', 5, 0),
(171, 4, '2026-02-23 09:24:30', 4, 0),
(172, 3, '2026-02-23 09:24:31', 5, 0),
(173, 1, '2026-02-23 09:24:33', 4, 0),
(174, 4, '2026-02-23 10:41:25', 5, 0),
(175, 6, '2026-02-23 10:41:27', 5, 0),
(176, 7, '2026-02-23 10:41:27', 1, 0),
(177, 1, '2026-02-23 10:51:20', 5, 0),
(178, 6, '2026-02-23 10:51:20', 4, 0),
(179, 5, '2026-02-23 10:51:20', 3, 0),
(180, 5, '2026-02-23 10:51:20', 1, 0),
(181, 7, '2026-02-23 10:51:21', 3, 0),
(182, 1, '2026-02-23 10:51:21', 1, 0),
(183, 3, '2026-02-23 10:51:21', 2, 0),
(184, 6, '2026-02-23 10:51:21', 4, 0),
(185, 5, '2026-02-23 10:51:21', 4, 0),
(186, 4, '2026-02-23 10:51:21', 5, 0),
(187, 5, '2026-02-23 10:51:21', 2, 0),
(188, 3, '2026-02-23 10:51:21', 5, 0),
(189, 1, '2026-02-23 10:51:21', 4, 0),
(190, 1, '2026-02-23 10:51:21', 2, 0),
(191, 3, '2026-02-23 10:51:21', 3, 0),
(192, 5, '2026-02-23 10:51:21', 4, 0),
(193, 1, '2026-02-23 10:51:21', 1, 0),
(194, 1, '2026-02-23 10:51:21', 1, 0),
(195, 1, '2026-02-23 10:51:21', 5, 0),
(196, 5, '2026-02-23 10:51:21', 3, 0),
(197, 3, '2026-02-23 10:51:21', 2, 0),
(198, 5, '2026-02-23 10:51:21', 2, 0),
(199, 6, '2026-02-23 10:51:21', 3, 0),
(200, 7, '2026-02-23 10:51:21', 3, 0),
(201, 3, '2026-02-23 10:51:21', 1, 0),
(202, 3, '2026-02-23 10:51:21', 2, 0),
(203, 4, '2026-02-23 10:51:21', 1, 0),
(204, 1, '2026-02-23 10:51:21', 1, 0),
(205, 4, '2026-02-23 10:51:21', 1, 0),
(206, 1, '2026-02-23 10:51:21', 3, 0),
(207, 6, '2026-02-23 10:51:21', 3, 0),
(208, 5, '2026-02-23 10:51:21', 3, 0),
(209, 4, '2026-02-23 10:51:21', 4, 0),
(210, 6, '2026-02-23 10:51:21', 3, 0),
(211, 6, '2026-02-23 10:51:21', 2, 0),
(212, 1, '2026-02-23 10:51:21', 1, 0),
(213, 4, '2026-02-23 10:51:21', 1, 0),
(214, 6, '2026-02-23 10:51:21', 4, 0),
(215, 7, '2026-02-23 10:51:21', 5, 0),
(216, 6, '2026-02-23 10:51:21', 5, 0),
(217, 5, '2026-02-23 10:51:21', 5, 0),
(218, 1, '2026-02-23 10:51:21', 5, 0),
(219, 5, '2026-02-23 10:51:21', 4, 0),
(220, 7, '2026-02-23 10:51:21', 1, 0),
(221, 6, '2026-02-23 10:51:21', 4, 0),
(222, 4, '2026-02-23 10:51:21', 1, 0),
(223, 7, '2026-02-23 10:51:21', 3, 0),
(224, 3, '2026-02-23 10:51:21', 5, 0),
(225, 7, '2026-02-23 10:51:21', 5, 0),
(226, 4, '2026-02-23 10:51:21', 1, 0),
(227, 6, '2026-02-23 10:51:21', 2, 0),
(228, 7, '2026-02-23 10:51:21', 2, 0),
(229, 4, '2026-02-23 10:51:21', 5, 0),
(230, 7, '2026-02-23 10:51:21', 4, 0),
(231, 1, '2026-02-23 10:51:21', 5, 0),
(232, 3, '2026-02-23 10:51:21', 4, 0),
(233, 7, '2026-02-23 10:51:21', 5, 0),
(234, 4, '2026-02-23 10:51:21', 3, 0),
(235, 7, '2026-02-23 10:51:21', 5, 0),
(236, 5, '2026-02-23 10:51:21', 1, 0),
(237, 4, '2026-02-23 10:51:21', 2, 0),
(238, 7, '2026-02-23 10:51:21', 4, 0),
(239, 6, '2026-02-23 10:51:21', 4, 0),
(240, 3, '2026-02-23 10:51:21', 3, 0),
(241, 5, '2026-02-23 10:51:21', 2, 0),
(242, 3, '2026-02-23 10:51:21', 4, 0),
(243, 7, '2026-02-23 10:51:21', 3, 0),
(244, 3, '2026-02-23 10:51:21', 3, 0),
(245, 6, '2026-02-23 10:51:21', 3, 0),
(246, 7, '2026-02-23 10:51:22', 1, 0),
(247, 1, '2026-02-23 10:51:22', 3, 0),
(248, 3, '2026-02-23 10:51:22', 1, 0),
(249, 3, '2026-02-23 10:51:22', 4, 0),
(250, 6, '2026-02-23 10:51:22', 3, 0),
(251, 4, '2026-02-23 10:51:22', 4, 0),
(252, 7, '2026-02-23 10:51:22', 2, 0),
(253, 7, '2026-02-23 10:51:22', 1, 0),
(254, 4, '2026-02-23 10:51:22', 2, 0),
(255, 6, '2026-02-23 10:51:22', 3, 0),
(256, 6, '2026-02-23 10:51:22', 3, 0),
(257, 7, '2026-02-23 10:51:22', 3, 0),
(258, 3, '2026-02-23 10:51:22', 1, 0),
(259, 3, '2026-02-23 10:51:22', 1, 0),
(260, 7, '2026-02-23 10:51:22', 3, 0),
(261, 4, '2026-02-23 10:51:22', 2, 0),
(262, 7, '2026-02-23 10:51:22', 1, 0),
(263, 1, '2026-02-23 10:51:22', 4, 0),
(264, 7, '2026-02-23 10:51:22', 1, 0),
(265, 6, '2026-02-23 10:51:22', 5, 0),
(266, 3, '2026-02-23 10:51:22', 5, 0),
(267, 3, '2026-02-23 10:51:22', 5, 0),
(268, 7, '2026-02-23 10:51:22', 5, 0),
(269, 6, '2026-02-23 10:51:22', 5, 0),
(270, 1, '2026-02-23 10:51:22', 5, 0),
(271, 5, '2026-02-23 10:51:22', 4, 0),
(272, 5, '2026-02-23 10:51:22', 2, 0),
(273, 4, '2026-02-23 10:51:22', 4, 0),
(274, 7, '2026-02-23 10:51:22', 4, 0),
(275, 3, '2026-02-23 10:51:22', 5, 0),
(276, 1, '2026-02-23 10:51:22', 1, 0),
(277, 3, '2026-02-23 10:51:22', 5, 0),
(278, 7, '2026-02-23 10:51:22', 5, 0),
(279, 1, '2026-02-23 10:51:22', 5, 0),
(280, 7, '2026-02-23 10:51:22', 5, 0),
(281, 5, '2026-02-23 10:51:22', 3, 0),
(282, 4, '2026-02-23 10:51:22', 2, 0),
(283, 3, '2026-02-23 10:51:22', 4, 0),
(284, 7, '2026-02-23 10:51:22', 4, 0),
(285, 7, '2026-02-23 10:51:22', 4, 0),
(286, 6, '2026-02-23 10:51:22', 1, 0),
(287, 3, '2026-02-23 10:51:22', 2, 0),
(288, 5, '2026-02-23 10:51:22', 4, 0),
(289, 6, '2026-02-23 10:51:22', 3, 0),
(290, 3, '2026-02-23 10:51:22', 4, 0),
(291, 5, '2026-02-23 10:51:22', 5, 0),
(292, 7, '2026-02-23 10:51:22', 5, 0),
(293, 4, '2026-02-23 10:51:22', 5, 0),
(294, 1, '2026-02-23 10:51:22', 3, 0),
(295, 4, '2026-02-23 10:51:22', 4, 0),
(296, 4, '2026-02-23 10:51:22', 1, 0),
(297, 4, '2026-02-23 10:51:22', 4, 0),
(298, 1, '2026-02-23 10:51:22', 5, 0),
(299, 4, '2026-02-23 10:51:22', 3, 0),
(300, 6, '2026-02-23 10:51:22', 2, 0),
(301, 6, '2026-02-23 10:51:22', 5, 0),
(302, 3, '2026-02-23 10:51:22', 4, 0),
(303, 6, '2026-02-23 10:51:22', 4, 0),
(304, 6, '2026-02-23 10:51:22', 4, 0),
(305, 7, '2026-02-23 10:51:22', 3, 0),
(306, 1, '2026-02-23 10:51:22', 2, 0),
(307, 6, '2026-02-23 10:51:22', 1, 0),
(308, 1, '2026-02-23 10:51:22', 2, 0),
(309, 4, '2026-02-23 10:51:22', 4, 0),
(310, 7, '2026-02-23 10:51:22', 5, 0),
(311, 5, '2026-02-23 10:51:22', 4, 0),
(312, 4, '2026-02-23 10:51:22', 1, 0),
(313, 5, '2026-02-23 10:51:22', 4, 0),
(314, 6, '2026-02-23 10:51:22', 5, 0),
(315, 4, '2026-02-23 10:51:22', 4, 0),
(316, 1, '2026-02-23 10:51:22', 2, 0),
(317, 4, '2026-02-23 10:51:22', 2, 0),
(318, 3, '2026-02-23 10:51:22', 3, 0),
(319, 6, '2026-02-23 10:51:23', 4, 0),
(320, 6, '2026-02-23 10:51:23', 1, 0),
(321, 7, '2026-02-23 10:51:23', 1, 0),
(322, 5, '2026-02-23 10:51:23', 5, 0),
(323, 3, '2026-02-23 10:51:23', 1, 0),
(324, 3, '2026-02-23 10:51:23', 5, 0),
(325, 4, '2026-02-23 10:51:23', 4, 0),
(326, 6, '2026-02-23 10:51:23', 4, 0),
(327, 7, '2026-02-23 10:51:23', 1, 0),
(328, 1, '2026-02-23 10:51:23', 1, 0),
(329, 4, '2026-02-23 10:51:23', 1, 0),
(330, 5, '2026-02-23 10:51:23', 5, 0),
(331, 4, '2026-02-23 10:51:23', 4, 0),
(332, 5, '2026-02-23 10:51:23', 1, 0),
(333, 6, '2026-02-23 10:51:23', 4, 0),
(334, 3, '2026-02-23 10:51:23', 3, 0),
(335, 4, '2026-02-23 10:51:23', 4, 0),
(336, 3, '2026-02-23 10:51:23', 4, 0),
(337, 6, '2026-02-23 10:51:23', 3, 0),
(338, 1, '2026-02-23 10:51:23', 3, 0),
(339, 7, '2026-02-23 10:51:23', 4, 0),
(340, 6, '2026-02-23 10:51:23', 1, 0),
(341, 4, '2026-02-23 10:51:23', 4, 0),
(342, 6, '2026-02-23 10:51:23', 5, 0),
(343, 1, '2026-02-23 10:51:23', 4, 0),
(344, 1, '2026-02-23 10:51:23', 5, 0),
(345, 5, '2026-02-23 10:51:23', 3, 0),
(346, 3, '2026-02-23 10:51:23', 5, 0),
(347, 5, '2026-02-23 10:51:23', 2, 0),
(348, 4, '2026-02-23 10:51:23', 1, 0),
(349, 7, '2026-02-23 10:51:23', 5, 0),
(350, 6, '2026-02-23 10:51:23', 3, 0),
(351, 4, '2026-02-23 10:51:23', 1, 0),
(352, 5, '2026-02-23 10:51:23', 3, 0),
(353, 3, '2026-02-23 10:51:23', 3, 0),
(354, 5, '2026-02-23 10:51:23', 3, 0),
(355, 5, '2026-02-23 10:51:23', 3, 0),
(356, 4, '2026-02-23 10:51:23', 3, 0),
(357, 1, '2026-02-23 10:51:23', 5, 0),
(358, 3, '2026-02-23 10:51:23', 5, 0),
(359, 5, '2026-02-23 10:51:23', 5, 0),
(360, 1, '2026-02-23 10:51:23', 2, 0),
(361, 7, '2026-02-23 10:51:23', 1, 0),
(362, 1, '2026-02-23 10:51:23', 3, 0),
(363, 7, '2026-02-23 10:51:23', 4, 0),
(364, 7, '2026-02-23 10:51:23', 5, 0),
(365, 4, '2026-02-23 10:51:23', 5, 0),
(366, 6, '2026-02-23 10:51:23', 1, 0),
(367, 1, '2026-02-23 10:51:23', 5, 0),
(368, 6, '2026-02-23 10:51:23', 4, 0),
(369, 7, '2026-02-23 10:51:23', 1, 0),
(370, 6, '2026-02-23 10:51:23', 3, 0),
(371, 6, '2026-02-23 10:51:23', 3, 0),
(372, 7, '2026-02-23 10:51:23', 5, 0),
(373, 5, '2026-02-23 10:51:23', 5, 0),
(374, 4, '2026-02-23 10:51:23', 5, 0),
(375, 3, '2026-02-23 10:51:23', 4, 0),
(376, 4, '2026-02-23 10:51:23', 5, 0),
(377, 3, '2026-02-23 10:51:23', 5, 0),
(378, 3, '2026-02-23 10:51:23', 4, 0),
(379, 4, '2026-02-23 10:51:23', 3, 0),
(380, 6, '2026-02-23 10:51:23', 5, 0),
(381, 3, '2026-02-23 10:51:23', 2, 0),
(382, 6, '2026-02-23 10:51:23', 3, 0),
(383, 4, '2026-02-23 10:51:23', 2, 0),
(384, 5, '2026-02-23 10:51:23', 1, 0),
(385, 7, '2026-02-23 10:51:23', 2, 0),
(386, 5, '2026-02-23 10:51:23', 5, 0),
(387, 3, '2026-02-23 10:51:23', 5, 0),
(388, 4, '2026-02-23 10:51:23', 5, 0),
(389, 3, '2026-02-23 10:51:23', 1, 0),
(390, 5, '2026-02-23 10:51:23', 4, 0),
(391, 7, '2026-02-23 10:51:23', 3, 0),
(392, 1, '2026-02-23 10:51:23', 1, 0),
(393, 3, '2026-02-23 10:51:23', 3, 0),
(394, 1, '2026-02-23 10:51:23', 2, 0),
(395, 6, '2026-02-23 10:51:24', 3, 0),
(396, 4, '2026-02-23 10:51:24', 4, 0),
(397, 4, '2026-02-23 10:51:24', 4, 0),
(398, 5, '2026-02-23 10:51:24', 1, 0),
(399, 6, '2026-02-23 10:51:24', 5, 0),
(400, 4, '2026-02-23 10:51:24', 3, 0),
(401, 6, '2026-02-23 10:51:24', 3, 0),
(402, 5, '2026-02-23 10:51:24', 5, 0),
(403, 6, '2026-02-23 10:51:24', 5, 0),
(404, 3, '2026-02-23 10:51:24', 4, 0),
(405, 4, '2026-02-23 10:51:24', 3, 0),
(406, 1, '2026-02-23 10:51:24', 5, 0),
(407, 1, '2026-02-23 10:51:24', 3, 0),
(408, 4, '2026-02-23 10:51:24', 3, 0),
(409, 4, '2026-02-23 10:51:24', 1, 0),
(410, 5, '2026-02-23 10:51:24', 3, 0),
(411, 7, '2026-02-23 10:51:24', 5, 0),
(412, 6, '2026-02-23 10:51:24', 2, 0),
(413, 1, '2026-02-23 10:51:24', 3, 0),
(414, 7, '2026-02-23 10:51:24', 5, 0),
(415, 4, '2026-02-23 10:51:24', 5, 0),
(416, 3, '2026-02-23 10:51:24', 3, 0),
(417, 5, '2026-02-23 10:51:24', 2, 0),
(418, 7, '2026-02-23 10:51:24', 3, 0),
(419, 1, '2026-02-23 10:51:24', 2, 0),
(420, 6, '2026-02-23 10:51:24', 1, 0),
(421, 6, '2026-02-23 10:51:24', 2, 0),
(422, 5, '2026-02-23 10:51:24', 3, 0),
(423, 7, '2026-02-23 10:51:24', 2, 0),
(424, 7, '2026-02-23 10:51:24', 4, 0),
(425, 1, '2026-02-23 10:51:24', 1, 0),
(426, 7, '2026-02-23 10:51:24', 3, 0),
(427, 4, '2026-02-23 10:51:24', 3, 0),
(428, 5, '2026-02-23 10:51:24', 2, 0),
(429, 1, '2026-02-23 10:51:24', 4, 0),
(430, 4, '2026-02-23 10:51:24', 5, 0),
(431, 3, '2026-02-23 10:51:24', 3, 0),
(432, 1, '2026-02-23 10:51:24', 2, 0),
(433, 6, '2026-02-23 10:51:24', 5, 0),
(434, 1, '2026-02-23 10:51:24', 4, 0),
(435, 6, '2026-02-23 10:51:24', 2, 0),
(436, 3, '2026-02-23 10:51:24', 1, 0),
(437, 5, '2026-02-23 10:51:24', 5, 0),
(438, 3, '2026-02-23 10:51:24', 5, 0),
(439, 1, '2026-02-23 10:51:24', 3, 0),
(440, 3, '2026-02-23 10:51:24', 2, 0),
(441, 1, '2026-02-23 10:51:24', 5, 0),
(442, 5, '2026-02-23 10:51:24', 3, 0),
(443, 3, '2026-02-23 10:51:24', 5, 0),
(444, 3, '2026-02-23 10:51:24', 2, 0),
(445, 7, '2026-02-23 10:51:24', 5, 0),
(446, 3, '2026-02-23 10:51:24', 1, 0),
(447, 5, '2026-02-23 10:51:24', 2, 0),
(448, 1, '2026-02-23 10:51:24', 4, 0),
(449, 7, '2026-02-23 10:51:24', 1, 0),
(450, 4, '2026-02-23 10:51:24', 2, 0),
(451, 5, '2026-02-23 10:51:24', 2, 0),
(452, 5, '2026-02-23 10:51:24', 2, 0),
(453, 7, '2026-02-23 10:51:24', 4, 0),
(454, 4, '2026-02-23 10:51:24', 2, 0),
(455, 3, '2026-02-23 10:51:24', 4, 0),
(456, 6, '2026-02-23 10:51:24', 3, 0),
(457, 6, '2026-02-23 10:51:24', 2, 0),
(458, 6, '2026-02-23 10:51:24', 3, 0),
(459, 4, '2026-02-23 10:51:24', 1, 0),
(460, 4, '2026-02-23 10:51:24', 3, 0),
(461, 1, '2026-02-23 10:51:24', 1, 0),
(462, 5, '2026-02-23 10:51:24', 5, 0),
(463, 5, '2026-02-23 10:51:24', 5, 0),
(464, 3, '2026-02-23 10:51:24', 1, 0),
(465, 6, '2026-02-23 10:51:24', 4, 0),
(466, 7, '2026-02-23 10:51:24', 4, 0),
(467, 4, '2026-02-23 10:51:24', 3, 0),
(468, 6, '2026-02-23 10:51:24', 1, 0),
(469, 3, '2026-02-23 10:51:25', 2, 0),
(470, 1, '2026-02-23 10:51:25', 3, 0),
(471, 4, '2026-02-23 10:51:25', 3, 0),
(472, 7, '2026-02-23 10:51:25', 2, 0),
(473, 1, '2026-02-23 10:51:25', 4, 0),
(474, 3, '2026-02-23 10:51:25', 3, 0),
(475, 1, '2026-02-23 10:51:25', 1, 0),
(476, 7, '2026-02-23 10:51:25', 5, 0),
(477, 6, '2026-02-23 10:51:25', 5, 0),
(478, 3, '2026-02-23 10:51:25', 2, 0),
(479, 7, '2026-02-23 10:51:25', 2, 0),
(480, 6, '2026-02-23 10:51:25', 4, 0),
(481, 4, '2026-02-23 10:51:25', 5, 0),
(482, 1, '2026-02-23 10:51:25', 1, 0),
(483, 1, '2026-02-23 10:51:25', 2, 0),
(484, 6, '2026-02-23 10:51:25', 3, 0),
(485, 3, '2026-02-23 10:51:25', 2, 0),
(486, 4, '2026-02-23 10:51:25', 4, 0),
(487, 4, '2026-02-23 10:51:25', 2, 0),
(488, 7, '2026-02-23 10:51:25', 4, 0),
(489, 4, '2026-02-23 10:51:25', 5, 0),
(490, 6, '2026-02-23 10:51:25', 5, 0),
(491, 3, '2026-02-23 10:51:25', 4, 0),
(492, 6, '2026-02-23 10:51:25', 5, 0),
(493, 6, '2026-02-23 10:51:25', 5, 0),
(494, 4, '2026-02-23 10:51:25', 4, 0),
(495, 4, '2026-02-23 10:51:25', 2, 0),
(496, 6, '2026-02-23 10:51:25', 3, 0),
(497, 5, '2026-02-23 10:51:25', 3, 0),
(498, 7, '2026-02-23 10:51:25', 2, 0),
(499, 1, '2026-02-23 10:51:25', 1, 0),
(500, 1, '2026-02-23 10:51:25', 4, 0),
(501, 1, '2026-02-23 10:51:25', 3, 0),
(502, 6, '2026-02-23 10:51:25', 5, 0),
(503, 7, '2026-02-23 10:51:25', 4, 0),
(504, 5, '2026-02-23 10:51:25', 3, 0),
(505, 1, '2026-02-23 10:51:25', 3, 0),
(506, 1, '2026-02-23 10:51:25', 3, 0),
(507, 6, '2026-02-23 10:51:25', 2, 0),
(508, 4, '2026-02-23 10:51:25', 1, 0),
(509, 1, '2026-02-23 10:51:25', 5, 0),
(510, 1, '2026-02-23 10:51:25', 5, 0),
(511, 1, '2026-02-23 10:51:25', 5, 0),
(512, 7, '2026-02-23 10:51:25', 2, 0),
(513, 7, '2026-02-23 10:51:25', 2, 0),
(514, 4, '2026-02-23 10:51:25', 4, 0),
(515, 5, '2026-02-23 10:51:25', 4, 0),
(516, 1, '2026-02-23 10:51:25', 3, 0),
(517, 5, '2026-02-23 10:51:25', 3, 0),
(518, 3, '2026-02-23 10:51:25', 3, 0),
(519, 5, '2026-02-23 10:51:25', 4, 0),
(520, 4, '2026-02-23 10:51:25', 2, 0),
(521, 3, '2026-02-23 10:51:25', 4, 0),
(522, 4, '2026-02-23 10:51:25', 3, 0),
(523, 7, '2026-02-23 10:51:25', 5, 0),
(524, 1, '2026-02-23 10:51:25', 4, 0),
(525, 5, '2026-02-23 10:51:25', 1, 0),
(526, 6, '2026-02-23 10:51:25', 3, 0),
(527, 7, '2026-02-23 10:51:25', 4, 0),
(528, 5, '2026-02-23 10:51:25', 4, 0),
(529, 7, '2026-02-23 10:51:25', 5, 0),
(530, 5, '2026-02-23 10:51:25', 5, 0),
(531, 1, '2026-02-23 10:51:25', 4, 0),
(532, 7, '2026-02-23 10:51:25', 2, 0),
(533, 5, '2026-02-23 10:51:25', 3, 0),
(534, 5, '2026-02-23 10:51:25', 5, 0),
(535, 7, '2026-02-23 10:51:25', 2, 0),
(536, 3, '2026-02-23 10:51:25', 1, 0),
(537, 5, '2026-02-23 10:51:25', 4, 0),
(538, 5, '2026-02-23 10:51:25', 5, 0),
(539, 1, '2026-02-23 10:51:25', 5, 0),
(540, 7, '2026-02-23 10:51:25', 4, 0),
(541, 1, '2026-02-23 10:51:26', 1, 0),
(542, 7, '2026-02-23 10:51:26', 4, 0),
(543, 5, '2026-02-23 10:51:26', 1, 0),
(544, 6, '2026-02-23 10:51:26', 3, 0),
(545, 5, '2026-02-23 10:51:26', 2, 0),
(546, 3, '2026-02-23 10:51:26', 5, 0),
(547, 5, '2026-02-23 10:51:26', 4, 0),
(548, 1, '2026-02-23 10:51:26', 4, 0),
(549, 6, '2026-02-23 10:51:26', 4, 0),
(550, 4, '2026-02-23 12:50:42', 1, 0),
(551, 5, '2026-02-23 12:50:42', 4, 0),
(552, 7, '2026-02-23 12:50:42', 5, 0),
(553, 5, '2026-02-23 12:50:42', 2, 0),
(554, 1, '2026-02-23 12:50:42', 1, 0),
(555, 1, '2026-02-23 12:50:42', 3, 0),
(556, 1, '2026-02-23 12:50:42', 3, 0),
(557, 1, '2026-02-23 12:50:42', 4, 0),
(558, 7, '2026-02-23 12:50:42', 4, 0),
(559, 6, '2026-02-23 12:50:42', 5, 0),
(560, 6, '2026-02-23 12:50:42', 2, 0),
(561, 4, '2026-02-23 12:50:42', 1, 0),
(562, 7, '2026-02-23 12:50:42', 4, 0),
(563, 7, '2026-02-23 12:50:42', 3, 0),
(564, 7, '2026-02-23 12:50:42', 2, 0),
(565, 5, '2026-02-23 12:50:42', 3, 0),
(566, 4, '2026-02-23 12:50:42', 3, 0),
(567, 6, '2026-02-23 12:50:42', 5, 0),
(568, 1, '2026-02-23 12:50:42', 3, 0),
(569, 1, '2026-02-23 12:50:42', 3, 0),
(570, 4, '2026-02-23 12:50:42', 3, 0),
(571, 5, '2026-02-23 12:50:42', 1, 0),
(572, 3, '2026-02-23 12:50:42', 3, 0),
(573, 3, '2026-02-23 12:50:42', 1, 0),
(574, 5, '2026-02-23 12:50:42', 4, 0),
(575, 1, '2026-02-23 12:50:42', 2, 0),
(576, 1, '2026-02-23 12:50:42', 3, 0),
(577, 7, '2026-02-23 12:50:42', 2, 0),
(578, 1, '2026-02-23 12:50:42', 4, 0),
(579, 4, '2026-02-23 12:50:42', 3, 0),
(580, 4, '2026-02-23 12:50:42', 1, 0),
(581, 1, '2026-02-23 12:50:42', 4, 0),
(582, 3, '2026-02-23 12:50:42', 4, 0),
(583, 5, '2026-02-23 12:50:42', 4, 0),
(584, 1, '2026-02-23 12:50:42', 2, 0),
(585, 4, '2026-02-23 12:50:42', 1, 0),
(586, 1, '2026-02-23 12:50:42', 4, 0),
(587, 1, '2026-02-23 12:50:42', 4, 0),
(588, 5, '2026-02-23 12:50:42', 3, 0),
(589, 1, '2026-02-23 12:50:43', 5, 0),
(590, 7, '2026-02-23 12:50:43', 3, 0),
(591, 3, '2026-02-23 12:50:43', 1, 0),
(592, 4, '2026-02-23 12:50:43', 1, 0),
(593, 7, '2026-02-23 12:50:43', 1, 0),
(594, 7, '2026-02-23 12:50:43', 5, 0),
(595, 7, '2026-02-23 12:50:43', 3, 0),
(596, 1, '2026-02-23 12:50:43', 5, 0),
(597, 1, '2026-02-23 12:50:43', 4, 0),
(598, 5, '2026-02-23 12:50:43', 4, 0),
(599, 3, '2026-02-23 12:50:43', 3, 0),
(600, 1, '2026-02-23 12:50:43', 5, 0),
(601, 6, '2026-02-23 12:50:43', 3, 0),
(602, 4, '2026-02-23 12:50:43', 3, 0),
(603, 5, '2026-02-23 12:50:43', 1, 0),
(604, 7, '2026-02-23 12:50:43', 4, 0),
(605, 4, '2026-02-23 12:50:43', 3, 0),
(606, 3, '2026-02-23 12:50:43', 5, 0),
(607, 3, '2026-02-23 12:50:43', 3, 0),
(608, 5, '2026-02-23 12:50:43', 3, 0),
(609, 6, '2026-02-23 12:50:43', 4, 0),
(610, 3, '2026-02-23 12:50:43', 5, 0),
(611, 1, '2026-02-23 12:50:43', 3, 0),
(612, 7, '2026-02-23 12:50:43', 2, 0),
(613, 5, '2026-02-23 12:50:43', 4, 0),
(614, 5, '2026-02-23 12:50:43', 5, 0),
(615, 4, '2026-02-23 12:50:43', 1, 0),
(616, 3, '2026-02-23 12:50:43', 2, 0),
(617, 3, '2026-02-23 12:50:43', 5, 0),
(618, 4, '2026-02-23 12:50:43', 2, 0),
(619, 4, '2026-02-23 12:50:43', 4, 0),
(620, 1, '2026-02-23 12:50:43', 3, 0),
(621, 4, '2026-02-23 12:50:43', 1, 0),
(622, 6, '2026-02-23 12:50:43', 5, 0),
(623, 4, '2026-02-23 12:50:43', 4, 0),
(624, 7, '2026-02-23 12:50:43', 1, 0),
(625, 1, '2026-02-23 12:50:43', 3, 0),
(626, 3, '2026-02-23 12:50:43', 4, 0),
(627, 7, '2026-02-23 12:50:43', 3, 0),
(628, 5, '2026-02-23 12:50:43', 3, 0),
(629, 5, '2026-02-23 12:50:43', 1, 0),
(630, 1, '2026-02-23 12:50:43', 2, 0),
(631, 4, '2026-02-23 12:50:43', 4, 0),
(632, 3, '2026-02-23 12:50:43', 2, 0),
(633, 1, '2026-02-23 12:50:43', 1, 0),
(634, 4, '2026-02-23 12:50:43', 1, 0),
(635, 4, '2026-02-23 12:50:43', 4, 0),
(636, 4, '2026-02-23 12:50:43', 3, 0),
(637, 6, '2026-02-23 12:50:43', 3, 0),
(638, 4, '2026-02-23 12:50:43', 4, 0),
(639, 1, '2026-02-23 12:50:43', 5, 0),
(640, 5, '2026-02-23 12:50:43', 3, 0),
(641, 3, '2026-02-23 12:50:43', 5, 0),
(642, 7, '2026-02-23 12:50:43', 4, 0),
(643, 1, '2026-02-23 12:50:43', 3, 0),
(644, 1, '2026-02-23 12:50:43', 3, 0),
(645, 6, '2026-02-23 12:50:43', 1, 0),
(646, 7, '2026-02-23 12:50:43', 4, 0),
(647, 1, '2026-02-23 12:50:43', 3, 0),
(648, 3, '2026-02-23 12:50:43', 1, 0),
(649, 4, '2026-02-23 12:50:43', 1, 0),
(650, 7, '2026-02-23 12:50:43', 1, 0),
(651, 4, '2026-02-23 12:50:43', 2, 0),
(652, 5, '2026-02-23 12:50:43', 2, 0),
(653, 1, '2026-02-23 12:50:43', 1, 0),
(654, 6, '2026-02-23 12:50:44', 1, 0),
(655, 6, '2026-02-23 12:50:44', 1, 0),
(656, 6, '2026-02-23 12:50:44', 2, 0),
(657, 3, '2026-02-23 12:50:44', 3, 0),
(658, 7, '2026-02-23 12:50:44', 1, 0),
(659, 3, '2026-02-23 12:50:44', 1, 0),
(660, 4, '2026-02-23 12:50:44', 2, 0),
(661, 4, '2026-02-23 12:50:44', 2, 0),
(662, 6, '2026-02-23 12:50:44', 3, 0),
(663, 1, '2026-02-23 12:50:44', 3, 0),
(664, 5, '2026-02-23 12:50:44', 5, 0),
(665, 3, '2026-02-23 12:50:44', 3, 0),
(666, 4, '2026-02-23 12:50:44', 5, 0),
(667, 3, '2026-02-23 12:50:44', 4, 0),
(668, 7, '2026-02-23 12:50:44', 5, 0),
(669, 5, '2026-02-23 12:50:44', 4, 0),
(670, 5, '2026-02-23 12:50:44', 2, 0),
(671, 4, '2026-02-23 12:50:44', 1, 0),
(672, 3, '2026-02-23 12:50:44', 3, 0),
(673, 1, '2026-02-23 12:50:44', 3, 0),
(674, 4, '2026-02-23 12:50:44', 4, 0),
(675, 3, '2026-02-23 12:50:44', 4, 0),
(676, 5, '2026-02-23 12:50:44', 5, 0),
(677, 3, '2026-02-23 12:50:44', 4, 0),
(678, 1, '2026-02-23 12:50:44', 4, 0),
(679, 4, '2026-02-23 12:50:44', 2, 0),
(680, 4, '2026-02-23 12:50:44', 1, 0),
(681, 6, '2026-02-23 12:50:44', 5, 0),
(682, 3, '2026-02-23 12:50:44', 1, 0),
(683, 5, '2026-02-23 12:50:44', 1, 0),
(684, 7, '2026-02-23 12:50:44', 5, 0),
(685, 3, '2026-02-23 12:50:44', 5, 0),
(686, 6, '2026-02-23 12:50:44', 2, 0),
(687, 3, '2026-02-23 12:50:44', 5, 0),
(688, 7, '2026-02-23 12:50:44', 4, 0),
(689, 1, '2026-02-23 12:50:44', 3, 0),
(690, 3, '2026-02-23 12:50:44', 3, 0),
(691, 7, '2026-02-23 12:50:44', 3, 0),
(692, 4, '2026-02-23 12:50:44', 3, 0),
(693, 7, '2026-02-23 12:50:44', 2, 0),
(694, 4, '2026-02-23 12:50:44', 5, 0),
(695, 1, '2026-02-23 12:50:44', 5, 0),
(696, 4, '2026-02-23 12:50:44', 4, 0),
(697, 3, '2026-02-23 12:50:44', 2, 0),
(698, 6, '2026-02-23 12:50:44', 5, 0),
(699, 1, '2026-02-23 12:50:44', 2, 0),
(700, 3, '2026-02-23 12:50:44', 3, 0),
(701, 4, '2026-02-23 12:50:44', 2, 0),
(702, 1, '2026-02-23 12:50:44', 5, 0),
(703, 1, '2026-02-23 12:50:44', 5, 0),
(704, 4, '2026-02-23 12:50:44', 4, 0),
(705, 3, '2026-02-23 12:50:44', 1, 0),
(706, 6, '2026-02-23 12:50:44', 4, 0),
(707, 4, '2026-02-23 12:50:44', 2, 0),
(708, 5, '2026-02-23 14:48:46', 4, 0),
(709, 7, '2026-02-23 15:15:08', 1, 0),
(710, 5, '2026-02-23 15:15:09', 3, 0),
(711, 1, '2026-02-24 09:11:46', 1, 0),
(712, 5, '2026-02-24 09:11:49', 5, 0),
(713, 7, '2026-02-24 09:11:51', 3, 0),
(714, 3, '2026-02-24 09:11:52', 2, 0),
(715, 1, '2026-02-24 09:11:54', 2, 0),
(716, 6, '2026-02-24 09:11:57', 4, 0),
(717, 4, '2026-02-24 09:11:58', 3, 0),
(718, 5, '2026-02-24 09:12:01', 4, 0),
(719, 4, '2026-02-24 09:12:03', 5, 0),
(720, 7, '2026-02-24 09:12:05', 5, 0),
(721, 1, '2026-02-24 09:12:07', 3, 0),
(722, 6, '2026-02-24 09:12:09', 4, 0),
(723, 7, '2026-02-24 09:12:12', 4, 0),
(724, 6, '2026-02-24 09:12:14', 1, 0),
(725, 7, '2026-02-24 09:12:16', 3, 0),
(726, 1, '2026-02-24 09:12:17', 3, 0),
(727, 1, '2026-02-24 09:12:20', 1, 0),
(728, 1, '2026-02-24 09:12:21', 5, 0),
(729, 1, '2026-02-24 09:12:21', 1, 0),
(730, 4, '2026-02-24 09:12:24', 2, 0),
(731, 7, '2026-02-24 09:12:26', 5, 0),
(732, 4, '2026-02-24 09:12:27', 3, 0),
(733, 1, '2026-02-24 09:12:30', 1, 0),
(734, 1, '2026-02-24 09:12:31', 5, 0),
(735, 5, '2026-02-24 09:12:34', 3, 0),
(736, 3, '2026-02-24 09:12:35', 5, 0),
(737, 5, '2026-02-24 09:12:38', 3, 0),
(738, 4, '2026-02-24 09:12:39', 1, 0),
(739, 6, '2026-02-24 09:12:42', 5, 0),
(740, 5, '2026-02-24 09:12:44', 3, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adjustment`
--
ALTER TABLE `adjustment`
  ADD PRIMARY KEY (`AdjustmentID`);

--
-- Indexes for table `api_audit_log`
--
ALTER TABLE `api_audit_log`
  ADD PRIMARY KEY (`AuditID`),
  ADD KEY `KeyID` (`KeyID`),
  ADD KEY `idx_audit_action` (`Action`),
  ADD KEY `idx_audit_time` (`Timestamp`);

--
-- Indexes for table `api_keys`
--
ALTER TABLE `api_keys`
  ADD PRIMARY KEY (`KeyID`),
  ADD UNIQUE KEY `KeyString` (`KeyString`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`ArticleID`),
  ADD KEY `idx_name` (`Name`),
  ADD KEY `idx_quality` (`QualityControl`);

--
-- Indexes for table `batch_log`
--
ALTER TABLE `batch_log`
  ADD PRIMARY KEY (`BatchID`),
  ADD UNIQUE KEY `BatchCode` (`BatchCode`),
  ADD KEY `ArticleID` (`ArticleID`),
  ADD KEY `OperatorID` (`OperatorID`),
  ADD KEY `MachineID` (`MachineID`),
  ADD KEY `idx_batch_code` (`BatchCode`),
  ADD KEY `idx_batch_order` (`ProductionOrderID`),
  ADD KEY `idx_batch_date` (`PrintTime`);

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`CityID`),
  ADD KEY `CountryID` (`CountryID`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`CountryID`),
  ADD UNIQUE KEY `ISOCode` (`ISOCode`);

--
-- Indexes for table `machine`
--
ALTER TABLE `machine`
  ADD PRIMARY KEY (`MachineID`),
  ADD KEY `fk_machine_plant` (`PlantID`),
  ADD KEY `fk_machine_section` (`SectionID`);

--
-- Indexes for table `machine_planning`
--
ALTER TABLE `machine_planning`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_machine_date` (`machine_code`,`plan_date`);

--
-- Indexes for table `machine_stop_category`
--
ALTER TABLE `machine_stop_category`
  ADD PRIMARY KEY (`CategoryID`),
  ADD UNIQUE KEY `CategoryName` (`CategoryName`);

--
-- Indexes for table `machine_stop_log`
--
ALTER TABLE `machine_stop_log`
  ADD PRIMARY KEY (`StopID`),
  ADD KEY `OperatorID` (`OperatorID`),
  ADD KEY `ProductionOrderID` (`ProductionOrderID`),
  ADD KEY `CategoryID` (`CategoryID`),
  ADD KEY `ReasonID` (`ReasonID`),
  ADD KEY `idx_stop_start` (`StartTime`),
  ADD KEY `idx_stop_machine` (`MachineID`);

--
-- Indexes for table `machine_stop_reason`
--
ALTER TABLE `machine_stop_reason`
  ADD PRIMARY KEY (`ReasonID`),
  ADD UNIQUE KEY `ReasonName` (`ReasonName`),
  ADD KEY `CategoryID` (`CategoryID`);

--
-- Indexes for table `operator_log`
--
ALTER TABLE `operator_log`
  ADD PRIMARY KEY (`LogID`),
  ADD KEY `OperatorID` (`OperatorID`),
  ADD KEY `MachineID` (`MachineID`);

--
-- Indexes for table `plant`
--
ALTER TABLE `plant`
  ADD PRIMARY KEY (`PlantID`),
  ADD KEY `CityID` (`CityID`);

--
-- Indexes for table `processed_production`
--
ALTER TABLE `processed_production`
  ADD PRIMARY KEY (`ProcessedID`),
  ADD KEY `LogID` (`LogID`),
  ADD KEY `OrderID` (`OrderID`);

--
-- Indexes for table `production_log`
--
ALTER TABLE `production_log`
  ADD PRIMARY KEY (`LogID`),
  ADD KEY `MachineID` (`MachineID`),
  ADD KEY `StartOperatorID` (`StartOperatorID`),
  ADD KEY `EndOperatorID` (`EndOperatorID`),
  ADD KEY `idx_prodlog_order` (`ProductionOrderID`),
  ADD KEY `idx_prodlog_date` (`StartTime`),
  ADD KEY `idx_prodlog_status` (`Status`);

--
-- Indexes for table `production_order`
--
ALTER TABLE `production_order`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `ArticleID` (`ArticleID`),
  ADD KEY `fk_order_deleted_by` (`DeletedBy`),
  ADD KEY `fk_order_recipe` (`RecipeID`);

--
-- Indexes for table `production_order_progress`
--
ALTER TABLE `production_order_progress`
  ADD PRIMARY KEY (`ProgressID`),
  ADD UNIQUE KEY `unique_order_article` (`OrderID`,`ArticleID`),
  ADD KEY `fk_pop_article` (`ArticleID`);

--
-- Indexes for table `production_recipes`
--
ALTER TABLE `production_recipes`
  ADD PRIMARY KEY (`RecipeID`),
  ADD KEY `fk_recipe_machine` (`MachineID`),
  ADD KEY `idx_recipe_lookup` (`ArticleID`,`MachineID`);

--
-- Indexes for table `raw_material_log`
--
ALTER TABLE `raw_material_log`
  ADD PRIMARY KEY (`LogID`),
  ADD KEY `OperatorID` (`OperatorID`),
  ADD KEY `ArticleID` (`ArticleID`),
  ADD KEY `MachineID` (`MachineID`),
  ADD KEY `idx_rm_batch` (`BatchCode`),
  ADD KEY `idx_rm_order` (`ProductionOrderID`),
  ADD KEY `idx_rm_date` (`ScanTime`);

--
-- Indexes for table `recipe_inputs`
--
ALTER TABLE `recipe_inputs`
  ADD PRIMARY KEY (`InputID`),
  ADD KEY `fk_recipe_inputs_recipe` (`RecipeID`),
  ADD KEY `fk_recipe_inputs_article` (`ArticleID`);

--
-- Indexes for table `recipe_outputs`
--
ALTER TABLE `recipe_outputs`
  ADD PRIMARY KEY (`OutputID`),
  ADD KEY `fk_recipe_outputs_recipe` (`RecipeID`),
  ADD KEY `fk_recipe_outputs_article` (`ArticleID`);

--
-- Indexes for table `reject`
--
ALTER TABLE `reject`
  ADD PRIMARY KEY (`RejectID`),
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `CategoryID` (`CategoryID`),
  ADD KEY `ReasonID` (`ReasonID`),
  ADD KEY `rejects_ibfk_1` (`ArticleID`),
  ADD KEY `fk_reject_operator` (`OperatorID`),
  ADD KEY `fk_reject_machine` (`MachineID`),
  ADD KEY `idx_reject_date` (`RejectDate`);

--
-- Indexes for table `reject_category`
--
ALTER TABLE `reject_category`
  ADD PRIMARY KEY (`CategoryID`),
  ADD UNIQUE KEY `CategoryName` (`CategoryName`),
  ADD KEY `fk_rc_section` (`SectionID`),
  ADD KEY `idx_rc_location` (`PlantID`,`SectionID`);

--
-- Indexes for table `reject_reason`
--
ALTER TABLE `reject_reason`
  ADD PRIMARY KEY (`ReasonID`),
  ADD UNIQUE KEY `ReasonName` (`ReasonName`),
  ADD KEY `CategoryID` (`CategoryID`),
  ADD KEY `fk_rr_section` (`SectionID`),
  ADD KEY `idx_rr_location` (`PlantID`,`SectionID`);

--
-- Indexes for table `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`SectionID`),
  ADD KEY `PlantID` (`PlantID`);

--
-- Indexes for table `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`ShiftID`),
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `OperatorID` (`OperatorID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`OperatorID`),
  ADD UNIQUE KEY `OperatorUsername` (`OperatorUsername`);

--
-- Indexes for table `wago`
--
ALTER TABLE `wago`
  ADD PRIMARY KEY (`LogID`),
  ADD KEY `idx_timestamp` (`Timestamp`),
  ADD KEY `fk_machine_id` (`MachineID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adjustment`
--
ALTER TABLE `adjustment`
  MODIFY `AdjustmentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `api_audit_log`
--
ALTER TABLE `api_audit_log`
  MODIFY `AuditID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `api_keys`
--
ALTER TABLE `api_keys`
  MODIFY `KeyID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `ArticleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `batch_log`
--
ALTER TABLE `batch_log`
  MODIFY `BatchID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `CityID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `CountryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `machine`
--
ALTER TABLE `machine`
  MODIFY `MachineID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `machine_planning`
--
ALTER TABLE `machine_planning`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4651;

--
-- AUTO_INCREMENT for table `machine_stop_category`
--
ALTER TABLE `machine_stop_category`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `machine_stop_log`
--
ALTER TABLE `machine_stop_log`
  MODIFY `StopID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `machine_stop_reason`
--
ALTER TABLE `machine_stop_reason`
  MODIFY `ReasonID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `operator_log`
--
ALTER TABLE `operator_log`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `plant`
--
ALTER TABLE `plant`
  MODIFY `PlantID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=164;

--
-- AUTO_INCREMENT for table `processed_production`
--
ALTER TABLE `processed_production`
  MODIFY `ProcessedID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `production_log`
--
ALTER TABLE `production_log`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `production_order`
--
ALTER TABLE `production_order`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `production_order_progress`
--
ALTER TABLE `production_order_progress`
  MODIFY `ProgressID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `production_recipes`
--
ALTER TABLE `production_recipes`
  MODIFY `RecipeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `raw_material_log`
--
ALTER TABLE `raw_material_log`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `recipe_inputs`
--
ALTER TABLE `recipe_inputs`
  MODIFY `InputID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `recipe_outputs`
--
ALTER TABLE `recipe_outputs`
  MODIFY `OutputID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reject`
--
ALTER TABLE `reject`
  MODIFY `RejectID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `reject_category`
--
ALTER TABLE `reject_category`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `reject_reason`
--
ALTER TABLE `reject_reason`
  MODIFY `ReasonID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `section`
--
ALTER TABLE `section`
  MODIFY `SectionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=490;

--
-- AUTO_INCREMENT for table `shifts`
--
ALTER TABLE `shifts`
  MODIFY `ShiftID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `OperatorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `wago`
--
ALTER TABLE `wago`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=741;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `api_audit_log`
--
ALTER TABLE `api_audit_log`
  ADD CONSTRAINT `fk_audit_key` FOREIGN KEY (`KeyID`) REFERENCES `api_keys` (`KeyID`) ON DELETE SET NULL;

--
-- Constraints for table `api_keys`
--
ALTER TABLE `api_keys`
  ADD CONSTRAINT `fk_apikey_user` FOREIGN KEY (`UserID`) REFERENCES `user` (`OperatorID`) ON DELETE CASCADE;

--
-- Constraints for table `batch_log`
--
ALTER TABLE `batch_log`
  ADD CONSTRAINT `batch_log_ibfk_1` FOREIGN KEY (`ProductionOrderID`) REFERENCES `production_order` (`OrderID`) ON DELETE CASCADE,
  ADD CONSTRAINT `batch_log_ibfk_2` FOREIGN KEY (`ArticleID`) REFERENCES `article` (`ArticleID`),
  ADD CONSTRAINT `batch_log_ibfk_3` FOREIGN KEY (`OperatorID`) REFERENCES `user` (`OperatorID`),
  ADD CONSTRAINT `batch_log_ibfk_4` FOREIGN KEY (`MachineID`) REFERENCES `machine` (`MachineID`);

--
-- Constraints for table `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `fk_city_country` FOREIGN KEY (`CountryID`) REFERENCES `country` (`CountryID`) ON DELETE CASCADE;

--
-- Constraints for table `machine`
--
ALTER TABLE `machine`
  ADD CONSTRAINT `fk_machine_plant` FOREIGN KEY (`PlantID`) REFERENCES `plant` (`PlantID`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_machine_section` FOREIGN KEY (`SectionID`) REFERENCES `section` (`SectionID`) ON DELETE SET NULL;

--
-- Constraints for table `machine_stop_log`
--
ALTER TABLE `machine_stop_log`
  ADD CONSTRAINT `machine_stop_log_ibfk_1` FOREIGN KEY (`MachineID`) REFERENCES `machine` (`MachineID`),
  ADD CONSTRAINT `machine_stop_log_ibfk_2` FOREIGN KEY (`OperatorID`) REFERENCES `user` (`OperatorID`),
  ADD CONSTRAINT `machine_stop_log_ibfk_3` FOREIGN KEY (`ProductionOrderID`) REFERENCES `production_order` (`OrderID`) ON DELETE SET NULL,
  ADD CONSTRAINT `machine_stop_log_ibfk_4` FOREIGN KEY (`CategoryID`) REFERENCES `machine_stop_category` (`CategoryID`) ON DELETE SET NULL,
  ADD CONSTRAINT `machine_stop_log_ibfk_5` FOREIGN KEY (`ReasonID`) REFERENCES `machine_stop_reason` (`ReasonID`) ON DELETE SET NULL;

--
-- Constraints for table `machine_stop_reason`
--
ALTER TABLE `machine_stop_reason`
  ADD CONSTRAINT `machine_stop_reason_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `machine_stop_category` (`CategoryID`) ON DELETE CASCADE;

--
-- Constraints for table `operator_log`
--
ALTER TABLE `operator_log`
  ADD CONSTRAINT `operator_log_ibfk_1` FOREIGN KEY (`OperatorID`) REFERENCES `user` (`OperatorID`),
  ADD CONSTRAINT `operator_log_ibfk_2` FOREIGN KEY (`MachineID`) REFERENCES `machine` (`MachineID`);

--
-- Constraints for table `plant`
--
ALTER TABLE `plant`
  ADD CONSTRAINT `fk_plant_city` FOREIGN KEY (`CityID`) REFERENCES `city` (`CityID`);

--
-- Constraints for table `processed_production`
--
ALTER TABLE `processed_production`
  ADD CONSTRAINT `processed_production_ibfk_1` FOREIGN KEY (`LogID`) REFERENCES `wago` (`LogID`) ON DELETE CASCADE,
  ADD CONSTRAINT `processed_production_ibfk_2` FOREIGN KEY (`OrderID`) REFERENCES `production_order` (`OrderID`) ON DELETE CASCADE;

--
-- Constraints for table `production_log`
--
ALTER TABLE `production_log`
  ADD CONSTRAINT `production_log_ibfk_1` FOREIGN KEY (`ProductionOrderID`) REFERENCES `production_order` (`OrderID`) ON DELETE CASCADE,
  ADD CONSTRAINT `production_log_ibfk_2` FOREIGN KEY (`MachineID`) REFERENCES `machine` (`MachineID`),
  ADD CONSTRAINT `production_log_ibfk_3` FOREIGN KEY (`StartOperatorID`) REFERENCES `user` (`OperatorID`),
  ADD CONSTRAINT `production_log_ibfk_4` FOREIGN KEY (`EndOperatorID`) REFERENCES `user` (`OperatorID`);

--
-- Constraints for table `production_order`
--
ALTER TABLE `production_order`
  ADD CONSTRAINT `fk_order_deleted_by` FOREIGN KEY (`DeletedBy`) REFERENCES `user` (`OperatorID`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_order_recipe` FOREIGN KEY (`RecipeID`) REFERENCES `production_recipes` (`RecipeID`) ON DELETE SET NULL;

--
-- Constraints for table `production_order_progress`
--
ALTER TABLE `production_order_progress`
  ADD CONSTRAINT `fk_pop_article` FOREIGN KEY (`ArticleID`) REFERENCES `article` (`ArticleID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pop_order` FOREIGN KEY (`OrderID`) REFERENCES `production_order` (`OrderID`) ON DELETE CASCADE;

--
-- Constraints for table `production_recipes`
--
ALTER TABLE `production_recipes`
  ADD CONSTRAINT `fk_recipe_article` FOREIGN KEY (`ArticleID`) REFERENCES `article` (`ArticleID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_recipe_machine` FOREIGN KEY (`MachineID`) REFERENCES `machine` (`MachineID`) ON DELETE CASCADE;

--
-- Constraints for table `raw_material_log`
--
ALTER TABLE `raw_material_log`
  ADD CONSTRAINT `raw_material_log_ibfk_1` FOREIGN KEY (`ProductionOrderID`) REFERENCES `production_order` (`OrderID`) ON DELETE CASCADE,
  ADD CONSTRAINT `raw_material_log_ibfk_2` FOREIGN KEY (`OperatorID`) REFERENCES `user` (`OperatorID`),
  ADD CONSTRAINT `raw_material_log_ibfk_3` FOREIGN KEY (`ArticleID`) REFERENCES `article` (`ArticleID`) ON DELETE SET NULL,
  ADD CONSTRAINT `raw_material_log_ibfk_4` FOREIGN KEY (`MachineID`) REFERENCES `machine` (`MachineID`) ON DELETE SET NULL;

--
-- Constraints for table `recipe_inputs`
--
ALTER TABLE `recipe_inputs`
  ADD CONSTRAINT `fk_recipe_inputs_article` FOREIGN KEY (`ArticleID`) REFERENCES `article` (`ArticleID`),
  ADD CONSTRAINT `fk_recipe_inputs_recipe` FOREIGN KEY (`RecipeID`) REFERENCES `production_recipes` (`RecipeID`) ON DELETE CASCADE;

--
-- Constraints for table `recipe_outputs`
--
ALTER TABLE `recipe_outputs`
  ADD CONSTRAINT `fk_recipe_outputs_article` FOREIGN KEY (`ArticleID`) REFERENCES `article` (`ArticleID`),
  ADD CONSTRAINT `fk_recipe_outputs_recipe` FOREIGN KEY (`RecipeID`) REFERENCES `production_recipes` (`RecipeID`) ON DELETE CASCADE;

--
-- Constraints for table `reject`
--
ALTER TABLE `reject`
  ADD CONSTRAINT `fk_reject_machine` FOREIGN KEY (`MachineID`) REFERENCES `machine` (`MachineID`),
  ADD CONSTRAINT `fk_reject_operator` FOREIGN KEY (`OperatorID`) REFERENCES `user` (`OperatorID`),
  ADD CONSTRAINT `reject_ibfk_1` FOREIGN KEY (`ArticleID`) REFERENCES `article` (`ArticleID`) ON DELETE CASCADE,
  ADD CONSTRAINT `reject_ibfk_2` FOREIGN KEY (`OrderID`) REFERENCES `production_order` (`OrderID`) ON DELETE CASCADE,
  ADD CONSTRAINT `reject_ibfk_3` FOREIGN KEY (`CategoryID`) REFERENCES `reject_category` (`CategoryID`) ON DELETE CASCADE,
  ADD CONSTRAINT `reject_ibfk_4` FOREIGN KEY (`ReasonID`) REFERENCES `reject_reason` (`ReasonID`) ON DELETE CASCADE;

--
-- Constraints for table `reject_category`
--
ALTER TABLE `reject_category`
  ADD CONSTRAINT `fk_rc_plant` FOREIGN KEY (`PlantID`) REFERENCES `plant` (`PlantID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rc_section` FOREIGN KEY (`SectionID`) REFERENCES `section` (`SectionID`) ON DELETE CASCADE;

--
-- Constraints for table `reject_reason`
--
ALTER TABLE `reject_reason`
  ADD CONSTRAINT `fk_rr_plant` FOREIGN KEY (`PlantID`) REFERENCES `plant` (`PlantID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rr_section` FOREIGN KEY (`SectionID`) REFERENCES `section` (`SectionID`) ON DELETE CASCADE,
  ADD CONSTRAINT `reject_reason_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `reject_category` (`CategoryID`) ON DELETE CASCADE;

--
-- Constraints for table `section`
--
ALTER TABLE `section`
  ADD CONSTRAINT `fk_section_plant` FOREIGN KEY (`PlantID`) REFERENCES `plant` (`PlantID`) ON DELETE CASCADE;

--
-- Constraints for table `shifts`
--
ALTER TABLE `shifts`
  ADD CONSTRAINT `shifts_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `production_order` (`OrderID`) ON DELETE CASCADE,
  ADD CONSTRAINT `shifts_ibfk_2` FOREIGN KEY (`OperatorID`) REFERENCES `user` (`OperatorID`) ON DELETE SET NULL;

--
-- Constraints for table `wago`
--
ALTER TABLE `wago`
  ADD CONSTRAINT `fk_machine_id` FOREIGN KEY (`MachineID`) REFERENCES `machine` (`MachineID`) ON DELETE SET NULL ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
