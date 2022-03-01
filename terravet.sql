-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 01, 2022 at 05:10 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `terravet`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `appointment_id` int(11) NOT NULL,
  `vetid` varchar(100) NOT NULL,
  `pet_owner_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `time_scheduled` varchar(50) NOT NULL,
  `date_scheduled` date NOT NULL,
  `service_id` int(11) NOT NULL,
  `appointment_status` varchar(20) NOT NULL,
  `logs` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_accomplished` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appointment_id`, `vetid`, `pet_owner_id`, `pet_id`, `time_scheduled`, `date_scheduled`, `service_id`, `appointment_status`, `logs`, `date_accomplished`) VALUES
(126, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 24, '03:00 PM - 04:00 PM', '2021-11-03', 29, 'Done', '2021-10-29 17:26:08', '2021-10-30 01:26:08'),
(127, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 23, '10:00 AM - 11:00 AM', '2021-11-01', 21, 'Pending', '2022-02-27 14:37:38', '2021-10-30 01:34:31'),
(128, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 24, '08:00 AM - 09:00 AM', '2021-11-04', 31, 'Done', '2021-11-03 04:50:51', '2021-11-03 12:50:51'),
(129, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 24, '08:00 AM - 09:00 AM', '2021-11-08', 2, 'Done', '2021-11-03 09:15:55', '2021-11-03 17:15:55'),
(130, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 18, '10:00 AM - 11:00 AM', '2021-11-12', 4, 'Approved', '2021-11-03 14:18:14', '2021-11-03 22:18:14'),
(131, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '10:00 AM - 11:00 AM', '2021-11-09', 31, 'Done', '2021-11-04 07:10:57', '2021-11-04 15:10:57'),
(132, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 19, '08:00 AM - 09:00 AM', '2021-11-08', 20, 'Done', '2021-11-08 08:45:34', '2021-11-08 16:45:34'),
(133, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 22, '11:00 AM - 12:00 PM', '2021-11-08', 21, 'Done', '2022-02-27 14:28:08', '2021-11-10 07:07:55'),
(134, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 24, '09:00 AM - 10:00 AM', '2021-11-15', 3, 'Pending', '2021-11-06 14:44:54', '0000-00-00 00:00:00'),
(135, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 23, '08:00 AM - 09:00 AM', '2021-11-08', 18, 'Expired', '2021-11-09 23:07:55', '2021-11-10 07:07:55');

-- --------------------------------------------------------

--
-- Table structure for table `consultation`
--

CREATE TABLE `consultation` (
  `consultation_id` int(11) NOT NULL,
  `consultation_type` varchar(100) NOT NULL,
  `vetid` varchar(100) NOT NULL,
  `vet_doc_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `prescription` int(11) DEFAULT NULL,
  `findings` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `email_verification`
--

