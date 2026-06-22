-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2026 at 09:44 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

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
CREATE TABLE IF NOT EXISTS `adjustment` (
  `AdjustmentID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductionOrderID` int(11) NOT NULL,
  `ArticleID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  PRIMARY KEY (`AdjustmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_audit_log`
--

DROP TABLE IF EXISTS `api_audit_log`;
CREATE TABLE IF NOT EXISTS `api_audit_log` (
  `AuditID` int(11) NOT NULL AUTO_INCREMENT,
  `KeyID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `Action` enum('Created','Updated','Deleted','Used','PermissionChange','ScopeChange') NOT NULL,
  `Endpoint` varchar(255) DEFAULT NULL,
  `IPAddress` varchar(45) DEFAULT NULL,
  `Details` text DEFAULT NULL,
  `Timestamp` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`AuditID`),
  KEY `KeyID` (`KeyID`),
  KEY `idx_audit_action` (`Action`),
  KEY `idx_audit_time` (`Timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_keys`
--

DROP TABLE IF EXISTS `api_keys`;
CREATE TABLE IF NOT EXISTS `api_keys` (
  `KeyID` int(11) NOT NULL AUTO_INCREMENT,
  `KeyString` varchar(64) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `UserID` int(11) NOT NULL,
  `Permissions` text DEFAULT NULL,
  `ScopePlants` text DEFAULT NULL,
  `IsActive` tinyint(1) DEFAULT 1,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `LastUsedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`KeyID`),
  UNIQUE KEY `KeyString` (`KeyString`),
  KEY `UserID` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `ArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(150) NOT NULL,
  `Description` text DEFAULT NULL,
  `ImagePath` varchar(255) DEFAULT NULL,
  `QualityControl` enum('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ArticleID`),
  KEY `idx_name` (`Name`),
  KEY `idx_quality` (`QualityControl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `batch_log`
--

DROP TABLE IF EXISTS `batch_log`;
CREATE TABLE IF NOT EXISTS `batch_log` (
  `BatchID` int(11) NOT NULL AUTO_INCREMENT,
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
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`BatchID`),
  UNIQUE KEY `BatchCode` (`BatchCode`),
  KEY `ArticleID` (`ArticleID`),
  KEY `OperatorID` (`OperatorID`),
  KEY `MachineID` (`MachineID`),
  KEY `idx_batch_code` (`BatchCode`),
  KEY `idx_batch_order` (`ProductionOrderID`),
  KEY `idx_batch_date` (`PrintTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city` (
  `CityID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `CountryID` int(11) NOT NULL,
  `PostalCode` varchar(20) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`CityID`),
  KEY `CountryID` (`CountryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `CountryID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `ISOCode` varchar(3) NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`CountryID`),
  UNIQUE KEY `ISOCode` (`ISOCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `machine`
--

DROP TABLE IF EXISTS `machine`;
CREATE TABLE IF NOT EXISTS `machine` (
  `MachineID` int(11) NOT NULL AUTO_INCREMENT,
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
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`MachineID`),
  KEY `fk_machine_plant` (`PlantID`),
  KEY `fk_machine_section` (`SectionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `machine_planning`
--

DROP TABLE IF EXISTS `machine_planning`;
CREATE TABLE IF NOT EXISTS `machine_planning` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `shift3_end` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_machine_date` (`machine_code`,`plan_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `machine_stop_category`
--

DROP TABLE IF EXISTS `machine_stop_category`;
CREATE TABLE IF NOT EXISTS `machine_stop_category` (
  `CategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(255) NOT NULL,
  PRIMARY KEY (`CategoryID`),
  UNIQUE KEY `CategoryName` (`CategoryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `machine_stop_log`
--

DROP TABLE IF EXISTS `machine_stop_log`;
CREATE TABLE IF NOT EXISTS `machine_stop_log` (
  `StopID` int(11) NOT NULL AUTO_INCREMENT,
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
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`StopID`),
  KEY `OperatorID` (`OperatorID`),
  KEY `ProductionOrderID` (`ProductionOrderID`),
  KEY `CategoryID` (`CategoryID`),
  KEY `ReasonID` (`ReasonID`),
  KEY `idx_stop_start` (`StartTime`),
  KEY `idx_stop_machine` (`MachineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `machine_stop_reason`
--

DROP TABLE IF EXISTS `machine_stop_reason`;
CREATE TABLE IF NOT EXISTS `machine_stop_reason` (
  `ReasonID` int(11) NOT NULL AUTO_INCREMENT,
  `ReasonName` varchar(255) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  PRIMARY KEY (`ReasonID`),
  UNIQUE KEY `ReasonName` (`ReasonName`),
  KEY `CategoryID` (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `operator_log`
--

DROP TABLE IF EXISTS `operator_log`;
CREATE TABLE IF NOT EXISTS `operator_log` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT,
  `OperatorID` int(11) NOT NULL,
  `MachineID` int(11) NOT NULL,
  `LoginTime` datetime DEFAULT current_timestamp(),
  `LogoutTime` datetime DEFAULT NULL,
  `DurationMinutes` float GENERATED ALWAYS AS (if(`LogoutTime` is not null,timestampdiff(MINUTE,`LoginTime`,`LogoutTime`),NULL)) VIRTUAL,
  `Notes` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`LogID`),
  KEY `OperatorID` (`OperatorID`),
  KEY `MachineID` (`MachineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plant`
--

DROP TABLE IF EXISTS `plant`;
CREATE TABLE IF NOT EXISTS `plant` (
  `PlantID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(150) NOT NULL,
  `Description` text DEFAULT NULL,
  `CityID` int(11) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `ContactEmail` varchar(100) DEFAULT NULL,
  `ContactPhone` varchar(50) DEFAULT NULL,
  `ManagerName` varchar(100) DEFAULT NULL,
  `Status` enum('Active','Inactive','Construction') DEFAULT 'Active',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PlantID`),
  KEY `CityID` (`CityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `processed_production`
--

DROP TABLE IF EXISTS `processed_production`;
CREATE TABLE IF NOT EXISTS `processed_production` (
  `ProcessedID` int(11) NOT NULL AUTO_INCREMENT,
  `LogID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `AssignedQuantity` int(11) NOT NULL,
  `AssignmentDate` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`ProcessedID`),
  KEY `LogID` (`LogID`),
  KEY `OrderID` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `production_log`
--

DROP TABLE IF EXISTS `production_log`;
CREATE TABLE IF NOT EXISTS `production_log` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT,
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
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`LogID`),
  KEY `MachineID` (`MachineID`),
  KEY `StartOperatorID` (`StartOperatorID`),
  KEY `EndOperatorID` (`EndOperatorID`),
  KEY `idx_prodlog_order` (`ProductionOrderID`),
  KEY `idx_prodlog_date` (`StartTime`),
  KEY `idx_prodlog_status` (`Status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `production_order`
--

DROP TABLE IF EXISTS `production_order`;
CREATE TABLE IF NOT EXISTS `production_order` (
  `OrderID` int(11) NOT NULL AUTO_INCREMENT,
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
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`OrderID`),
  KEY `ArticleID` (`ArticleID`),
  KEY `fk_order_deleted_by` (`DeletedBy`),
  KEY `fk_order_recipe` (`RecipeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `production_recipes`
--

DROP TABLE IF EXISTS `production_recipes`;
CREATE TABLE IF NOT EXISTS `production_recipes` (
  `RecipeID` int(11) NOT NULL AUTO_INCREMENT,
  `ArticleID` int(11) NOT NULL,
  `MachineID` int(11) NOT NULL,
  `Sequence` int(11) NOT NULL DEFAULT 0,
  `OperationDescription` text DEFAULT NULL,
  `EstimatedTime` decimal(5,2) DEFAULT NULL,
  `Version` varchar(50) NOT NULL DEFAULT '1.0',
  `IsActive` tinyint(1) NOT NULL DEFAULT 1,
  `Notes` text DEFAULT NULL,
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`RecipeID`),
  KEY `fk_recipe_machine` (`MachineID`),
  KEY `idx_recipe_lookup` (`ArticleID`,`MachineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `raw_material_log`
--

DROP TABLE IF EXISTS `raw_material_log`;
CREATE TABLE IF NOT EXISTS `raw_material_log` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductionOrderID` int(11) NOT NULL,
  `OperatorID` int(11) NOT NULL,
  `BatchCode` varchar(100) NOT NULL,
  `ArticleID` int(11) DEFAULT NULL,
  `MachineID` int(11) DEFAULT NULL,
  `Quantity` decimal(10,2) DEFAULT 1.00,
  `ScanTime` datetime DEFAULT current_timestamp(),
  `Notes` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`LogID`),
  KEY `OperatorID` (`OperatorID`),
  KEY `ArticleID` (`ArticleID`),
  KEY `MachineID` (`MachineID`),
  KEY `idx_rm_batch` (`BatchCode`),
  KEY `idx_rm_order` (`ProductionOrderID`),
  KEY `idx_rm_date` (`ScanTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recipe_inputs`
--

DROP TABLE IF EXISTS `recipe_inputs`;
CREATE TABLE IF NOT EXISTS `recipe_inputs` (
  `InputID` int(11) NOT NULL AUTO_INCREMENT,
  `RecipeID` int(11) NOT NULL,
  `ArticleID` int(11) NOT NULL,
  `Quantity` decimal(10,4) NOT NULL DEFAULT 1.0000,
  `Unit` varchar(50) NOT NULL DEFAULT 'unit',
  `InputType` enum('part','resource','consumable') NOT NULL DEFAULT 'part',
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`InputID`),
  KEY `fk_recipe_inputs_recipe` (`RecipeID`),
  KEY `fk_recipe_inputs_article` (`ArticleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recipe_outputs`
--

DROP TABLE IF EXISTS `recipe_outputs`;
CREATE TABLE IF NOT EXISTS `recipe_outputs` (
  `OutputID` int(11) NOT NULL AUTO_INCREMENT,
  `RecipeID` int(11) NOT NULL,
  `ArticleID` int(11) NOT NULL,
  `Quantity` decimal(10,4) NOT NULL DEFAULT 1.0000,
  `Unit` varchar(50) NOT NULL DEFAULT 'unit',
  `IsPrimary` tinyint(1) NOT NULL DEFAULT 1,
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`OutputID`),
  KEY `fk_recipe_outputs_recipe` (`RecipeID`),
  KEY `fk_recipe_outputs_article` (`ArticleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reject`
--

DROP TABLE IF EXISTS `reject`;
CREATE TABLE IF NOT EXISTS `reject` (
  `RejectID` int(11) NOT NULL AUTO_INCREMENT,
  `ArticleID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `OperatorID` int(11) NOT NULL,
  `MachineID` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  `ReasonID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Notes` text DEFAULT NULL,
  `RejectDate` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`RejectID`),
  KEY `OrderID` (`OrderID`),
  KEY `CategoryID` (`CategoryID`),
  KEY `ReasonID` (`ReasonID`),
  KEY `rejects_ibfk_1` (`ArticleID`),
  KEY `fk_reject_operator` (`OperatorID`),
  KEY `fk_reject_machine` (`MachineID`),
  KEY `idx_reject_date` (`RejectDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reject_category`
--

DROP TABLE IF EXISTS `reject_category`;
CREATE TABLE IF NOT EXISTS `reject_category` (
  `CategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(255) NOT NULL,
  `PlantID` int(11) DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL,
  PRIMARY KEY (`CategoryID`),
  UNIQUE KEY `CategoryName` (`CategoryName`),
  KEY `fk_rc_section` (`SectionID`),
  KEY `idx_rc_location` (`PlantID`,`SectionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reject_reason`
--

DROP TABLE IF EXISTS `reject_reason`;
CREATE TABLE IF NOT EXISTS `reject_reason` (
  `ReasonID` int(11) NOT NULL AUTO_INCREMENT,
  `ReasonName` varchar(255) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  `PlantID` int(11) DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ReasonID`),
  UNIQUE KEY `ReasonName` (`ReasonName`),
  KEY `CategoryID` (`CategoryID`),
  KEY `fk_rr_section` (`SectionID`),
  KEY `idx_rr_location` (`PlantID`,`SectionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
CREATE TABLE IF NOT EXISTS `section` (
  `SectionID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(150) NOT NULL,
  `PlantID` int(11) NOT NULL,
  `Description` text DEFAULT NULL,
  `FloorAreaSqM` decimal(10,2) DEFAULT 0.00,
  `MaxCapacity` int(11) DEFAULT 0,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`SectionID`),
  KEY `PlantID` (`PlantID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

DROP TABLE IF EXISTS `shifts`;
CREATE TABLE IF NOT EXISTS `shifts` (
  `ShiftID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderID` int(11) NOT NULL,
  `StartDate` datetime NOT NULL,
  `EndDate` datetime DEFAULT NULL,
  `OperatorID` int(11) DEFAULT NULL,
  `ShiftProduction` int(11) DEFAULT 0,
  PRIMARY KEY (`ShiftID`),
  KEY `OrderID` (`OrderID`),
  KEY `OperatorID` (`OperatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `OperatorID` int(11) NOT NULL AUTO_INCREMENT,
  `OperatorUsername` varchar(50) NOT NULL,
  `OperatorPassword` varchar(255) NOT NULL,
  `OperatorRoles` varchar(255) NOT NULL DEFAULT 'operator',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`OperatorID`),
  UNIQUE KEY `OperatorUsername` (`OperatorUsername`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wago`
--

DROP TABLE IF EXISTS `wago`;
CREATE TABLE IF NOT EXISTS `wago` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT,
  `MachineID` int(11) DEFAULT 1,
  `Timestamp` datetime NOT NULL,
  `ProductionCount` int(11) NOT NULL DEFAULT 1,
  `Processed` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`LogID`),
  KEY `idx_timestamp` (`Timestamp`),
  KEY `fk_machine_id` (`MachineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
