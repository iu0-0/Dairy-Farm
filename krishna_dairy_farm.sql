-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 06, 2026 at 02:55 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `krishna_dairy_farm`
--

-- --------------------------------------------------------

--
-- Table structure for table `animals`
--

CREATE TABLE `animals` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `animal_type_id` bigint UNSIGNED NOT NULL,
  `breed_id` bigint UNSIGNED DEFAULT NULL,
  `tag_number` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'female',
  `date_of_birth` date DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_price` decimal(12,2) DEFAULT NULL,
  `color` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weight` decimal(8,2) DEFAULT NULL,
  `status` enum('active','sold','dead','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `animals`
--

INSERT INTO `animals` (`id`, `farm_id`, `animal_type_id`, `breed_id`, `tag_number`, `name`, `gender`, `date_of_birth`, `purchase_date`, `purchase_price`, `color`, `weight`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'KF-001', 'Gauri', 'female', '2023-05-10', '2024-01-15', 75000.00, 'Red', 420.00, 'active', 'Healthy Gir cow', '2026-09-02 06:21:51', '2026-09-02 06:21:51'),
(2, 1, 1, 1, 'JF-001', 'Gauri', 'female', '2023-05-10', '2024-01-15', 75000.00, 'Red', 420.00, 'active', 'Healthy Gir cow', '2026-09-06 07:51:56', '2026-09-06 07:51:56');

-- --------------------------------------------------------

--
-- Table structure for table `animal_health_records`
--

CREATE TABLE `animal_health_records` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `animal_id` bigint UNSIGNED NOT NULL,
  `checkup_date` date NOT NULL,
  `health_status` enum('healthy','sick','critical','recovering') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'healthy',
  `symptoms` text COLLATE utf8mb4_unicode_ci,
  `diagnosis` text COLLATE utf8mb4_unicode_ci,
  `treatment` text COLLATE utf8mb4_unicode_ci,
  `medicine` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `veterinarian_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_checkup_date` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `animal_health_records`
--

INSERT INTO `animal_health_records` (`id`, `farm_id`, `animal_id`, `checkup_date`, `health_status`, `symptoms`, `diagnosis`, `treatment`, `medicine`, `veterinarian_name`, `next_checkup_date`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-09-06', 'healthy', NULL, 'Normal health', NULL, NULL, 'Dr. Patel', '2026-10-06', 'Regular health checkup', '2026-09-06 08:04:26', '2026-09-06 08:04:26');

-- --------------------------------------------------------

--
-- Table structure for table `animal_types`
--

CREATE TABLE `animal_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `animal_types`
--

INSERT INTO `animal_types` (`id`, `name`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Cow', 'Dairy cow', 1, '2026-09-02 06:06:13', '2026-09-02 06:06:13'),
(2, 'Buffalo', 'Dairy buffalo', 1, '2026-09-02 06:06:43', '2026-09-02 06:06:43');

-- --------------------------------------------------------

--
-- Table structure for table `breeding_records`
--

CREATE TABLE `breeding_records` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `female_animal_id` bigint UNSIGNED NOT NULL,
  `male_animal_id` bigint UNSIGNED DEFAULT NULL,
  `breeding_date` date NOT NULL,
  `breeding_method` enum('natural','artificial_insemination') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'natural',
  `technician_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `semen_code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expected_heat_date` date DEFAULT NULL,
  `pregnancy_check_date` date DEFAULT NULL,
  `result` enum('pending','successful','unsuccessful') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `breeding_records`
--

INSERT INTO `breeding_records` (`id`, `farm_id`, `female_animal_id`, `male_animal_id`, `breeding_date`, `breeding_method`, `technician_name`, `semen_code`, `expected_heat_date`, `pregnancy_check_date`, `result`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, '2026-08-01', 'artificial_insemination', 'Dr. Patel', 'GIR-2026-001', '2026-08-21', '2026-08-25', 'successful', 'Artificial insemination completed', '2026-09-06 08:17:23', '2026-09-06 08:17:23');

-- --------------------------------------------------------

--
-- Table structure for table `breeds`
--

CREATE TABLE `breeds` (
  `id` bigint UNSIGNED NOT NULL,
  `animal_type_id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `breeds`
--

INSERT INTO `breeds` (`id`, `animal_type_id`, `name`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Gir', 'Indian Gir cattle breed', 1, '2026-09-02 06:15:25', '2026-09-02 06:15:25'),
(2, 1, 'Jersey', 'Jersey dairy cattle breed', 1, '2026-09-02 06:16:11', '2026-09-02 06:16:11'),
(3, 2, 'Murrah', 'Murrah buffalo breed', 1, '2026-09-02 06:16:33', '2026-09-02 06:16:33');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `animal_id` bigint UNSIGNED DEFAULT NULL,
  `expense_category` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `expense_date` date NOT NULL,
  `payment_method` enum('cash','upi','bank','card','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `supplier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `receipt_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `farm_id`, `animal_id`, `expense_category`, `title`, `amount`, `expense_date`, `payment_method`, `supplier`, `description`, `receipt_number`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'Feed', 'Wheat Straw Purchase', 8000.00, '2026-09-06', 'upi', 'ABC Fodder Supplier', '1000 kg wheat straw', 'EXP-001', '2026-09-06 08:36:30', '2026-09-06 08:36:30'),
(2, 1, 1, 'Medicine', 'Animal Medicine', 750.00, '2026-09-06', 'cash', 'Local Veterinary Store', 'Medicine for animal', 'MED-001', '2026-09-06 08:36:41', '2026-09-06 08:36:41');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `farms`
--

CREATE TABLE `farms` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pincode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `farms`
--

INSERT INTO `farms` (`id`, `user_id`, `name`, `owner_name`, `phone`, `email`, `address`, `city`, `state`, `pincode`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Krishna Dairy Farm', 'Karan', '9876543210', 'farm@example.com', 'Ahmedabad', 'Ahmedabad', 'Gujarat', '380001', 'Krishna Dairy Farm', 1, '2026-09-02 05:55:31', '2026-09-02 05:55:31');

-- --------------------------------------------------------

--
-- Table structure for table `feeds`
--

CREATE TABLE `feeds` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `animal_id` bigint UNSIGNED DEFAULT NULL,
  `feed_category_id` bigint UNSIGNED NOT NULL,
  `feed_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit` enum('kg','gram','litre','bag','packet','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'kg',
  `unit_price` decimal(10,2) DEFAULT NULL,
  `total_cost` decimal(12,2) DEFAULT NULL,
  `supplier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feeding_date` date NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feeds`
--

INSERT INTO `feeds` (`id`, `farm_id`, `animal_id`, `feed_category_id`, `feed_name`, `quantity`, `unit`, `unit_price`, `total_cost`, `supplier`, `feeding_date`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'Green Grass', 5.00, 'kg', 4.00, 20.00, 'Local Supplier', '2026-09-06', 'Morning feeding', '2026-09-06 08:30:37', '2026-09-06 08:30:37'),
(2, 1, NULL, 2, 'Wheat Straw', 100.00, 'kg', 8.00, 800.00, 'ABC Fodder Supplier', '2026-09-06', 'Farm stock', '2026-09-06 08:31:06', '2026-09-06 08:31:06');

-- --------------------------------------------------------

--
-- Table structure for table `feed_categories`
--

CREATE TABLE `feed_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feed_categories`
--

INSERT INTO `feed_categories` (`id`, `name`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Green Fodder', 'Fresh green fodder for cattle', 1, '2026-09-06 08:21:45', '2026-09-06 08:21:45'),
(2, 'Dry Fodder', 'Dry fodder such as hay and straw', 1, '2026-09-06 08:21:56', '2026-09-06 08:21:56'),
(3, 'Concentrate Feed', 'High-energy and protein-rich cattle feed', 1, '2026-09-06 08:22:03', '2026-09-06 08:22:03');

-- --------------------------------------------------------

--
-- Table structure for table `income`
--

CREATE TABLE `income` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `animal_id` bigint UNSIGNED DEFAULT NULL,
  `income_category` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `income_date` date NOT NULL,
  `payment_method` enum('cash','upi','bank','card','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `receipt_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `income`
--

INSERT INTO `income` (`id`, `farm_id`, `animal_id`, `income_category`, `title`, `amount`, `income_date`, `payment_method`, `customer_name`, `description`, `receipt_number`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Milk Sale', 'Morning Milk Sale', 1500.00, '2026-09-06', 'upi', 'Rahul Dairy Shop', 'Morning milk supply', 'INC-001', '2026-09-06 08:40:13', '2026-09-06 08:40:13');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `category` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` decimal(10,2) NOT NULL DEFAULT '0.00',
  `unit` enum('kg','gram','litre','bag','packet','piece','unit','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'kg',
  `minimum_stock` decimal(10,2) NOT NULL DEFAULT '0.00',
  `unit_price` decimal(10,2) DEFAULT NULL,
  `supplier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`id`, `farm_id`, `category`, `item_name`, `quantity`, `unit`, `minimum_stock`, `unit_price`, `supplier`, `purchase_date`, `expiry_date`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Feed', 'Wheat Straw', 1400.00, 'kg', 200.00, 8.00, 'ABC Fodder Supplier', '2026-09-06', NULL, 'Wheat straw stock', 1, '2026-09-06 08:44:33', '2026-09-06 08:49:58'),
(2, 1, 'Medicine', 'Animal Antibiotic', 20.00, 'packet', 5.00, 250.00, 'Veterinary Medical Store', '2026-09-06', '2027-09-06', 'General veterinary medicine', 1, '2026-09-06 08:45:02', '2026-09-06 08:45:02');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_transactions`
--

CREATE TABLE `inventory_transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `inventory_id` bigint UNSIGNED NOT NULL,
  `transaction_type` enum('in','out','adjustment') COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit` enum('kg','gram','litre','bag','packet','piece','unit','other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_date` date NOT NULL,
  `reference_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` bigint UNSIGNED DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory_transactions`
--

INSERT INTO `inventory_transactions` (`id`, `farm_id`, `inventory_id`, `transaction_type`, `quantity`, `unit`, `transaction_date`, `reference_type`, `reference_id`, `reason`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'in', 500.00, 'kg', '2026-09-06', 'purchase', 1, 'New feed purchase', '500 kg wheat straw purchased', '2026-09-06 08:49:49', '2026-09-06 08:49:49'),
(2, 1, 1, 'out', 100.00, 'kg', '2026-09-06', 'feed_usage', 1, 'Daily cattle feeding', '100 kg used', '2026-09-06 08:49:58', '2026-09-06 08:49:58');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `laborers`
--

CREATE TABLE `laborers` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'male',
  `joining_date` date DEFAULT NULL,
  `employment_type` enum('full_time','part_time','temporary') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'full_time',
  `daily_wage` decimal(10,2) DEFAULT NULL,
  `monthly_salary` decimal(12,2) DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `laborers`
--

INSERT INTO `laborers` (`id`, `farm_id`, `name`, `phone`, `email`, `gender`, `joining_date`, `employment_type`, `daily_wage`, `monthly_salary`, `address`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'Ramesh Patel', '9876543210', 'ramesh@example.com', 'male', '2026-09-01', 'full_time', 500.00, 15000.00, 'Ahmedabad', 'active', 'Responsible for cattle feeding and cleaning.', '2026-09-06 09:05:56', '2026-09-06 09:05:56');

-- --------------------------------------------------------

--
-- Table structure for table `labor_advances`
--

CREATE TABLE `labor_advances` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `laborer_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `advance_date` date NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` enum('cash','upi','bank','card','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `reference_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `labor_advances`
--

INSERT INTO `labor_advances` (`id`, `farm_id`, `laborer_id`, `amount`, `advance_date`, `reason`, `payment_method`, `reference_number`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 3000.00, '2026-09-06', 'Family requirement', 'upi', 'UPI-ADV-001', 'Advance given to laborer', '2026-09-06 09:19:58', '2026-09-06 09:19:58');

-- --------------------------------------------------------

--
-- Table structure for table `labor_attendances`
--

CREATE TABLE `labor_attendances` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `laborer_id` bigint UNSIGNED NOT NULL,
  `attendance_date` date NOT NULL,
  `status` enum('present','absent','half_day','leave') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'present',
  `hours_worked` decimal(5,2) DEFAULT NULL,
  `wage_amount` decimal(10,2) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `labor_attendances`
--

INSERT INTO `labor_attendances` (`id`, `farm_id`, `laborer_id`, `attendance_date`, `status`, `hours_worked`, `wage_amount`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-09-06', 'present', 8.00, 500.00, NULL, '2026-09-06 09:12:58', '2026-09-06 09:12:58');

-- --------------------------------------------------------

--
-- Table structure for table `labor_salaries`
--

CREATE TABLE `labor_salaries` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `laborer_id` bigint UNSIGNED NOT NULL,
  `salary_month` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `basic_salary` decimal(12,2) NOT NULL DEFAULT '0.00',
  `attendance_days` decimal(6,2) NOT NULL DEFAULT '0.00',
  `overtime_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `bonus` decimal(10,2) NOT NULL DEFAULT '0.00',
  `deduction` decimal(10,2) NOT NULL DEFAULT '0.00',
  `advance_deduction` decimal(10,2) NOT NULL DEFAULT '0.00',
  `net_salary` decimal(12,2) NOT NULL DEFAULT '0.00',
  `payment_date` date DEFAULT NULL,
  `payment_status` enum('pending','partial','paid') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_method` enum('cash','upi','bank','card','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `reference_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `labor_salaries`
--

INSERT INTO `labor_salaries` (`id`, `farm_id`, `laborer_id`, `salary_month`, `basic_salary`, `attendance_days`, `overtime_amount`, `bonus`, `deduction`, `advance_deduction`, `net_salary`, `payment_date`, `payment_status`, `payment_method`, `reference_number`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-09', 15000.00, 26.00, 1000.00, 500.00, 200.00, 1000.00, 15300.00, '2026-09-30', 'paid', 'upi', 'UPI-SEP-001', 'September salary', '2026-09-06 09:15:48', '2026-09-06 09:15:48');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '0001_01_01_000000_create_users_table', 1),
(5, '0001_01_01_000001_create_cache_table', 1),
(6, '0001_01_01_000002_create_jobs_table', 1),
(7, '2026_09_02_064144_create_personal_access_tokens_table', 2),
(8, '2026_09_02_110330_create_farms_table', 2),
(9, '2026_09_06_142440_create_notifications_table', 3),
(10, '2026_09_06_143317_create_laborers_table', 4),
(11, '2026_09_06_143622_create_labor_attendances_table', 5),
(12, '2026_09_06_144330_create_labor_salaries_table', 6),
(13, '2026_09_06_144705_create_labor_advances_table', 7);

-- --------------------------------------------------------

--
-- Table structure for table `milk_records`
--

CREATE TABLE `milk_records` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `animal_id` bigint UNSIGNED NOT NULL,
  `record_date` date NOT NULL,
  `morning_quantity` decimal(8,2) NOT NULL DEFAULT '0.00',
  `evening_quantity` decimal(8,2) NOT NULL DEFAULT '0.00',
  `total_quantity` decimal(8,2) NOT NULL DEFAULT '0.00',
  `fat_percentage` decimal(5,2) DEFAULT NULL,
  `snf_percentage` decimal(5,2) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `milk_records`
--

INSERT INTO `milk_records` (`id`, `farm_id`, `animal_id`, `record_date`, `morning_quantity`, `evening_quantity`, `total_quantity`, `fat_percentage`, `snf_percentage`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-09-06', 8.50, 7.50, 16.00, 4.20, 8.50, 'Good milk production', '2026-09-06 07:59:16', '2026-09-06 07:59:16');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('info','warning','success','danger') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'info',
  `reference_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` bigint UNSIGNED DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'dairy-farm-app', 'af0f9ff5d79314a5bec50058732234479bc2319fb6eb5373de43adc345d08a51', '[\"*\"]', NULL, NULL, '2026-09-02 04:03:21', '2026-09-02 04:03:21'),
(2, 'App\\Models\\User', 1, 'dairy-farm-app', 'c3ad210b86d52b9a7d27555e540f45672e2666769637fbf4e348c55189d9cc84', '[\"*\"]', '2026-09-06 09:23:57', NULL, '2026-09-02 04:04:56', '2026-09-06 09:23:57');

-- --------------------------------------------------------

--
-- Table structure for table `pregnancies`
--

CREATE TABLE `pregnancies` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `animal_id` bigint UNSIGNED NOT NULL,
  `breeding_date` date NOT NULL,
  `pregnancy_confirmed_date` date DEFAULT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `actual_delivery_date` date DEFAULT NULL,
  `status` enum('pending','confirmed','delivered','failed','aborted') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `offspring_count` int UNSIGNED DEFAULT '0',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pregnancies`
--

INSERT INTO `pregnancies` (`id`, `farm_id`, `animal_id`, `breeding_date`, `pregnancy_confirmed_date`, `expected_delivery_date`, `actual_delivery_date`, `status`, `offspring_count`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-08-01', '2026-08-25', '2027-05-10', NULL, 'confirmed', 0, 'Pregnancy confirmed by veterinarian', '2026-09-06 08:12:36', '2026-09-06 08:12:36');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('jHLC8U74Tu63Yfiq3x3UCbhiodeOHOFP72NJ0Sni', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJNNVFCQ0RNSlJGNjJkVEkwalNSd3hQdTZEa25saHRYSnBYS2J0S3RUIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1788341528),
('r1T6wVdVO1dS7wQC2DbOZhrNNdHU5fbKPKyAlolZ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI2S2J1eUZuekxNcEZuZkVmVFhHNlc0blhzMFpXMjFBSDNLekNsZnJoIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1788700760),
('RFyA7XHOpDKl7jQ6Iyto6Mhiz6tSSr29zNhljSDU', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJ0V2VlVW1lWmptakhDSjVpbU41bTBpYzNDRHhGWEdEcnIzOFhmNjJRIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1788348002);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Karan', 'karan@gmail.com', NULL, '$2y$12$XQ/9A13zfWKde.BB94ZmMOj.XzUqA0A5InROBuSNbIQErGuE0EeyO', NULL, '2026-09-02 04:03:21', '2026-09-02 04:03:21');

-- --------------------------------------------------------

--
-- Table structure for table `vaccinations`
--

CREATE TABLE `vaccinations` (
  `id` bigint UNSIGNED NOT NULL,
  `farm_id` bigint UNSIGNED NOT NULL,
  `animal_id` bigint UNSIGNED NOT NULL,
  `vaccine_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vaccination_date` date NOT NULL,
  `next_due_date` date DEFAULT NULL,
  `dose` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `veterinarian_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vaccinations`
--

INSERT INTO `vaccinations` (`id`, `farm_id`, `animal_id`, `vaccine_name`, `vaccination_date`, `next_due_date`, `dose`, `batch_number`, `veterinarian_name`, `cost`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'FMD Vaccine', '2026-09-06', '2027-03-06', '2 ml', 'FMD-2026-001', 'Dr. Patel', 250.00, 'Vaccination completed successfully', '2026-09-06 08:08:55', '2026-09-06 08:08:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `animals`
--
ALTER TABLE `animals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `animals_tag_number_unique` (`tag_number`),
  ADD KEY `animals_farm_id_index` (`farm_id`),
  ADD KEY `animals_animal_type_id_index` (`animal_type_id`),
  ADD KEY `animals_breed_id_index` (`breed_id`);

--
-- Indexes for table `animal_health_records`
--
ALTER TABLE `animal_health_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `health_farm_id_index` (`farm_id`),
  ADD KEY `health_animal_id_index` (`animal_id`);

--
-- Indexes for table `animal_types`
--
ALTER TABLE `animal_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `animal_types_name_unique` (`name`);

--
-- Indexes for table `breeding_records`
--
ALTER TABLE `breeding_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `breeding_farm_id_index` (`farm_id`),
  ADD KEY `breeding_female_animal_id_index` (`female_animal_id`),
  ADD KEY `breeding_male_animal_id_index` (`male_animal_id`);

--
-- Indexes for table `breeds`
--
ALTER TABLE `breeds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `breeds_animal_type_name_unique` (`animal_type_id`,`name`),
  ADD KEY `breeds_animal_type_id_index` (`animal_type_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expenses_farm_id_index` (`farm_id`),
  ADD KEY `expenses_animal_id_index` (`animal_id`),
  ADD KEY `expenses_category_index` (`expense_category`),
  ADD KEY `expenses_date_index` (`expense_date`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  ADD KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`);

--
-- Indexes for table `farms`
--
ALTER TABLE `farms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `farms_user_id_index` (`user_id`);

--
-- Indexes for table `feeds`
--
ALTER TABLE `feeds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feeds_farm_id_index` (`farm_id`),
  ADD KEY `feeds_animal_id_index` (`animal_id`),
  ADD KEY `feeds_feed_category_id_index` (`feed_category_id`),
  ADD KEY `feeds_feeding_date_index` (`feeding_date`);

--
-- Indexes for table `feed_categories`
--
ALTER TABLE `feed_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `feed_categories_name_unique` (`name`);

--
-- Indexes for table `income`
--
ALTER TABLE `income`
  ADD PRIMARY KEY (`id`),
  ADD KEY `income_farm_id_index` (`farm_id`),
  ADD KEY `income_animal_id_index` (`animal_id`),
  ADD KEY `income_category_index` (`income_category`),
  ADD KEY `income_date_index` (`income_date`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_farm_id_index` (`farm_id`),
  ADD KEY `inventory_category_index` (`category`),
  ADD KEY `inventory_item_name_index` (`item_name`);

--
-- Indexes for table `inventory_transactions`
--
ALTER TABLE `inventory_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_transactions_farm_id_index` (`farm_id`),
  ADD KEY `inventory_transactions_inventory_id_index` (`inventory_id`),
  ADD KEY `inventory_transactions_type_index` (`transaction_type`),
  ADD KEY `inventory_transactions_date_index` (`transaction_date`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `laborers`
--
ALTER TABLE `laborers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `laborers_farm_id_index` (`farm_id`),
  ADD KEY `laborers_status_index` (`status`);

--
-- Indexes for table `labor_advances`
--
ALTER TABLE `labor_advances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `labor_advances_farm_id_index` (`farm_id`),
  ADD KEY `labor_advances_laborer_id_index` (`laborer_id`),
  ADD KEY `labor_advances_advance_date_index` (`advance_date`);

--
-- Indexes for table `labor_attendances`
--
ALTER TABLE `labor_attendances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `labor_attendance_unique` (`laborer_id`,`attendance_date`),
  ADD KEY `labor_attendances_farm_id_index` (`farm_id`),
  ADD KEY `labor_attendances_attendance_date_index` (`attendance_date`),
  ADD KEY `labor_attendances_status_index` (`status`);

--
-- Indexes for table `labor_salaries`
--
ALTER TABLE `labor_salaries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `labor_salary_unique` (`laborer_id`,`salary_month`),
  ADD KEY `labor_salaries_farm_id_index` (`farm_id`),
  ADD KEY `labor_salaries_salary_month_index` (`salary_month`),
  ADD KEY `labor_salaries_payment_status_index` (`payment_status`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `milk_records`
--
ALTER TABLE `milk_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `milk_records_farm_id_index` (`farm_id`),
  ADD KEY `milk_records_animal_id_index` (`animal_id`),
  ADD KEY `milk_records_record_date_index` (`record_date`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_index` (`user_id`),
  ADD KEY `notifications_farm_id_index` (`farm_id`),
  ADD KEY `notifications_is_read_index` (`is_read`),
  ADD KEY `notifications_type_index` (`type`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `pregnancies`
--
ALTER TABLE `pregnancies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pregnancies_farm_id_index` (`farm_id`),
  ADD KEY `pregnancies_animal_id_index` (`animal_id`),
  ADD KEY `pregnancies_status_index` (`status`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `vaccinations`
--
ALTER TABLE `vaccinations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vaccinations_farm_id_index` (`farm_id`),
  ADD KEY `vaccinations_animal_id_index` (`animal_id`),
  ADD KEY `vaccinations_next_due_date_index` (`next_due_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `animals`
--
ALTER TABLE `animals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `animal_health_records`
--
ALTER TABLE `animal_health_records`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `animal_types`
--
ALTER TABLE `animal_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `breeding_records`
--
ALTER TABLE `breeding_records`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `breeds`
--
ALTER TABLE `breeds`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `farms`
--
ALTER TABLE `farms`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `feeds`
--
ALTER TABLE `feeds`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `feed_categories`
--
ALTER TABLE `feed_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `income`
--
ALTER TABLE `income`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inventory_transactions`
--
ALTER TABLE `inventory_transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `laborers`
--
ALTER TABLE `laborers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `labor_advances`
--
ALTER TABLE `labor_advances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `labor_attendances`
--
ALTER TABLE `labor_attendances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `labor_salaries`
--
ALTER TABLE `labor_salaries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `milk_records`
--
ALTER TABLE `milk_records`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pregnancies`
--
ALTER TABLE `pregnancies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `vaccinations`
--
ALTER TABLE `vaccinations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `animals`
--
ALTER TABLE `animals`
  ADD CONSTRAINT `animals_animal_type_id_foreign` FOREIGN KEY (`animal_type_id`) REFERENCES `animal_types` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `animals_breed_id_foreign` FOREIGN KEY (`breed_id`) REFERENCES `breeds` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `animals_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `animal_health_records`
--
ALTER TABLE `animal_health_records`
  ADD CONSTRAINT `health_animal_id_foreign` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `health_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `breeding_records`
--
ALTER TABLE `breeding_records`
  ADD CONSTRAINT `breeding_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `breeding_female_animal_id_foreign` FOREIGN KEY (`female_animal_id`) REFERENCES `animals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `breeding_male_animal_id_foreign` FOREIGN KEY (`male_animal_id`) REFERENCES `animals` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `breeds`
--
ALTER TABLE `breeds`
  ADD CONSTRAINT `breeds_animal_type_id_foreign` FOREIGN KEY (`animal_type_id`) REFERENCES `animal_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_animal_id_foreign` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `farms`
--
ALTER TABLE `farms`
  ADD CONSTRAINT `farms_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `feeds`
--
ALTER TABLE `feeds`
  ADD CONSTRAINT `feeds_animal_id_foreign` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `feeds_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `feeds_feed_category_id_foreign` FOREIGN KEY (`feed_category_id`) REFERENCES `feed_categories` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `income`
--
ALTER TABLE `income`
  ADD CONSTRAINT `income_animal_id_foreign` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `income_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inventory_transactions`
--
ALTER TABLE `inventory_transactions`
  ADD CONSTRAINT `inventory_transactions_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inventory_transactions_inventory_id_foreign` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `laborers`
--
ALTER TABLE `laborers`
  ADD CONSTRAINT `laborers_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `labor_advances`
--
ALTER TABLE `labor_advances`
  ADD CONSTRAINT `labor_advances_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `labor_advances_laborer_id_foreign` FOREIGN KEY (`laborer_id`) REFERENCES `laborers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `labor_attendances`
--
ALTER TABLE `labor_attendances`
  ADD CONSTRAINT `labor_attendances_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `labor_attendances_laborer_id_foreign` FOREIGN KEY (`laborer_id`) REFERENCES `laborers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `labor_salaries`
--
ALTER TABLE `labor_salaries`
  ADD CONSTRAINT `labor_salaries_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `labor_salaries_laborer_id_foreign` FOREIGN KEY (`laborer_id`) REFERENCES `laborers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `milk_records`
--
ALTER TABLE `milk_records`
  ADD CONSTRAINT `milk_records_animal_id_foreign` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `milk_records_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pregnancies`
--
ALTER TABLE `pregnancies`
  ADD CONSTRAINT `pregnancies_animal_id_foreign` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregnancies_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vaccinations`
--
ALTER TABLE `vaccinations`
  ADD CONSTRAINT `vaccinations_animal_id_foreign` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `vaccinations_farm_id_foreign` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