CREATE TABLE `email_verification` (
  `email_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `verification_code` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `email_verification`
--

INSERT INTO `email_verification` (`email_id`, `email`, `verification_code`, `date_created`) VALUES
(2, 'johnllaneta05@gmail.com', 9654, '2021-12-14 22:10:58'),
(3, 'johnllaneta05@gmail.com', 6223, '2021-12-14 22:23:17'),
(4, 'johnllaneta05@gmail.com', 8637, '2021-12-14 22:45:36'),
(5, 'johnllaneta05@gmail.com', 4513, '2021-12-14 22:46:00'),
(6, 'johnllaneta05@gmail.com', 4867, '2021-12-14 22:46:56'),
(7, 'johnllaneta05@gmail.com', 3463, '2021-12-14 22:50:22'),
(8, 'johnllaneta05@gmail.com', 4518, '2021-12-14 22:50:59'),
(9, 'johnllaneta05@gmail.com', 1721, '2021-12-14 22:59:45'),
(10, 'johnllaneta05@gmail.com', 4901, '2021-12-14 23:00:01'),
(11, 'johnllaneta05@gmail.com', 8735, '2021-12-15 12:07:08'),
(12, 'johnllaneta05@gmail.com', 3020, '2021-12-15 12:14:43'),
(13, 'johnllaneta05@gmail.com', 6886, '2021-12-17 21:13:07'),
(14, 'johnllaneta05@gmail.com', 6931, '2021-12-17 21:22:19'),
(15, 'johnllaneta05@gmail.com', 1130, '2021-12-17 21:25:40'),
(16, 'johnllaneta05@gmail.com', 5853, '2021-12-17 21:25:40'),
(17, 'johnllaneta05@gmail.com', 4027, '2021-12-17 22:11:23'),
(18, 'johnllaneta05@gmail.com', 4273, '2021-12-17 22:14:09'),
(19, 'johnllaneta05@gmail.com', 3382, '2021-12-17 22:15:32'),
(20, 'johnllaneta05@gmail.com', 6678, '2021-12-17 22:16:55'),
(21, 'johnllaneta05@gmail.com', 4731, '2021-12-17 22:33:41'),
(22, 'johnllaneta05@gmail.com', 7178, '2021-12-17 22:33:41'),
(23, 'johnllaneta05@gmail.com', 4338, '2021-12-17 22:36:49'),
(24, 'johnllaneta05@gmail.com', 4614, '2021-12-18 17:32:21'),
(25, 'johnllaneta05@gmail.com', 8736, '2021-12-18 17:32:59'),
(26, 'johnllaneta05@gmail.com', 8134, '2021-12-18 17:37:55'),
(27, 'johnllaneta05@gmail.com', 1312, '2021-12-18 17:42:31'),
(28, 'johnllaneta05@gmail.com', 5524, '2021-12-18 17:47:07'),
(29, 'johnllaneta05@gmail.com', 9191, '2021-12-18 22:31:25'),
(30, 'johnllaneta05@gmail.com', 9320, '2021-12-18 23:05:04'),
(31, 'johnllaneta05@gmail.com', 5023, '2021-12-19 02:25:37'),
(32, 'johnllaneta05@gmail.com', 2405, '2021-12-19 02:38:48'),
(33, 'johnllaneta05@gmail.com', 3794, '2021-12-19 02:42:57'),
(34, 'johnllaneta05@gmail.com', 4160, '2021-12-19 02:47:03'),
(35, 'johnllaneta05@gmail.com', 6959, '2021-12-19 02:56:50'),
(36, 'johnllaneta05@gmail.com', 3723, '2021-12-19 23:52:46'),
(37, 'johnllaneta05@gmail.com', 7094, '2021-12-19 23:57:25'),
(38, 'johnllaneta05@gmail.com', 5042, '2021-12-23 22:56:44');

-- --------------------------------------------------------

--
-- Table structure for table `forget_password`
--

CREATE TABLE `forget_password` (
  `verify_id` int(11) NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  `verification_code` varchar(4) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `forget_password`
--

INSERT INTO `forget_password` (`verify_id`, `phone_number`, `verification_code`, `date_created`) VALUES
(1, '09558264299', '5506', '2021-10-14 17:28:02'),
(2, '09558264299', '8790', '2021-10-14 17:51:26'),
(3, '09558264299', '1021', '2021-10-14 18:40:42'),
(4, '09354555893', '7490', '2021-10-14 18:45:33'),
(5, '09558264299', '7588', '2021-10-14 19:00:15'),
(6, '09558264299', '1106', '2021-10-15 00:14:31'),
(7, '09354555893', '7088', '2021-10-15 06:32:59'),
(8, '09354555893', '4361', '2021-10-15 11:36:13'),
(9, '09354555893', '6567', '2021-10-15 12:49:57'),
(10, '09354555893', '8243', '2021-10-15 19:25:01'),
(11, '09354555893', '6189', '2021-10-15 20:32:58'),
(12, '09558264299', '3573', '2021-10-16 05:30:25'),
(13, '09558264299', '2108', '2021-10-16 05:35:48'),
(14, '09558264299', '8606', '2021-10-16 05:36:02'),
(15, '09558264299', '2333', '2021-10-16 05:36:36'),
(16, '09558264299', '3625', '2021-10-16 07:36:27'),
(17, '09072069351', '4344', '2021-10-20 19:02:58'),
(18, '09354555893', '9132', '2021-10-22 17:37:01'),
(19, '09354555893', '5968', '2021-10-22 17:45:51'),
(20, '09354555893', '3450', '2021-10-22 17:48:13'),
(21, '09354555893', '3469', '2021-10-22 17:50:42'),
(22, '09354555893', '3670', '2021-10-22 17:58:04'),
(23, '09354555893', '4395', '2021-10-22 19:19:34'),
(24, '09354555893', '4648', '2021-10-22 19:20:57'),
(25, '09354555893', '3937', '2021-10-22 19:22:23'),
(26, '09763723846', '9138', '2021-10-22 19:30:28'),
(27, '09073654951', '3990', '2021-10-22 19:52:51'),
(28, '09073654951', '7835', '2021-10-22 19:55:48'),
(29, '09073654951', '1097', '2021-10-22 20:00:54'),
(30, '09739399234', '5603', '2021-10-22 20:03:29'),
(31, '09073654951', '3761', '2021-10-22 20:06:09'),
(32, '09354555893', '2189', '2021-10-22 20:07:38'),
(33, '09073654951', '3772', '2021-10-22 20:10:05'),
(34, '09739399234', '9132', '2021-10-22 20:11:00'),
(35, '09739399234', '7990', '2021-10-22 20:13:52'),
(36, '09739399234', '8682', '2021-10-22 20:17:16'),
(37, '09739399234', '6593', '2021-10-22 20:21:04'),
(38, '09739399234', '7813', '2021-10-22 20:23:50'),
(39, '09354555893', '2361', '2022-01-23 16:32:20'),
(40, '09354555588', '6194', '2022-01-23 16:36:19'),
(41, '09354555588', '2951', '2022-01-23 16:37:54'),
(42, '09784548784', '9221', '2022-01-23 16:41:28');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `history_id` int(11) NOT NULL,
  `type_of_transaction` varchar(50) NOT NULL,
  `pet_owner_id` int(11) NOT NULL,
  `vet_admin_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `date_and_time` datetime NOT NULL,
  `remarks` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `immunization_history`
--

CREATE TABLE `immunization_history` (
  `immunization_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `pet_weight` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `vaccine_name` varchar(300) NOT NULL,
  `againts` varchar(50) NOT NULL,
  `vaccine_number` varchar(20) NOT NULL,
  `manufacturer` varchar(50) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `prescription` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `immunization_history`
--

INSERT INTO `immunization_history` (`immunization_id`, `pet_id`, `pet_weight`, `date`, `vaccine_name`, `againts`, `vaccine_number`, `manufacturer`, `appointment_id`, `prescription`) VALUES
(11, 24, 50, '2021-11-03 04:50:51', 'Sinovac', 'Anti Rabies', '12574987', 'China', 128, ''),
(12, 23, 25, '2021-11-04 07:10:57', 'Sinovac', 'Anti Rabies', '1204689', 'Johnson & Johnson', 131, ''),
(13, 19, 10, '2021-11-08 08:45:34', 'sinovac', 'anti rabies', '1245478', 'china', 132, '');

-- --------------------------------------------------------

--
-- Table structure for table `medical_history`
--

CREATE TABLE `medical_history` (
  `medical_history_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `vet_admin_id` int(11) NOT NULL,
  `vet_doc_id` int(11) NOT NULL,
  `prescription` varchar(250) NOT NULL,
  `findings` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `thread_id` int(11) NOT NULL,
  `pet_owner_id` int(11) NOT NULL,
  `vetid` varchar(70) NOT NULL,
  `user_message` int(11) NOT NULL,
  `created_time_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `message_content` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `date_time_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isViewed` tinyint(1) NOT NULL,
  `isNew` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `appointment_id`, `service_id`, `status`, `date_time_created`, `isViewed`, `isNew`) VALUES
(85, 126, 29, 'Pending', '2021-10-29 11:28:31', 1, 1),
(86, 126, 29, 'Approved', '2021-10-29 11:29:51', 1, 1),
(87, 126, 29, 'Done', '2021-10-29 13:27:54', 1, 1),
(88, 126, 29, 'Approved', '2021-10-29 17:25:18', 1, 1),
(89, 126, 29, 'Done', '2021-10-29 17:25:18', 1, 1),
(90, 126, 29, 'Approved', '2021-10-29 17:25:18', 1, 1),
(91, 126, 29, 'Done', '2021-10-29 17:25:18', 1, 1),
(92, 126, 29, 'Approved', '2021-10-29 17:25:18', 1, 1),
(93, 126, 29, 'Approved', '2021-10-29 17:25:18', 1, 1),
(94, 126, 29, 'Done', '2021-10-29 17:26:32', 1, 1),
(95, 127, 27, 'Approved', '2021-10-29 17:34:54', 1, 1),
(96, 127, 27, 'Void', '2021-10-29 17:34:54', 1, 1),
(97, 128, 31, 'Pending', '2021-11-03 04:50:56', 1, 1),
(98, 128, 31, 'Approved', '2021-11-03 14:16:50', 1, 1),
(99, 128, 31, 'Done', '2021-11-03 14:16:50', 1, 1),
(100, 129, 2, 'Pending', '2021-11-03 14:18:15', 1, 1),
(101, 129, 2, 'Approved', '2021-11-03 14:16:50', 1, 1),
(102, 129, 2, 'Done', '2021-11-03 14:16:50', 1, 1),
(103, 130, 4, 'Pending', '2021-11-03 14:18:15', 1, 1),
(104, 130, 4, 'Approved', '2021-11-03 14:18:55', 1, 1),
(105, 131, 31, 'Pending', '2021-11-04 06:58:36', 0, 1),
(106, 131, 31, 'Approved', '2021-11-05 07:36:57', 1, 1),
(107, 131, 31, 'Done', '2021-11-05 07:36:57', 1, 1),
(108, 132, 20, 'Pending', '2021-11-06 14:06:35', 0, 1),
(109, 133, 21, 'Pending', '2021-11-06 14:06:35', 0, 1),
(110, 132, 20, 'Approved', '2021-11-06 14:07:03', 1, 0),
(111, 132, 20, 'Done', '2021-11-08 08:45:34', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `notification_reservation`
--

CREATE TABLE `notification_reservation` (
  `notif_reserve_id` int(11) NOT NULL,
  `reserve_id` int(11) NOT NULL,
  `product_id` varchar(70) NOT NULL,
  `status` varchar(50) NOT NULL,
  `date_time_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `isViewed` tinyint(1) NOT NULL,
  `isNew` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notification_reservation`
--

INSERT INTO `notification_reservation` (`notif_reserve_id`, `reserve_id`, `product_id`, `status`, `date_time_created`, `isViewed`, `isNew`) VALUES
(38, 104, '30375976', 'Reserved', '2021-10-29 11:27:40', 1, 1),
(39, 104, '30375976', 'Purchased', '2021-10-29 11:28:23', 1, 1),
(40, 105, '3006381', 'Reserved', '2021-10-29 17:43:20', 1, 1),
(41, 106, '30375976', 'Reserved', '2021-11-05 07:34:15', 0, 1),
(42, 106, '30375976', 'Cancelled', '2021-11-05 07:38:27', 0, 1),
(43, 107, '30375976', 'Reserved', '2021-11-05 13:44:56', 0, 1),
(44, 108, '28528578', 'Reserved', '2021-11-05 14:09:05', 0, 1),
(45, 108, '28528578', 'Purchased', '2021-11-05 14:13:31', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `pets`
--

CREATE TABLE `pets` (
  `pet_id` int(11) NOT NULL,
  `pet_owner_id` int(11) NOT NULL,
  `pet_owner_name` varchar(60) NOT NULL,
  `pet_name` varchar(50) NOT NULL,
  `type_of_pet` varchar(50) NOT NULL,
  `breed_of_pet` varchar(50) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `birth_day` date NOT NULL,
  `pet_picture` text NOT NULL,
  `isArchived` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pets`
--

INSERT INTO `pets` (`pet_id`, `pet_owner_id`, `pet_owner_name`, `pet_name`, `type_of_pet`, `breed_of_pet`, `gender`, `birth_day`, `pet_picture`, `isArchived`) VALUES
(18, 58, 'Jhaycee Llaneta', 'Jake', 'Dog', 'Aspin', 'Male', '2019-07-26', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/elisa-kennemer-0TdrHK0po7I-unsplash.jpg?alt=media&token=0a0d77b3-0d86-44a4-83ea-60168c25bde5', 0),
(19, 58, 'Jhaycee Llaneta', 'Johnson', 'Dog', 'Aspin', 'Male', '2019-09-05', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/photo-1522276498395-f4f68f7f8454.jpg?alt=media&token=cc600a1d-ada3-4227-bb4a-2e139f33aa8a', 0),
(21, 58, 'Jhaycee Llaneta', 'Yoda', 'Dog', 'Aspin', 'Male', '2021-05-05', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/elisa-kennemer-0TdrHK0po7I-unsplash.jpg?alt=media&token=0a0d77b3-0d86-44a4-83ea-60168c25bde5', 0),
(22, 58, 'Jhaycee Llaneta', 'Chardeeiii', 'Dog', 'Corgi', 'Male', '2020-12-12', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/International-Corgi-Day-1.jpg?alt=media&token=1f250eb9-25d5-4354-8999-7a6f2a83ea71', 0),
(23, 58, 'Jhaycee Llaneta', 'Togon', 'Dog', 'Aspin', 'Female', '2021-09-16', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/International-Corgi-Day-1.jpg?alt=media&token=6ecaa530-8479-4ab2-9867-2d3b4d20861e', 0),
(24, 58, 'Jhaycee Llaneta', 'Max', 'Dog', 'Corgi', 'Male', '2021-09-06', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/International-Corgi-Day-1.jpg?alt=media&token=e87f827e-3e68-4b90-b0e9-1affd2deae3b', 0),
(28, 76, 'Jimuel Mercado', 'Buddy', 'Dog', 'Bulldog', 'Male', '2021-06-21', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/jim1.jfif?alt=media&token=dcd83a21-394a-4d06-be3b-1c7d285e302c', 0),
(29, 76, 'Jimuel Mercado', 'Archie', 'Dog', 'Shih Tzu', 'Female', '2021-09-13', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/jim2.jfif?alt=media&token=1ee7dda3-0863-471e-8958-02a542f49df1', 1),
(30, 76, 'Jimuel Mercado', ' Oscar', 'Dog', 'Labrador', 'Male', '2021-09-10', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/jim3.jfif?alt=media&token=4aecd36d-d7f8-41d0-96bc-4223af9fe452', 1),
(31, 77, 'Richard Sasis', 'Mina', 'Cat', 'Scottish Fold', 'Female', '2021-05-02', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/chard1.jfif?alt=media&token=8ba6e14b-fd70-4a4d-9dec-cf41ab2d02aa', 0),
(33, 77, 'Richard Sasis', 'Charlie', 'Dog', 'Beagle', 'Male', '2020-12-12', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/chard2.jpg?alt=media&token=01bae7ba-7d5f-43a3-8841-f742c7b0f129', 0),
(34, 77, 'Richard Sasis', 'Chardei', 'Dog', 'Corgi', 'Male', '2021-02-16', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/corgi3.jfif?alt=media&token=03cd1e0c-e495-4249-aea3-a307d1cf9d99', 0),
(36, 78, 'Carmella Joy Guelas', 'Teddy', 'Dog', 'Bulldog', 'Male', '2021-03-30', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/jim1.jfif?alt=media&token=80e825eb-c026-4ec9-af16-09dbb205f67b', 0),
(37, 78, 'Carmella Joy Guelas', 'Alfie', 'Dog', 'Corgi', 'Female', '2020-07-21', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/corgi1.jpg?alt=media&token=7c5c194f-5bc9-4c6c-ae67-8349357f7c4e', 1),
(38, 58, 'Jhaycee Llaneta', 'Jimmy', 'Dog', 'Bulldog', 'Male', '2021-09-14', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/jim1.jfif?alt=media&token=fc876a22-2d98-48b8-aa89-a263ca3b7ca4', 0);

-- --------------------------------------------------------

--
-- Table structure for table `pet_owners`
--

CREATE TABLE `pet_owners` (
  `pet_owner_id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(70) NOT NULL,
  `name` varchar(20) NOT NULL,
  `address` varchar(50) NOT NULL,
  `contact_number` varchar(11) NOT NULL,
  `profilePicture` text NOT NULL,
  `isArchived` tinyint(1) NOT NULL,
  `isOnline` tinyint(1) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pet_owners`
--

INSERT INTO `pet_owners` (`pet_owner_id`, `email`, `password`, `name`, `address`, `contact_number`, `profilePicture`, `isArchived`, `isOnline`, `created_date`) VALUES
(58, 'john040717@gmail.com', '$2b$10$zxbmiHBi0suCVcCycR0VdOtZdu6qHCj4LYq9hGn6a85QFTKvtmMi6', 'Jhaycee Llaneta', 'Tondo, Manila', '09558264299', 'http://localhost:3001/profile/petowner/profile_petowner_1621987617668.jpg', 0, 0, '2021-06-02 18:53:08'),
(76, 'jimuel78@gmail.com', '$2b$10$ftTcuaqcRQXUL2Zo5OJgru17f5PFeTXXiK6KKlndKJzSPoWt8scBe', 'Jimuel Mercado', '', '09873627372', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/jimuel.jpg?alt=media&token=d1767f25-8cfa-4b84-83c7-d03ff8f92832', 1, 0, '2021-09-30 00:33:26'),
(77, 'richard12@gmail.com', '$2b$10$ILZwv/qXorlT50S1giv0/.PB5vGa1aTNNeuWE4K0cnARPIn1C4y4S', 'Richard Sasis', '', '09354555893', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/richard.jpg?alt=media&token=8981c0e4-fee4-4e82-aede-fd90783db9db', 0, 0, '2021-09-30 00:41:55'),
(78, 'carmella08@gmail.com', '$2b$10$FV6o6EL6T5H1RmHuvP0Q2OXdnWREGg8vjy2n8dEZbGCujAQ8TKAwS', 'Carmella Joy Guelas', '', '09364792733', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/carmella.jpg?alt=media&token=feff4ba1-4c98-4589-9aee-10219f59f5c7', 0, 0, '2021-09-30 00:45:08'),
(82, 'carl@gmail.com', '$2b$10$2dAbtv4S3PL3xPUON7ZVT.YWSq3SHUf6KYIMjufe3VjEhX/2H3J7m', 'Carl Maritana', '1123 Cavite Street,Tondo, Manila', '09473857842', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/carm1.jfif?alt=media&token=fa31314b-05ee-4c0e-a832-394dcca600f4', 0, 0, '2021-10-05 14:22:35'),
(83, 'johnpenazo@gmail.com', '$2b$10$l15chJ9ByIE1Is8MVm1UHuulhYPQxnKpfnSsK.0ZURBRoyHll0IR.', 'John Penazo', '1601 varona street,tondo manila', '09072069351', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/21369213_1609700262438143_6979360524817941722_n.jpg?alt=media&token=ede1ed8b-3adb-4529-ae3e-f6be9de7db8d', 0, 0, '2021-10-21 02:56:20'),
(85, 'janella02@gmail.com', '$2b$10$3BIwgv35SWPvgWK2SQplaupsP1XoOlQ1cGdS9QdnSUHLTuQ9cgrKm', 'janella', '004 Sabino Alley, Maysan,Valenzuela City', '09389302032', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/johna.jpg?alt=media&token=245439a6-270d-4cce-a5af-004a69cd22e7', 0, 0, '2021-10-22 10:18:40'),
(87, 'clarisa098@gmail.com', '$2b$10$3YMHkHcbBFWRNUlbrH..uuUf4e7BfYeHXhkHy5zOE20aThZYfc0g2', 'clarisa', '008 legarda,Quezon', '09789473999', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/carmella.jpg?alt=media&token=fca46a43-afaa-45d9-a445-a9ab394fb17c', 0, 0, '2021-10-22 21:12:33'),
(88, 'alord10@gmail.com', '$2b$10$F6q.tDGOzfklf5M48x6smeOJsCNCs/NeSbTp9HEAUY8JG53Mgio/2', 'alord', '008 legarda,Quezon', '09776645454', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/carmella.jpg?alt=media&token=ecc47f74-66b9-4d37-8ae6-ec8eb7b05399', 0, 0, '2021-10-22 21:34:30'),
(89, 'justin24@gmail.com', '$2b$10$9KJBOotE7mAqOo8ZLK6A0Ojf/8Ysr4bZBIz/Ikao1rjrzmJmCdgWW', 'justin', '008 legarda,Quezon', '09487593899', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/chard1.jfif?alt=media&token=2129cedf-ce65-4e72-ab46-16492a78ac01', 0, 0, '2021-10-22 21:38:30');

-- --------------------------------------------------------

--
-- Table structure for table `pet_registry_for_vet`
--

CREATE TABLE `pet_registry_for_vet` (
  `pet_registry_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `vet_admin_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pharmacy`
--

CREATE TABLE `pharmacy` (
  `medicine_id` int(11) NOT NULL,
  `medicine_name` varchar(100) NOT NULL,
  `medicine_description` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `price` int(11) NOT NULL,
  `vetid` varchar(100) NOT NULL,
  `medicine_image` varchar(200) NOT NULL,
  `med_id` varchar(100) NOT NULL,
  `medicine_number` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pharmacy`
--

INSERT INTO `pharmacy` (`medicine_id`, `medicine_name`, `medicine_description`, `status`, `price`, `vetid`, `medicine_image`, `med_id`, `medicine_number`) VALUES
(14, 'Heartgard (ivermectin/pyrantel)', 'Heartgard (ivermectin/pyrantel)\nFor Dogs 51 - 100 lbs\n6 Chewables', 1, 260, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Web%20capture_15-6-2021_234216_www.1800petmeds.com.jpeg?alt=media&token=8a5ed239-5445-4f11-b22d-565e97f62890', '93697429', ''),
(16, 'MONDEX WATER SOLUBLE POWDER 100G ENERGY SUPPLEMENT', 'Contains 99.9% glucose monohydrate U.S.P. grade\nFast absorbed from the digestive tract to provide instant energy', 1, 90, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/mondex-water-soluble-powder-100g-energy-supplement.jpg?alt=media&token=e7b5821c-a934-48dc-84e2-bfb012d09327', '92162827', ''),
(17, 'Rabisin', 'Rabisin description', 1, 250, '$2b$10$Mb3CCA1C9F1UMR0FIc3LAujtXoUuVQiAIoZJ28ILLZsf9byONGZ3i', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/download.jfif?alt=media&token=3f698df9-fc17-4674-94eb-7bf564029c65', '94702417', ''),
(18, 'PET DRS MEGA OIL 200ML DOG LIQUID SUPPLEMENT', 'MADE IN AUSTRALIA\nWith Omega 3, 6 and 9 essential fatty acids\nFor healthy skin and coat', 1, 900, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/pet-drs-mega-oil-200ml-pet-oral-liquid.jpg?alt=media&token=a35b1f77-6b87-4132-a9fb-0ef2311b6af1', '71664150', ''),
(22, 'PET DRS SHAMPOO 250ML PET SHAMPOO', 'MADE IN AUSTRALIA\nWith natural ingredients such as Coconut Oil and Manuka Honey\nGently cleans and conditions skin and coat\nSensitive skin formula, hypoallergenic\npH balanced', 1, 850, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/pet-drs-shampoo-250ml-pet-shampoo.jpg?alt=media&token=18113266-fc9c-409f-8d77-132c2549d201', '43194615', '');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` varchar(70) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_desc` varchar(500) NOT NULL,
  `vetid` varchar(70) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `product_image` varchar(200) NOT NULL,
  `category` varchar(50) NOT NULL,
  `pet_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `product_desc`, `vetid`, `quantity`, `price`, `product_image`, `category`, `pet_type`) VALUES
('21849527', 'LIMITED EDITION ZEE.BED X CHINATOWN MARKET SMILEY PET BED', 'LIMITED EDITION DESIGN\nUltra comfortable memory foam orthopedic dog bed - perfect for all dogs!\nEasy to clean removable, hypoallergenic bed cover\nScratch resistant soft microfiber cover\nAnti-slip rubber bottom', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 400, 850, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/limited-edition-zeebed-x-chinatown-market-smiley-pet-bed.jpg?alt=media&token=97dd4112-2e94-4ee9-9daa-34029896178e', 'Merchandise', 'Dogs'),
('22022844', 'Pedigree', 'pedigree desc', '$2b$10$Mb3CCA1C9F1UMR0FIc3LAujtXoUuVQiAIoZJ28ILLZsf9byONGZ3i', 18, 300, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/91Kucfnn5KL._AC_SX522_.jpg?alt=media&token=bc8ff792-b7cf-4cf4-bf54-4675f1e9b7c3', 'Food', 'Dogs'),
('28528578', 'ZEE.DOG BLACK POOP BAG DISPENSER', 'Comes with 1 poop bag roll\nEasy to attach to the leash, does not bounce and bother while walking\nReflective rope with custom design\nHolds Zee.Dog poop-bags rolls, bags never jam\nEasy screw system for bag replacement', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 42, 350, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Web%20capture_20-8-2021_32238_www.petwarehouse.ph.jpeg?alt=media&token=7c33dd90-5caa-443d-a0d2-e1553e116765', 'Accessories', 'Dogs'),
('3006381', 'Royal Canin', 'Cat food for cats', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 132, 450, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Web%20capture_15-6-2021_221343_www.petwarehouse.ph.jpeg?alt=media&token=9eed0363-96ad-4512-8453-d38e11614cc4', 'Food', 'Cat'),
('30375976', 'Fancy Feast (Classic Pate)', 'Cat food that taste good', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 85, 350, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Web%20capture_15-6-2021_225219_www.petwarehouse.ph.jpeg?alt=media&token=88d85381-c5f2-45a0-8a23-e8f8d469fc7b', 'Food', 'Cat'),
('32296526', 'ZEE.DOG CLASSIC MELAMINE CORAL & WHITE DOG BOWL', 'Anti-slip grip bottom\nMade with a unique melamine polymer which keeps bacteria away\nHygienic and easy to wash, dishwasher safe', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 250, 650, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/zeedog-classic-melamine-coral-white-dog-bowl.jpg?alt=media&token=aba1d462-e03a-42c5-bba1-94a5454f975c', 'Food', 'Dogs'),
('8926439', 'WEST PAW QWIZL DOG CHEW TOY', 'MADE IN THE USA\nBUILT FOR TOUGH CHEWERS\nMade with Zogoflex® material, non-toxic and dishwasher safe (top rack)\nPuzzle toy helps stimulate dogs’ brains to support healthy growth\nExtends life of spendy treats\n', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 194, 1095, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/west-paw-qwizl-dog-chew-toy.jpg?alt=media&token=1d955463-914d-4002-9432-ddad32612cd8', 'Toys', 'Dogs');

-- --------------------------------------------------------

--
-- Table structure for table `rate_feedback`
--

CREATE TABLE `rate_feedback` (
  `feedback_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `ratings` float NOT NULL,
  `comments` varchar(200) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rate_feedback`
--

INSERT INTO `rate_feedback` (`feedback_id`, `appointment_id`, `ratings`, `comments`, `date_created`) VALUES
(1, 33, 3.5, 'Yes naman', '2021-10-20 07:46:30'),
(3, 27, 5, 'I like the vet', '2021-10-20 19:59:15'),
(4, 49, 5, 'tri city', '2021-10-20 21:24:38'),
(5, 23, 4.5, 'westvalley', '2021-10-20 21:34:44');

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `reserve_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `pet_owner_id` int(11) NOT NULL,
  `vetid` varchar(80) NOT NULL,
  `reserve_quantity` int(11) NOT NULL,
  `reservation_status` varchar(50) NOT NULL,
  `date_reserve` datetime NOT NULL,
  `date_accomplished` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`reserve_id`, `product_id`, `pet_owner_id`, `vetid`, `reserve_quantity`, `reservation_status`, `date_reserve`, `date_accomplished`) VALUES
(104, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, 'Expired', '2021-10-29 19:27:40', '2021-10-30 14:38:44'),
(105, 3006381, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, 'Expired', '2021-10-30 01:43:20', '2021-11-02 23:14:26'),
(106, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, 'Expired', '2021-11-05 15:34:15', '2022-02-17 01:39:04'),
(107, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, 'Expired', '2021-11-05 21:44:56', '2022-02-17 01:39:04'),
(108, 28528578, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, 'Expired', '2021-11-05 22:09:05', '2022-02-17 01:39:04');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` int(11) NOT NULL,
  `service_name` varchar(50) NOT NULL,
  `service_description` text NOT NULL,
  `category` varchar(100) NOT NULL,
  `service_fee` int(11) NOT NULL,
  `vetid` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`service_id`, `service_name`, `service_description`, `category`, `service_fee`, `vetid`) VALUES
(2, 'Pet Grooming (Dogs & Cats)', 'A professional grooming session typically consists of the dog being brushed, bathed, and dried, as well as trimmed or clipped. The groomer brushes or combs out mats before the bath, making it easier to lather the dog with shampoo. They clean the dog\'s ears to remove buildup and to check for signs of infection.', 'Pet Grooming', 500, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc'),
(3, 'Flea & Tick Control', 'fleas and ticks is a living parasite that effects your pet’s health. using this flea and ticks’ control to prevent skin and transmitting infections. ', 'Preventive Controls', 500, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc'),
(4, 'Heartworm Prevention', 'Pets may develop heart failure and the appearance of a swollen belly due to excess fluid in the abdomen. Dogs with large numbers of heartworms can develop a sudden blockages of blood flow within the heart leading to a life-threatening form of cardiovascular collapse. Heartworm Prevention helps your pet preventing this failure using treatment of veterinary clinics.', 'Preventive Controls', 600, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc'),
(6, 'Blood & Urine Testing', 'A blood in urine test is usually part of a typical urinalysis. In addition to checking for blood, a urinalysis measures other substance in the urine, including proteins, acid and sugar levels, cell fragments, and crystals. this testing helps your pets to make an immediate relief for their disease.', 'Pet Examination', 1000, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(8, 'Nail trimming', 'Nail trimming is essential for maintaining good health. If a pet\'s nails can grow, they will curl over into a spiral shape; walking will become increasingly painful. Uncut nails may curl so far that they pierce the paw pad, leading to infection and debilitating pain.', 'Pet Grooming', 500, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc'),
(10, 'Nail Trimming', 'Trimming of pet\'s nails', 'Pet grooming', 300, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc'),
(18, 'Anti rabies ', 'Antirabies for dogs and cats and any kinds of animals', 'Vaccination', 350, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(19, 'Blood testing', 'testing the blood of the pet', 'Pet Examination', 500, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(20, 'DHCP', 'anti distemper', 'Vaccination', 300, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(21, 'Consultation', 'Check Up consultation with Dr. West.', 'Consultation', 500, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(23, 'Urine Testing', 'Testing the urine of your pet', 'Pet Examination', 500, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(24, 'DHPP Vaccine (5-in-1 Vaccine)', 'The 5-in-1 vaccine for dogs is typically referred to by its acronym (DHPP, DAPP, or DA2PP) to indicate the diseases it protects against.\n\nThe canine 5-in-1 vaccine includes protection against canine distemper virus (indicated by the letter D), two types of adenovirus, aka hepatitis and kennel cough (named A, A2, or H), parainfluenza (P), and parvovirus (P).\n\nThese diseases are all caused by viruses with no known cure, so vaccination is the primary way to keep dogs protected. They are also highly contagious, and dogs of all ages are at risk of becoming infected.', 'Vaccination', 500, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(25, 'Full Service (small dogs)', 'Full Service (small dogs)\nIncludes the following:\nNail trim + buffing\nTeeth brushing\nBreath Refresh\nEar cleaning\nGland expression\nFace, feet, and fanny trim\nFlea & tick treatment\nBlueberry facial\nPaw balm', 'Pet Grooming', 450, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(26, 'Full Service (large dogs)', 'Full Service (small dogs)\nIncludes the following:\nNail trim + buffing\nTeeth brushing\nBreath Refresh\nEar cleaning\nGland expression\nFace, feet, and fanny trim\nFlea & tick treatment\nBlueberry facial\nPaw balm', 'Pet Grooming', 500, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(27, 'Nail trim + buffing', 'Nail trim + buffing (small dogs and large dogs)', 'Pet Grooming', 200, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(29, 'Flea & Tick Control', 'fleas and ticks is a living parasite that effects your pet’s health. using this flea and ticks’ control to prevent skin and transmitting infections. ', 'Preventive Controls', 500, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(30, 'Heartworm Prevention', 'Pets may develop heart failure and the appearance of a swollen belly due to excess fluid in the abdomen. Dogs with large numbers of heartworms can develop a sudden blockages of blood flow within the heart leading to a life-threatening form of cardiovascular collapse. Heartworm Prevention helps your pet preventing this failure using treatment of veterinary clinics.', 'Preventive Controls', 400, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(31, 'DHPP Vaccine (5-in-1 Vaccine)', 'The 5-in-1 vaccine for dogs is typically referred to by its acronym (DHPP, DAPP, or DA2PP) to indicate the diseases it protects against.\n\nThe canine 5-in-1 vaccine includes protection against canine distemper virus (indicated by the letter D), two types of adenovirus, aka hepatitis and kennel cough (named A, A2, or H), parainfluenza (P), and parvovirus (P).\n\nThese diseases are all caused by viruses with no known cure, so vaccination is the primary way to keep dogs protected. They are also highly contagious, and dogs of all ages are at risk of becoming infected.', 'Vaccination', 500, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc'),
(32, 'Anti rabies', 'anti rabies desc', 'Vaccination', 500, '$2b$10$Mb3CCA1C9F1UMR0FIc3LAujtXoUuVQiAIoZJ28ILLZsf9byONGZ3i');

-- --------------------------------------------------------

--
-- Table structure for table `stock_in`
--

CREATE TABLE `stock_in` (
  `stock_in_id` int(11) NOT NULL,
  `vetid` varchar(80) NOT NULL,
  `product_id` int(11) NOT NULL,
  `stockin_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `stockin_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stock_in`
--

INSERT INTO `stock_in` (`stock_in_id`, `vetid`, `product_id`, `stockin_date`, `stockin_quantity`) VALUES
(5, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 30375976, '2021-08-18 17:54:02', 50),
(6, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 3006381, '2021-10-23 00:57:37', 50),
(7, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 32296526, '2021-11-03 13:05:19', 10),
(8, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 32296526, '2021-11-03 13:05:44', 10),
(9, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 32296526, '2021-11-03 13:07:22', 10),
(10, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 32296526, '2021-11-03 13:09:09', 50),
(11, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 32296526, '2021-11-03 13:46:24', 10),
(12, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 21849527, '2021-11-03 13:56:36', 30),
(13, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 21849527, '2021-11-03 14:00:06', 30),
(14, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 21849527, '2021-11-03 14:00:29', 40);

-- --------------------------------------------------------

--
-- Table structure for table `stock_used`
--

CREATE TABLE `stock_used` (
  `stockused_id` int(11) NOT NULL,
  `vetid` int(11) NOT NULL,
  `product_id` varchar(80) NOT NULL,
  `stockused_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `stockused_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stock_used`
--

INSERT INTO `stock_used` (`stockused_id`, `vetid`, `product_id`, `stockused_date`, `stockused_quantity`) VALUES
(1, 0, '3006381', '2021-08-18 17:54:14', 50),
(2, 0, '28528578', '2021-10-22 21:24:53', 2),
(3, 0, '32296526', '2021-11-03 14:04:23', 20);

-- --------------------------------------------------------

--
-- Table structure for table `system_administrator`
--

CREATE TABLE `system_administrator` (
  `admin_id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL,
  `name` varchar(50) NOT NULL,
  `profilePicture` text NOT NULL,
  `phone_number` varchar(11) NOT NULL,
  `isArchived` tinyint(1) NOT NULL,
  `isOnline` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `system_administrator`
--

INSERT INTO `system_administrator` (`admin_id`, `email`, `password`, `name`, `profilePicture`, `phone_number`, `isArchived`, `isOnline`) VALUES
(1, 'admin@gmail.com', '$2b$10$qrfPll4/KDZU1PLePJVKRuQrM7K5sHuPXbKb8Mz3vk8ae2EGNd.n.', 'kingchardddffff', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/21369213_1609700262438143_6979360524817941722_n.jpg?alt=media&token=371a4a3b-3458-4150-a269-a676e4727a4a', '', 0, 0),
(2, 'walton@gmail.com', '$2b$10$8uBWLrC4T02lDLv5ACFBteT2YROk02xygz56aDGOuwgoP8hdf7KDS', 'Luke walton', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/21369213_1609700262438143_6979360524817941722_n.jpg?alt=media&token=371a4a3b-3458-4150-a269-a676e4727a4a', '09308161836', 0, 0),
(3, 'smith@gmail.com', '$2b$10$3f/ePFXnqGmV2bDB6VmA1.Rl9/KwdYF5ERBULZGtQvXVDRR9nZy4y', 'Sam Smith', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/21369213_1609700262438143_6979360524817941722_n.jpg?alt=media&token=6a96b25a-1d89-483a-ac73-88c11d65b12c', '09302658794', 0, 0),
(4, 'samsmith@gmail.com', '$2b$10$5yJtwwsQfE4dOZEtWoy.NOTkQwxH7nZF4bGKKXc2XKvaJaXS72tTW', 'Sam Smith', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/21369213_1609700262438143_6979360524817941722_n.jpg?alt=media&token=ddbbc98a-725f-4308-9dae-7f4120ecb903', '09558264289', 0, 0),
(7, 'jocylyn14@gmail.com', '$2b$10$j/lRyGsPkyEYaqdubLxUUu.xZkqzma5hmJllqEgld0dgD5s3pTrYe', 'jocylyn', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/go.jfif?alt=media&token=a34d1d73-ffab-4c76-8f56-4ec27097f4e3', '09748394934', 0, 0),
(8, 'regino123@gmail.com', '$2b$10$PHoZMWP5nIUnnv2RTZo2WO6dpPinztGkGUaci25zOqMTFkjrR/E/G', 'regino', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/go.jfif?alt=media&token=e3f56890-0c5c-403f-baf8-1a4ec69c03c4', '09847836834', 0, 0),
(9, 'carlos12@gmail.com', '$2b$10$1iULY8iTCGQuqm43zjz89uEMSQ4sFSibSfSu43wfH6QSkaUX1SbsW', 'carlos', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/carm3.jfif?alt=media&token=87b3704a-c8c2-4c58-8656-e8c29e5f6165', '09739399234', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `system_logs`
--

CREATE TABLE `system_logs` (
  `logs_id` int(11) NOT NULL,
  `logs_description` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `logs_type` int(11) NOT NULL,
  `date_time_created` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `system_logs`
--

INSERT INTO `system_logs` (`logs_id`, `logs_description`, `logs_type`, `date_time_created`) VALUES
(218, 'kingchardddffff has been logged out as system admin', 3, '2021-10-28 07:48:20'),
(219, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-28 07:52:31'),
(220, 'Tri-City Animal Hospital has been logged in as vet clinic', 1, '2021-10-28 08:23:01'),
(221, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-10-28 14:55:34'),
(222, 'Tri-City Animal Hospital has been logged in as vet clinic', 1, '2021-10-28 14:55:43'),
(223, 'Tri-City Animal Hospital has been logged out as vet clinic', 3, '2021-10-28 14:55:56'),
(224, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-28 14:56:10'),
(225, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-10-28 15:03:03'),
(226, 'Tri-City Animal Hospital has been logged in as vet clinic', 1, '2021-10-28 15:03:17'),
(227, 'Tri-City Animal Hospital has been logged out as vet clinic', 3, '2021-10-28 15:03:37'),
(228, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-28 15:03:45'),
(229, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-10-28 15:05:40'),
(230, 'Tri-City Animal Hospital has been logged in as vet clinic', 1, '2021-10-28 15:05:48'),
(231, 'Tri-City Animal Hospital has been logged out as vet clinic', 3, '2021-10-28 15:06:45'),
(232, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-28 15:07:02'),
(233, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-28 15:08:32'),
(234, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-10-28 15:09:54'),
(235, 'Tri-City Animal Hospital has been logged in as vet clinic', 1, '2021-10-28 15:10:04'),
(236, 'Tri-City Animal Hospital has been logged out as vet clinic', 3, '2021-10-29 01:17:09'),
(237, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-29 01:17:23'),
(238, 'undefined has been logged out in as petowner', 3, '2021-10-29 02:42:25'),
(239, 'Tri-City Animal Hospital has been logged in as vet clinic', 1, '2021-10-29 02:42:39'),
(240, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-10-29 02:47:43'),
(241, 'Tri-City Animal Hospital has been logged in as vet clinic', 1, '2021-10-29 02:47:52'),
(242, 'Tri-City Animal Hospital has been logged out as vet clinic', 3, '2021-10-29 02:48:00'),
(243, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-29 02:48:10'),
(244, 'Tri-City Animal Hospital has been logged out as vet clinic', 3, '2021-10-29 08:06:44'),
(245, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-10-29 08:06:54'),
(246, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-10-29 10:06:03'),
(247, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-10-29 10:06:11'),
(248, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-10-29 10:10:36'),
(249, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-29 10:10:44'),
(250, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-10-29 10:23:36'),
(251, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-10-29 10:23:46'),
(252, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-10-29 11:28:04'),
(253, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-10-29 11:28:12'),
(254, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-10-29 11:28:40'),
(255, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-10-29 11:29:02'),
(256, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-10-29 11:29:24'),
(257, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-29 11:29:32'),
(258, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-10-29 12:54:37'),
(259, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-10-29 12:54:44'),
(260, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-10-29 13:23:59'),
(261, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-29 13:27:46'),
(262, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-10-29 13:45:41'),
(263, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-10-29 13:47:09'),
(264, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-10-29 14:21:43'),
(265, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-29 14:21:53'),
(266, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-10-29 17:52:48'),
(267, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-10-29 17:53:04'),
(268, 'kingchardddffff has been logged in as system admin', 1, '2021-10-29 17:53:12'),
(269, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-10-29 17:59:55'),
(270, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-10-29 18:00:28'),
(271, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-29 18:00:34'),
(272, 'kingchardddffff has been logged out as system admin', 3, '2021-10-29 18:14:50'),
(273, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-29 18:15:09'),
(274, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-10-29 19:41:11'),
(275, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-10-29 19:41:36'),
(276, 'kingchardddffff has been logged in as system admin', 1, '2021-10-29 19:41:45'),
(277, 'kingchardddffff has been logged out as system admin', 3, '2021-10-29 19:53:57'),
(278, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-29 19:54:07'),
(279, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-10-29 19:57:33'),
(280, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-10-29 19:57:47'),
(281, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-10-30 06:40:22'),
(282, 'undefined has been logged out in as petowner', 3, '2021-11-02 15:01:04'),
(283, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-02 15:01:22'),
(284, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-11-02 15:14:01'),
(285, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-11-02 15:14:18'),
(286, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-11-03 04:48:45'),
(287, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-03 04:49:23'),
(288, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-11-03 04:49:59'),
(289, 'Tri-City Animal Hospital has been logged in as vet clinic', 1, '2021-11-03 04:50:13'),
(290, 'Tri City Animal Hospital has been logged out as vet clinic', 3, '2021-11-03 06:43:18'),
(291, 'Tri City Animal Hospital has been logged in as vet clinic', 1, '2021-11-03 06:43:53'),
(292, 'Tri City Animal Hospital has been logged out as vet clinic', 3, '2021-11-03 06:45:33'),
(293, 'Tri City Animal Hospital has been logged in as vet clinic', 1, '2021-11-03 06:45:48'),
(294, 'Tri City Animal Hospital has been logged out as vet clinic', 3, '2021-11-03 06:46:08'),
(295, 'Tri City Animal Hospital has been logged in as vet clinic', 1, '2021-11-03 06:47:23'),
(296, 'Tri City Animal Hospital has been logged out as vet clinic', 3, '2021-11-03 06:48:05'),
(297, 'Tri City Animal Hospital has been logged in as vet clinic', 1, '2021-11-03 06:48:16'),
(298, 'Tri City Animal Hospital has been logged out as vet clinic', 3, '2021-11-03 06:50:34'),
(299, 'Tri City Animal Hospital has been logged in as vet clinic', 1, '2021-11-03 06:50:44'),
(300, 'Tri City Animal Hospital has been logged out as vet clinic', 3, '2021-11-03 06:51:44'),
(301, 'Tri City Animal Hospital has been logged in as vet clinic', 1, '2021-11-03 06:52:01'),
(302, 'Tri City Animal Hospital has been logged out as vet clinic', 3, '2021-11-03 06:58:49'),
(303, 'Tri City Animal Hospital has been logged in as vet clinic', 1, '2021-11-03 06:59:03'),
(304, 'Tri City Animal Hospital has been logged out as vet clinic', 3, '2021-11-03 07:01:06'),
(305, 'Tri City Animal Hospital has been logged in as vet clinic', 1, '2021-11-03 07:02:44'),
(306, 'Tri City Animal Hospital has been logged out as vet clinic', 3, '2021-11-03 07:04:07'),
(307, 'Tri City Animal Hospital has been logged in as vet clinic', 1, '2021-11-03 07:04:23'),
(308, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-03 09:14:47'),
(309, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-03 14:16:43'),
(310, 'Tri City Animal Hospital has been logged in as vet clinic', 1, '2021-11-03 15:11:20'),
(311, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-04 06:09:54'),
(312, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-04 07:36:15'),
(313, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-11-04 07:37:48'),
(314, 'Tri City Animal Hospital has been logged out as vet clinic', 3, '2021-11-04 07:41:51'),
(315, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-11-04 07:42:06'),
(316, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-04 07:53:34'),
(317, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-04 17:31:59'),
(318, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-05 03:07:43'),
(319, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-05 03:22:33'),
(320, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-11-05 07:44:23'),
(321, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-05 10:19:22'),
(322, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-11-05 14:09:51'),
(323, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-11-05 14:13:35'),
(324, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-06 12:59:12'),
(325, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-11-06 14:06:13'),
(326, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-11-06 14:06:52'),
(327, 'undefined has been logged out in as petowner', 3, '2021-11-07 14:02:53'),
(328, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-07 14:03:26'),
(329, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-07 21:31:27'),
(330, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-11-08 08:44:48'),
(331, 'undefined has been logged out in as petowner', 3, '2021-11-09 09:21:56'),
(332, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-09 09:22:16'),
(333, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-11-09 14:24:27'),
(334, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-11-09 20:07:27'),
(335, 'Sci Vet Animal Clinic has been registered as vet clinic', 2, '2021-11-09 20:09:09'),
(336, 'Sci Vet Animal Clinic has been logged in as unverified vet clinic', 1, '2021-11-09 20:09:09'),
(337, 'Sci Vet Animal Clinic has been logged out as unverified vet clinic', 3, '2021-11-09 20:09:33'),
(338, 'Local Vet Animal Clinic has been registered as vet clinic', 2, '2021-11-09 20:16:41'),
(339, 'Local Vet Animal Clinic has been logged in as unverified vet clinic', 1, '2021-11-09 20:16:41'),
(340, 'Local Vet Animal Clinic has been logged out as unverified vet clinic', 3, '2021-11-09 20:19:28'),
(341, 'Sky line Vet Clinic has been registered as vet clinic', 2, '2021-11-09 20:24:50'),
(342, 'Sky line Vet Clinic has been logged in as unverified vet clinic', 1, '2021-11-09 20:24:50'),
(343, 'Sky line Vet Clinic has been logged out as unverified vet clinic', 3, '2021-11-09 20:30:27'),
(344, 'Jhocson Vet Clinic has been registered as vet clinic', 2, '2021-11-09 20:38:00'),
(345, 'Jhocson Vet Clinic has been logged in as unverified vet clinic', 1, '2021-11-09 20:38:00'),
(346, 'Jhocson Vet Clinic has been logged out as unverified vet clinic', 3, '2021-11-09 21:18:30'),
(347, 'undefined has been logged out as vet clinic', 3, '2021-12-03 11:04:24'),
(348, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-03 11:04:44'),
(349, 'undefined has been logged out as vet clinic', 3, '2021-12-06 11:15:07'),
(350, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-06 11:15:39'),
(351, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-12-06 13:48:38'),
(352, 'Tri City Animal Hospital has been logged in as vet clinic', 1, '2021-12-06 13:48:52'),
(353, 'undefined has been logged out as vet clinic', 3, '2021-12-07 14:15:44'),
(354, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-07 14:15:58'),
(355, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-08 09:53:26'),
(356, 'undefined has been logged out as vet clinic', 3, '2021-12-10 11:01:19'),
(357, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-10 11:02:15'),
(358, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-12-10 11:57:30'),
(359, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-13 01:25:10'),
(360, 'undefined has been logged out as vet clinic', 3, '2021-12-14 01:30:47'),
(361, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-14 01:31:02'),
(362, 'undefined has been logged out as vet clinic', 3, '2021-12-15 03:48:04'),
(363, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-15 03:48:28'),
(364, 'undefined has been logged out as vet clinic', 3, '2021-12-17 12:21:47'),
(365, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-17 12:31:34'),
(366, 'undefined has been logged out as vet clinic', 3, '2021-12-18 17:12:57'),
(367, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-18 17:13:16'),
(368, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-19 15:25:52'),
(369, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-19 16:05:14'),
(370, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-19 16:11:17'),
(371, 'undefined has been logged out as vet clinic', 3, '2021-12-19 16:15:45'),
(372, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-19 16:17:30'),
(373, 'undefined has been logged out as vet clinic', 3, '2021-12-19 16:18:13'),
(374, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-19 16:19:36'),
(375, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-19 16:31:42'),
(376, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-19 16:41:17'),
(377, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-19 16:58:01'),
(378, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-12-19 16:58:19'),
(379, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-19 17:01:35'),
(380, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-19 17:04:24'),
(381, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-19 17:05:06'),
(382, 'Jhaycee Llaneta has been logged in as petowner', 1, '2021-12-23 13:50:15'),
(383, 'Jhaycee Llaneta has been logged out in as petowner', 3, '2021-12-23 13:50:21'),
(384, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2021-12-23 14:55:32'),
(385, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2021-12-23 14:58:07'),
(386, 'undefined has been logged in as system admin', 1, '2021-12-23 14:58:23'),
(387, 'undefined has been logged out as system admin', 3, '2021-12-23 14:59:37'),
(388, 'undefined has been logged in as system admin', 1, '2021-12-23 14:59:50'),
(389, 'undefined has been logged out as system admin', 3, '2021-12-23 15:00:33'),
(390, 'undefined has been logged in as system admin', 1, '2021-12-23 15:02:04'),
(391, 'undefined has been logged out as system admin', 3, '2021-12-23 15:02:18'),
(392, 'undefined has been logged in as system admin', 1, '2021-12-23 15:03:23'),
(393, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-01-23 09:23:34'),
(394, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-01-23 16:23:43'),
(395, 'Pet Owner with 09354555893 change his/her password ', 4, '2022-01-23 16:32:51'),
(396, 'Vet clinic with 09784548784 change their password', 4, '2022-01-23 16:42:03'),
(397, 'undefined has been logged in as system admin', 1, '2022-01-23 16:42:55'),
(398, 'undefined has been logged out as vet clinic', 3, '2022-01-23 16:48:58'),
(399, 'undefined has been logged in as system admin', 1, '2022-01-23 16:49:23'),
(400, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-01-23 16:53:47'),
(401, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-01-23 16:54:06'),
(402, 'undefined has been logged in as system admin', 1, '2022-01-23 17:03:23'),
(403, 'undefined has been logged out as vet clinic', 3, '2022-01-23 17:16:16'),
(404, 'undefined has been logged in as system admin', 1, '2022-01-23 17:16:25'),
(405, 'undefined has been logged in as system admin', 1, '2022-01-23 18:00:23'),
(406, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-01-23 18:08:41'),
(407, 'undefined has been logged in as system admin', 1, '2022-01-23 18:12:03'),
(408, 'undefined has been logged in as system admin', 1, '2022-01-23 18:30:25'),
(409, 'undefined has been logged out as vet clinic', 3, '2022-01-23 18:38:22'),
(410, 'undefined has been logged in as system admin', 1, '2022-01-23 18:38:30'),
(411, 'undefined has been logged out as vet clinic', 3, '2022-01-23 18:55:04'),
(412, 'undefined has been logged in as system admin', 1, '2022-01-23 18:55:11'),
(413, 'undefined has been logged in as system admin', 1, '2022-01-28 18:19:17'),
(414, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-01-28 18:40:17'),
(415, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-01-28 18:40:24'),
(416, 'undefined has been logged in as system admin', 1, '2022-01-28 18:40:35'),
(417, 'undefined has been logged out as vet clinic', 3, '2022-01-28 18:43:45'),
(418, 'undefined has been logged in as system admin', 1, '2022-01-28 18:43:55'),
(419, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-01-28 19:02:28'),
(420, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-01-28 19:05:28'),
(421, 'undefined has been logged in as system admin', 1, '2022-01-28 19:05:46'),
(422, 'undefined has been logged in as system admin', 1, '2022-01-31 16:13:13'),
(423, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-01-31 18:34:32'),
(424, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-01-31 18:34:48'),
(425, 'undefined has been logged in as system admin', 1, '2022-01-31 18:34:56'),
(426, 'undefined has been logged out as vet clinic', 3, '2022-02-01 07:12:44'),
(427, 'Tri City Animal Hospital has been logged in as vet clinic', 1, '2022-02-01 07:13:09'),
(428, 'Tri City Animal Hospital has been logged out as vet clinic', 3, '2022-02-01 07:15:36'),
(429, 'undefined has been logged in as system admin', 1, '2022-02-01 07:15:44'),
(430, 'undefined has been logged out as vet clinic', 3, '2022-02-01 10:23:36'),
(431, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-01 10:23:47'),
(432, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-01 10:24:00'),
(433, 'undefined has been logged in as system admin', 1, '2022-02-01 10:24:07'),
(434, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-01 10:47:39'),
(435, 'undefined has been logged in as system admin', 1, '2022-02-05 07:56:57'),
(436, 'undefined has been logged in as system admin', 1, '2022-02-06 17:50:09'),
(437, 'undefined has been logged in as system admin', 1, '2022-02-06 18:08:13'),
(438, 'undefined has been logged in as system admin', 1, '2022-02-13 16:24:18'),
(439, 'undefined has been logged in as system admin', 1, '2022-02-16 08:15:53'),
(440, 'undefined has been logged out as vet clinic', 3, '2022-02-16 08:16:15'),
(441, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-16 08:16:25'),
(442, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-16 08:21:55'),
(443, 'undefined has been logged in as system admin', 1, '2022-02-16 08:22:07'),
(444, 'undefined has been logged in as system admin', 1, '2022-02-16 16:36:10'),
(445, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-16 17:38:59'),
(446, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-16 17:41:49'),
(447, 'undefined has been logged in as system admin', 1, '2022-02-16 17:42:08'),
(448, 'undefined has been logged in as system admin', 1, '2022-02-18 03:46:43'),
(449, 'undefined has been logged out as vet clinic', 3, '2022-02-18 05:37:42'),
(450, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-18 05:37:51'),
(451, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-18 05:44:04'),
(452, 'undefined has been logged in as system admin', 1, '2022-02-18 05:44:13'),
(453, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-18 06:01:52'),
(454, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-18 06:05:43'),
(455, 'undefined has been logged in as system admin', 1, '2022-02-18 06:07:08'),
(456, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-18 06:16:19'),
(457, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-18 06:17:09'),
(458, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-18 06:17:13'),
(459, 'undefined has been logged in as system admin', 1, '2022-02-18 06:17:42'),
(460, 'undefined has been logged out as vet clinic', 3, '2022-02-18 07:08:46'),
(461, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-18 07:09:01'),
(462, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-18 07:09:53'),
(463, 'undefined has been logged in as system admin', 1, '2022-02-18 07:10:03'),
(464, 'undefined has been logged out as vet clinic', 3, '2022-02-18 07:15:09'),
(465, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-18 07:18:28'),
(466, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-18 07:29:34'),
(467, 'undefined has been logged in as system admin', 1, '2022-02-18 07:29:45'),
(468, 'undefined has been logged in as system admin', 1, '2022-02-18 17:48:09'),
(469, 'undefined has been logged in as system admin', 1, '2022-02-19 16:05:24'),
(470, 'undefined has been logged in as system admin', 1, '2022-02-19 16:12:08'),
(471, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-19 16:39:55'),
(472, 'undefined has been logged in as system admin', 1, '2022-02-23 15:13:57'),
(473, 'undefined has been logged out as vet clinic', 3, '2022-02-23 15:19:39'),
(474, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-23 15:20:24'),
(475, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-23 16:15:31'),
(476, 'undefined has been logged in as system admin', 1, '2022-02-23 16:15:42'),
(477, 'undefined has been logged in as system admin', 1, '2022-02-24 17:56:04'),
(478, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-25 06:00:43'),
(479, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-27 10:04:39'),
(480, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-27 12:10:54'),
(481, 'undefined has been logged in as system admin', 1, '2022-02-27 12:11:05'),
(482, 'undefined has been logged out as vet clinic', 3, '2022-02-27 12:42:05'),
(483, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-27 12:42:13'),
(484, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-27 12:55:23'),
(485, 'undefined has been logged in as system admin', 1, '2022-02-27 12:55:31'),
(486, 'undefined has been logged out as vet clinic', 3, '2022-02-27 14:31:22'),
(487, 'undefined has been logged in as system admin', 1, '2022-02-27 14:31:31'),
(488, 'undefined has been logged out as vet clinic', 3, '2022-02-27 14:35:36'),
(489, 'undefined has been logged in as system admin', 1, '2022-02-27 14:35:46'),
(490, 'undefined has been logged out as vet clinic', 3, '2022-02-27 14:56:56'),
(491, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-27 14:59:46'),
(492, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-27 15:02:37'),
(493, 'undefined has been logged in as system admin', 1, '2022-02-27 15:02:47'),
(494, 'undefined has been logged out as vet clinic', 3, '2022-02-27 15:03:41'),
(495, 'undefined has been logged in as system admin', 1, '2022-02-27 15:03:49'),
(496, 'undefined has been logged out as vet clinic', 3, '2022-02-27 15:07:08'),
(497, 'undefined has been logged in as system admin', 1, '2022-02-27 15:08:02');

-- --------------------------------------------------------

--
-- Table structure for table `thread`
--

CREATE TABLE `thread` (
  `thread_id` int(11) NOT NULL,
  `pet_owner_id` int(11) NOT NULL,
  `vetid` varchar(70) NOT NULL,
  `created_time_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `thread`
--

INSERT INTO `thread` (`thread_id`, `pet_owner_id`, `vetid`, `created_time_date`) VALUES
(1, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', '2021-09-01 06:35:51'),
(2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', '2021-09-23 15:38:15'),
(3, 58, '$2b$10$Mb3CCA1C9F1UMR0FIc3LAujtXoUuVQiAIoZJ28ILLZsf9byONGZ3i', '2021-10-25 14:13:32');

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `user_role_id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `userrole` int(11) NOT NULL,
  `phone_number` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`user_role_id`, `email`, `userrole`, `phone_number`) VALUES
(2, 'admin@gmail.com', 3, ''),
(4, 'john040717@gmail.com', 1, '09558264299'),
(48, 'tricity@gmail.com', 2, '09404555899'),
(74, 'animalhouse@gmail.com', 2, ''),
(76, 'westvalley@gmail.com', 2, ''),
(77, 'jimuel78@gmail.com', 1, ''),
(78, 'richard12@gmail.com', 1, '09354555893'),
(79, 'carmella08@gmail.com', 1, ''),
(80, 'arol31@gmail.com', 1, ''),
(81, 'cayco_clinic@gmail.com', 2, ''),
(82, 'curapet@gmail.com', 2, ''),
(83, 'wt_clinic@gmail.com', 2, ''),
(84, 'pspca@gmail.com', 2, ''),
(85, 'manila_vet@gmail.com', 1, ''),
(87, 'alfie@gmail.com', 1, ''),
(88, 'carl@gmail.com', 1, ''),
(89, 'johnpenazo@gmail.com', 1, '09072069351'),
(90, 'tumanivetclinic@gmail.com', 2, '09073654951'),
(93, 'walton@gmail.com', 3, '09308161836'),
(94, 'smith@gmail.com', 3, '09302658794'),
(95, 'samsmith@gmail.com', 3, '09558264289'),
(98, 'eastlife@gmail.com', 2, '09558264223'),
(99, 'janella02@gmail.com', 1, '09389302032'),
(103, 'chardVet@gmail.com', 2, '09836728223'),
(107, 'jocylyn14@gmail.com', 3, '09748394934'),
(109, 'regino123@gmail.com', 3, '09847836834'),
(110, 'clarisa098@gmail.com', 1, '09789473999'),
(111, 'alord10@gmail.com', 1, '09776645454'),
(113, 'justin24@gmail.com', 1, '09487593899'),
(114, 'vetvetClinic@gmail.com', 2, '09587939393'),
(115, 'cerceas12@gmail.com', 1, '09748493934'),
(118, 'carlos12@gmail.com', 3, '09739399234'),
(119, 'myvet@gmail.com', 2, '09357498232'),
(120, 'scivetanimal@gmail.com', 2, '09081236547'),
(121, 'localvet@gmail.com', 2, '09087896541'),
(122, 'skyline@gmail.com', 2, '09458962657'),
(123, 'jhocsonvet@gmail.com', 2, '09784548784'),
(135, 'chard12@gmail.com', 4, '09081052103'),
(136, 'richardsasis12@gmail.com', 5, '09354555588');

-- --------------------------------------------------------

--
-- Table structure for table `vaccination`
--

CREATE TABLE `vaccination` (
  `vaccination_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `vet_admin_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `weight` double NOT NULL,
  `againts` varchar(100) NOT NULL,
  `manufacturer` varchar(200) NOT NULL,
  `Lot. No.` int(11) NOT NULL,
  `vet_signature` varchar(150) NOT NULL,
  `lic_no` int(11) NOT NULL,
  `exp_date` date NOT NULL,
  `ptr` int(11) NOT NULL,
  `tin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `vet_clinic`
--

CREATE TABLE `vet_clinic` (
  `vet_admin_id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL,
  `vet_name` varchar(100) NOT NULL,
  `vet_address` varchar(50) NOT NULL,
  `vet_contact_number` varchar(11) NOT NULL,
  `vet_permit` varchar(255) NOT NULL,
  `vet_picture` varchar(255) NOT NULL,
  `vet_status` varchar(15) NOT NULL,
  `scheduleMonday` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `scheduleTuesday` varchar(50) NOT NULL,
  `scheduleWednesday` varchar(50) NOT NULL,
  `scheduleThursday` varchar(50) NOT NULL,
  `scheduleFriday` varchar(50) NOT NULL,
  `scheduleSaturday` varchar(50) NOT NULL,
  `scheduleSunday` varchar(50) NOT NULL,
  `enableProduct` tinyint(1) NOT NULL,
  `enablePharmacy` tinyint(1) NOT NULL,
  `enableServices` tinyint(1) NOT NULL,
  `enableConsultation` tinyint(1) NOT NULL,
  `enableExamination` tinyint(1) NOT NULL,
  `enableGrooming` tinyint(1) NOT NULL,
  `enableVaccination` tinyint(1) NOT NULL,
  `enablePreventiveControls` tinyint(1) NOT NULL,
  `enableInHouseLab` tinyint(1) NOT NULL,
  `vetid` varchar(60) NOT NULL,
  `isOnline` tinyint(1) NOT NULL,
  `callerId` varchar(50) NOT NULL,
  `isBusy` tinyint(1) NOT NULL,
  `longitude` float NOT NULL,
  `Latitude` float NOT NULL,
  `isArchived` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vet_clinic`
--

INSERT INTO `vet_clinic` (`vet_admin_id`, `email`, `password`, `vet_name`, `vet_address`, `vet_contact_number`, `vet_permit`, `vet_picture`, `vet_status`, `scheduleMonday`, `scheduleTuesday`, `scheduleWednesday`, `scheduleThursday`, `scheduleFriday`, `scheduleSaturday`, `scheduleSunday`, `enableProduct`, `enablePharmacy`, `enableServices`, `enableConsultation`, `enableExamination`, `enableGrooming`, `enableVaccination`, `enablePreventiveControls`, `enableInHouseLab`, `vetid`, `isOnline`, `callerId`, `isBusy`, `longitude`, `Latitude`, `isArchived`) VALUES
(19, 'tricity@gmail.com', '$2b$10$9i2h.drYBR5hqXnv1zgr3evSS3s6Fi/rq97RdxjS/H.Wj1xLmnhbm', 'Tri City Animal Hospital', '1949 Int. 5 Blk 10 Sta.Mesa, Manila', '09404555899', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Letter-to-the-Client-Signed.pdf?alt=media&token=b8e535fc-b41d-4aa9-9334-6a23c4fc351a', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Letter-to-the-Client-Signed.pdf?alt=media&token=b8e535fc-b41d-4aa9-9334-6a23c4fc351a', 'Verified', '06:00 - 20:29', '07:06 - 19:10', '19:06 - 18:07', '06:37 - 18:37', '06:36 - 18:37', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 0, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 0, '', 0, 121.006, 14.5993, 0),
(28, 'westvalley@gmail.com', '$2b$10$L68mQGeYEoFlBAVtYCJBZOKLr08agfMDD0igxzWpaZtByT8rzNdV.', 'West Valley Animal Clinic', '1241 blk. 15 Velasquez Street,Tondo, Manila', '09081052103', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Letter-to-the-Client-Signed.pdf?alt=media&token=5b6c9bfc-8c86-472f-a436-3c2b392ecf4b', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/images.png?alt=media&token=a79fd71a-d4d2-4a2f-9a00-e7f9bd24afde', 'Verified', '06:00 - 20:29', '', '', '', '', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 1, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 0, '', 0, 120.988, 14.6066, 0),
(39, 'myvet@gmail.com', '$2b$10$qJEPI2NqaieUOoHMjf6eQeuyrBEEcFdxALL62HiRS2SMQyaAZb4p2', 'MyVet Clinic', '008 legarda,Quezon', '09357498232', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Consent%20Form.pdf?alt=media&token=38fc1ab5-fe2a-422f-a4d1-b477d9d02ad8', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/cayco.jpg?alt=media&token=67488d75-1c58-4616-b065-ccc35cb868d4', 'Verified', '', '', '', '', '', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 0, '$2b$10$Mb3CCA1C9F1UMR0FIc3LAujtXoUuVQiAIoZJ28ILLZsf9byONGZ3i', 0, '', 0, 0, 0, 0),
(40, 'scivetanimal@gmail.com', '$2b$10$jFsCfOyQbzO63kBWzpJCK.sXq49dpiGN2h30JN3fC4IzEMKKYEqKO', 'Sci Vet Animal Clinic', '1425 Lot. 5 Jhocson Street,Sampaloc Manila', '09081236547', '', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/images.png?alt=media&token=4c3f3295-9b7c-4f5b-9598-82b6382151e2', 'Unverified', '', '', '', '', '', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 1, '$2b$10$FWJTPSEKKo7nBLI3nTLCyOnM0M5tqVaye2BAYnwpvAsUasm.NfghW', 0, '', 0, 0, 0, 0),
(41, 'localvet@gmail.com', '$2b$10$ZIXctmYp18xpkrsvPyxhe.XFDEOATZcAavRqtiQ20F1Dio9sXGQpa', 'Local Vet Animal Clinic', '1226 Jhocson Street,Sampaloc Manila', '09087896541', '', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/6a1da98614604240bfd0f0c4f563919e.jpg?alt=media&token=25a07cb5-720f-4502-9eee-41b3fba3e204', 'Unverified', '', '', '', '', '', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 1, '$2b$10$6ijujbsZONeSv0VY7cmq0.m5GNzSWqg7ZOWRWG8aWx64qMPq6AOby', 0, '', 0, 0, 0, 0),
(42, 'skyline@gmail.com', '$2b$10$oQPhQbk/B2bmFm3qNuy8ae2iIszLpCaORchsPg6gekAjYpfDjHQLG', 'Sky line Vet Clinic', '1245 Jhocson Street,Sampaloc Manila', '09458962657', '', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/6a1da98614604240bfd0f0c4f563919e.jpg?alt=media&token=196738bb-aebc-4147-9862-bacc734685b4', 'Unverified', '', '', '', '', '', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 1, '$2b$10$IdYRLkB1a5pVxim9CW8C2eyehCJklWzFMwL8A1WREDeP9I9wIeCw6', 0, '', 0, 0, 0, 0),
(43, 'jhocsonvet@gmail.com', '$2b$10$itj7nu4tGbI6ZZGuj4W4/.86u91wO2i83cCA./U6oX1sAG458dPMm', 'Jhocson Vet Clinic', '2526 Lot. 25 Jhocson Street,Sampaloc Manila', '09784548784', '', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/6a1da98614604240bfd0f0c4f563919e.jpg?alt=media&token=33e62025-ba9f-4258-8ceb-3d3a765e6356', 'Unverified', '', '', '', '', '', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 1, '$2b$10$8nPeSU5pHPYwCwW/T09gOOJAe0sonSWA7v6RrTeK7uLGdG9x6mX6G', 0, '', 0, 121.014, 14.674, 0);

-- --------------------------------------------------------

--
-- Table structure for table `vet_doctors`
--

CREATE TABLE `vet_doctors` (
  `vet_doc_id` int(11) NOT NULL,
  `vetid` varchar(70) NOT NULL,
  `vet_doc_fname` varchar(100) NOT NULL,
  `vet_doc_lname` varchar(100) NOT NULL,
  `vet_doc_mname` varchar(20) NOT NULL,
  `vet_doc_contactNumber` varchar(12) NOT NULL,
  `vet_doc_email` varchar(50) NOT NULL,
  `vet_doc_profilePic` varchar(250) DEFAULT NULL,
  `vet_doc_digitalSignature` varchar(100) NOT NULL,
  `vet_doc_password` varchar(100) NOT NULL,
  `vet_doc_gender` varchar(20) NOT NULL,
  `isOnline` tinyint(1) NOT NULL,
  `isArchived` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vet_doctors`
--

INSERT INTO `vet_doctors` (`vet_doc_id`, `vetid`, `vet_doc_fname`, `vet_doc_lname`, `vet_doc_mname`, `vet_doc_contactNumber`, `vet_doc_email`, `vet_doc_profilePic`, `vet_doc_digitalSignature`, `vet_doc_password`, `vet_doc_gender`, `isOnline`, `isArchived`) VALUES
(6, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 'Jhaycee', 'Llaneta', 'Enriquez', '09081052103', 'chard12@gmail.com', NULL, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Presentation1.jpg?alt=med', '$2b$10$itj7nu4tGbI6ZZGuj4W4/.86u91wO2i83cCA./U6oX1sAG458dPMm', 'Male', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `vet_staff`
--

CREATE TABLE `vet_staff` (
  `vet_staff_id` int(11) NOT NULL,
  `vetid` varchar(70) NOT NULL,
  `vet_staff_fname` varchar(100) DEFAULT NULL,
  `vet_staff_lname` varchar(100) DEFAULT NULL,
  `vet_staff_mname` varchar(20) DEFAULT NULL,
  `vet_staff_contactNumber` varchar(12) DEFAULT NULL,
  `vet_staff_email` varchar(250) NOT NULL,
  `vet_staff_profilePic` varchar(250) NOT NULL,
  `vet_staff_password` varchar(250) NOT NULL,
  `isOnline` tinyint(1) NOT NULL,
  `isArchived` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vet_staff`
--

INSERT INTO `vet_staff` (`vet_staff_id`, `vetid`, `vet_staff_fname`, `vet_staff_lname`, `vet_staff_mname`, `vet_staff_contactNumber`, `vet_staff_email`, `vet_staff_profilePic`, `vet_staff_password`, `isOnline`, `isArchived`) VALUES
(3, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 'Richard', 'Sasis', 'L.', '09354555588', 'richardsasis12@gmail.com', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Letter-to-the-Client-Signed.pdf?alt=media&token=b8e535fc-b41d-4aa9-9334-6a23c4fc351a', '$2b$10$itj7nu4tGbI6ZZGuj4W4/.86u91wO2i83cCA./U6oX1sAG458dPMm', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `visitor_monitoring`
--

CREATE TABLE `visitor_monitoring` (
  `visitor_id` int(11) NOT NULL,
  `pet_owner_id` int(11) NOT NULL,
  `vetid` varchar(100) NOT NULL,
  `temperature` double NOT NULL,
  `date_visited` date NOT NULL DEFAULT current_timestamp(),
  `time_visited` time NOT NULL DEFAULT current_timestamp(),
  `q1` tinyint(1) NOT NULL,
  `q2` tinyint(1) NOT NULL,
  `q3` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `visitor_monitoring`
--

INSERT INTO `visitor_monitoring` (`visitor_id`, `pet_owner_id`, `vetid`, `temperature`, `date_visited`, `time_visited`, `q1`, `q2`, `q3`) VALUES
(23, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 35, '2021-10-19', '15:18:41', 0, 0, 0),
(24, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 38, '2021-10-19', '15:21:34', 1, 1, 1),
(25, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 35, '2021-10-19', '15:22:35', 1, 1, 1),
(26, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 36, '2021-10-19', '15:24:20', 1, 1, 1),
(27, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 36, '2021-10-19', '15:24:40', 1, 1, 1),
(28, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 36, '2021-10-19', '15:37:29', 1, 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `pet_owner_id` (`pet_owner_id`),
  ADD KEY `vet_admin_id` (`vetid`),
  ADD KEY `pet_id` (`pet_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `consultation`
--
ALTER TABLE `consultation`
  ADD PRIMARY KEY (`consultation_id`),
  ADD KEY `vet_doc_id` (`vet_doc_id`),
  ADD KEY `pet_id` (`pet_id`),
  ADD KEY `vetid` (`vetid`) USING BTREE;

--
-- Indexes for table `email_verification`
--
ALTER TABLE `email_verification`
  ADD PRIMARY KEY (`email_id`);

--
-- Indexes for table `forget_password`
--
ALTER TABLE `forget_password`
  ADD PRIMARY KEY (`verify_id`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `vet_admin_id` (`vet_admin_id`),
  ADD KEY `pet_owner_id` (`pet_owner_id`);

--
-- Indexes for table `immunization_history`
--
ALTER TABLE `immunization_history`
  ADD PRIMARY KEY (`immunization_id`),
  ADD KEY `appointment_id` (`appointment_id`),
  ADD KEY `pet_id` (`pet_id`);

--
-- Indexes for table `medical_history`
--
ALTER TABLE `medical_history`
  ADD PRIMARY KEY (`medical_history_id`),
  ADD KEY `pet_id` (`pet_id`),
  ADD KEY `service_id` (`service_id`),
  ADD KEY `vet_admin_id` (`vet_admin_id`),
  ADD KEY `vet_doc_id` (`vet_doc_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `pet_owner_id` (`pet_owner_id`),
  ADD KEY `vetid` (`vetid`),
  ADD KEY `thread_id` (`thread_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `appointment_id` (`appointment_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `notification_reservation`
--
ALTER TABLE `notification_reservation`
  ADD PRIMARY KEY (`notif_reserve_id`),
  ADD KEY `notifications_reservation_ibfk_1` (`reserve_id`),
  ADD KEY `notifications_reservation_ibfk_2` (`product_id`);

--
-- Indexes for table `pets`
--
ALTER TABLE `pets`
  ADD PRIMARY KEY (`pet_id`),
  ADD KEY `pet_owner_id` (`pet_owner_id`);

--
-- Indexes for table `pet_owners`
--
ALTER TABLE `pet_owners`
  ADD PRIMARY KEY (`pet_owner_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `pet_registry_for_vet`
--
ALTER TABLE `pet_registry_for_vet`
  ADD PRIMARY KEY (`pet_registry_id`),
  ADD UNIQUE KEY `pet_id` (`pet_id`),
  ADD KEY `vet_admin_id` (`vet_admin_id`);

--
-- Indexes for table `pharmacy`
--
ALTER TABLE `pharmacy`
  ADD PRIMARY KEY (`medicine_id`),
  ADD UNIQUE KEY `med_id` (`med_id`),
  ADD KEY `vetid` (`vetid`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `vet_admin_id` (`vetid`);

--
-- Indexes for table `rate_feedback`
--
ALTER TABLE `rate_feedback`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reserve_id`),
  ADD KEY `pet_owner_id` (`pet_owner_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `vet_admin_id` (`vetid`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`),
  ADD KEY `vetid` (`vetid`);

--
-- Indexes for table `stock_in`
--
ALTER TABLE `stock_in`
  ADD PRIMARY KEY (`stock_in_id`);

--
-- Indexes for table `stock_used`
--
ALTER TABLE `stock_used`
  ADD PRIMARY KEY (`stockused_id`);

--
-- Indexes for table `system_administrator`
--
ALTER TABLE `system_administrator`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `system_logs`
--
ALTER TABLE `system_logs`
  ADD PRIMARY KEY (`logs_id`);

--
-- Indexes for table `thread`
--
ALTER TABLE `thread`
  ADD PRIMARY KEY (`thread_id`),
  ADD KEY `pet_owner_id` (`pet_owner_id`),
  ADD KEY `vet_admin_id` (`vetid`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`user_role_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `vaccination`
--
ALTER TABLE `vaccination`
  ADD PRIMARY KEY (`vaccination_id`),
  ADD KEY `pet_id` (`pet_id`),
  ADD KEY `appointment_id` (`appointment_id`),
  ADD KEY `vet_admin_id` (`vet_admin_id`);

--
-- Indexes for table `vet_clinic`
--
ALTER TABLE `vet_clinic`
  ADD PRIMARY KEY (`vet_admin_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `vetid` (`vetid`);

--
-- Indexes for table `vet_doctors`
--
ALTER TABLE `vet_doctors`
  ADD PRIMARY KEY (`vet_doc_id`),
  ADD KEY `vet_clinic_ibfk_1` (`vetid`);

--
-- Indexes for table `vet_staff`
--
ALTER TABLE `vet_staff`
  ADD PRIMARY KEY (`vet_staff_id`),
  ADD KEY `vet_admin_id` (`vetid`);

--
-- Indexes for table `visitor_monitoring`
--
ALTER TABLE `visitor_monitoring`
  ADD PRIMARY KEY (`visitor_id`),
  ADD KEY `pet_owner_id` (`pet_owner_id`),
  ADD KEY `vetid` (`vetid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT for table `consultation`
--
ALTER TABLE `consultation`
  MODIFY `consultation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_verification`
--
ALTER TABLE `email_verification`
  MODIFY `email_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `forget_password`
--
ALTER TABLE `forget_password`
  MODIFY `verify_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `immunization_history`
--
ALTER TABLE `immunization_history`
  MODIFY `immunization_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `medical_history`
--
ALTER TABLE `medical_history`
  MODIFY `medical_history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT for table `notification_reservation`
--
ALTER TABLE `notification_reservation`
  MODIFY `notif_reserve_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `pets`
--
ALTER TABLE `pets`
  MODIFY `pet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `pet_owners`
--
ALTER TABLE `pet_owners`
  MODIFY `pet_owner_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `pet_registry_for_vet`
--
ALTER TABLE `pet_registry_for_vet`
  MODIFY `pet_registry_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pharmacy`
--
ALTER TABLE `pharmacy`
  MODIFY `medicine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `rate_feedback`
--
ALTER TABLE `rate_feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `reserve_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `stock_in`
--
ALTER TABLE `stock_in`
  MODIFY `stock_in_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `stock_used`
--
ALTER TABLE `stock_used`
  MODIFY `stockused_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `system_administrator`
--
ALTER TABLE `system_administrator`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `system_logs`
--
ALTER TABLE `system_logs`
  MODIFY `logs_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=498;

--
-- AUTO_INCREMENT for table `thread`
--
ALTER TABLE `thread`
  MODIFY `thread_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_role`
--
ALTER TABLE `user_role`
  MODIFY `user_role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- AUTO_INCREMENT for table `vaccination`
--
ALTER TABLE `vaccination`
  MODIFY `vaccination_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vet_clinic`
--
ALTER TABLE `vet_clinic`
  MODIFY `vet_admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `vet_doctors`
--
ALTER TABLE `vet_doctors`
  MODIFY `vet_doc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `vet_staff`
--
ALTER TABLE `vet_staff`
  MODIFY `vet_staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `visitor_monitoring`
--
ALTER TABLE `visitor_monitoring`
  MODIFY `visitor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`vetid`) REFERENCES `vet_clinic` (`vetid`);

--
-- Constraints for table `consultation`
--
ALTER TABLE `consultation`
  ADD CONSTRAINT `consultation_ibfk_1` FOREIGN KEY (`vetid`) REFERENCES `vet_clinic` (`vetid`),
  ADD CONSTRAINT `consultation_ibfk_2` FOREIGN KEY (`vet_doc_id`) REFERENCES `vet_doctors` (`vet_doc_id`),
  ADD CONSTRAINT `consultation_ibfk_3` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`);

--
-- Constraints for table `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`vet_admin_id`) REFERENCES `vet_clinic` (`vet_admin_id`),
  ADD CONSTRAINT `history_ibfk_2` FOREIGN KEY (`pet_owner_id`) REFERENCES `pet_owners` (`pet_owner_id`);

--
-- Constraints for table `immunization_history`
--
ALTER TABLE `immunization_history`
  ADD CONSTRAINT `immunization_history_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  ADD CONSTRAINT `immunization_history_ibfk_2` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`);

--
-- Constraints for table `medical_history`
--
ALTER TABLE `medical_history`
  ADD CONSTRAINT `medical_history_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`),
  ADD CONSTRAINT `medical_history_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`),
  ADD CONSTRAINT `medical_history_ibfk_3` FOREIGN KEY (`vet_admin_id`) REFERENCES `vet_clinic` (`vet_admin_id`),
  ADD CONSTRAINT `medical_history_ibfk_4` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`),
  ADD CONSTRAINT `medical_history_ibfk_5` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`),
  ADD CONSTRAINT `medical_history_ibfk_6` FOREIGN KEY (`vet_admin_id`) REFERENCES `vet_clinic` (`vet_admin_id`),
  ADD CONSTRAINT `medical_history_ibfk_7` FOREIGN KEY (`vet_doc_id`) REFERENCES `vet_doctors` (`vet_doc_id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`pet_owner_id`) REFERENCES `pet_owners` (`pet_owner_id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`vetid`) REFERENCES `vet_clinic` (`vetid`),
  ADD CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`thread_id`) REFERENCES `thread` (`thread_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`);

--
-- Constraints for table `notification_reservation`
--
ALTER TABLE `notification_reservation`
  ADD CONSTRAINT `notifications_reservation_ibfk_1` FOREIGN KEY (`reserve_id`) REFERENCES `reservation` (`reserve_id`),
  ADD CONSTRAINT `notifications_reservation_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `pets`
--
ALTER TABLE `pets`
  ADD CONSTRAINT `pets_ibfk_1` FOREIGN KEY (`pet_owner_id`) REFERENCES `pet_owners` (`pet_owner_id`);

--
-- Constraints for table `pet_registry_for_vet`
--
ALTER TABLE `pet_registry_for_vet`
  ADD CONSTRAINT `pet_registry_for_vet_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`),
  ADD CONSTRAINT `pet_registry_for_vet_ibfk_2` FOREIGN KEY (`vet_admin_id`) REFERENCES `vet_clinic` (`vet_admin_id`);

--
-- Constraints for table `pharmacy`
--
ALTER TABLE `pharmacy`
  ADD CONSTRAINT `pharmacy_ibfk_1` FOREIGN KEY (`vetid`) REFERENCES `vet_clinic` (`vetid`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`vetid`) REFERENCES `vet_clinic` (`vetid`);

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`vetid`) REFERENCES `vet_clinic` (`vetid`);

--
-- Constraints for table `thread`
--
ALTER TABLE `thread`
  ADD CONSTRAINT `thread_ibfk_1` FOREIGN KEY (`pet_owner_id`) REFERENCES `pet_owners` (`pet_owner_id`),
  ADD CONSTRAINT `thread_ibfk_2` FOREIGN KEY (`vetid`) REFERENCES `vet_clinic` (`vetid`);

--
-- Constraints for table `vaccination`
--
ALTER TABLE `vaccination`
  ADD CONSTRAINT `vaccination_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`),
  ADD CONSTRAINT `vaccination_ibfk_2` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  ADD CONSTRAINT `vaccination_ibfk_3` FOREIGN KEY (`vet_admin_id`) REFERENCES `vet_clinic` (`vet_admin_id`);

--
-- Constraints for table `vet_doctors`
--
ALTER TABLE `vet_doctors`
  ADD CONSTRAINT `vet_doctors_ibfk_1` FOREIGN KEY (`vetid`) REFERENCES `vet_clinic` (`vetid`);

--
-- Constraints for table `vet_staff`
--
ALTER TABLE `vet_staff`
  ADD CONSTRAINT `vet_staff_ibfk_1` FOREIGN KEY (`vetid`) REFERENCES `vet_clinic` (`vetid`);

--
-- Constraints for table `visitor_monitoring`
--
ALTER TABLE `visitor_monitoring`
  ADD CONSTRAINT `visitor_monitoring_ibfk_1` FOREIGN KEY (`pet_owner_id`) REFERENCES `pet_owners` (`pet_owner_id`),
  ADD CONSTRAINT `visitor_monitoring_ibfk_2` FOREIGN KEY (`vetid`) REFERENCES `vet_clinic` (`vetid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
