-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2026 at 02:41 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `machine_stop_category`
--

DROP TABLE IF EXISTS `machine_stop_category`;
CREATE TABLE `machine_stop_category` (
  `CategoryID` int(11) NOT NULL,
  `CategoryName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  MODIFY `AdjustmentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `api_audit_log`
--
ALTER TABLE `api_audit_log`
  MODIFY `AuditID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `api_keys`
--
ALTER TABLE `api_keys`
  MODIFY `KeyID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `ArticleID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `batch_log`
--
ALTER TABLE `batch_log`
  MODIFY `BatchID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `CityID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `CountryID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `machine`
--
ALTER TABLE `machine`
  MODIFY `MachineID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `machine_planning`
--
ALTER TABLE `machine_planning`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `machine_stop_category`
--
ALTER TABLE `machine_stop_category`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `machine_stop_log`
--
ALTER TABLE `machine_stop_log`
  MODIFY `StopID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `machine_stop_reason`
--
ALTER TABLE `machine_stop_reason`
  MODIFY `ReasonID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `operator_log`
--
ALTER TABLE `operator_log`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plant`
--
ALTER TABLE `plant`
  MODIFY `PlantID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `processed_production`
--
ALTER TABLE `processed_production`
  MODIFY `ProcessedID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `production_log`
--
ALTER TABLE `production_log`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `production_order`
--
ALTER TABLE `production_order`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `production_order_progress`
--
ALTER TABLE `production_order_progress`
  MODIFY `ProgressID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `production_recipes`
--
ALTER TABLE `production_recipes`
  MODIFY `RecipeID` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `RejectID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reject_category`
--
ALTER TABLE `reject_category`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reject_reason`
--
ALTER TABLE `reject_reason`
  MODIFY `ReasonID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `section`
--
ALTER TABLE `section`
  MODIFY `SectionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shifts`
--
ALTER TABLE `shifts`
  MODIFY `ShiftID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `OperatorID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wago`
--
ALTER TABLE `wago`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT;

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
