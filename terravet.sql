-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 28, 2021 at 09:36 AM
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
(21, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 18, '10:00 AM - 11:00 AM', '2021-08-16', 18, 'Decline', '2021-08-16 19:17:56', '0000-00-00 00:00:00'),
(22, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 19, '10:00 AM - 11:00 AM', '2021-08-19', 18, 'Done', '2021-09-24 08:48:41', '0000-00-00 00:00:00'),
(23, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 19, '01:00 PM - 02:00 PM', '2021-08-21', 19, 'Done', '2021-09-24 08:39:39', '0000-00-00 00:00:00'),
(24, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 19, '12:00 pm - 1:00 PM', '2021-08-22', 20, 'Done', '2021-09-24 09:23:10', '0000-00-00 00:00:00'),
(25, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '10:00 AM - 11:00 AM', '2021-10-02', 2, 'Decline', '2021-10-07 19:50:19', '0000-00-00 00:00:00'),
(26, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '03:00 PM - 04:00 PM', '2021-10-22', 2, 'Expired', '2021-10-24 06:01:15', '2021-10-24 14:01:15'),
(27, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 24, '10:00 AM - 11:00 AM', '2021-10-08', 8, 'Done', '2021-10-08 20:54:06', '0000-00-00 00:00:00'),
(28, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '08:00 AM - 09:00 AM', '2021-10-08', 8, 'Done', '2021-10-07 19:50:35', '0000-00-00 00:00:00'),
(29, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 24, '08:00 AM - 09:00 AM', '2021-10-08', 8, 'Done', '2021-10-08 20:55:47', '0000-00-00 00:00:00'),
(30, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 18, '04:00 PM - 05:00 PM', '2021-10-08', 2, 'Decline', '2021-10-07 19:41:42', '0000-00-00 00:00:00'),
(31, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 21, '04:00 PM - 05:00 PM', '2021-10-08', 8, 'Done', '2021-10-08 20:57:39', '0000-00-00 00:00:00'),
(32, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '04:00 PM - 05:00 PM', '2021-10-10', 3, 'Done', '2021-10-09 16:47:49', '0000-00-00 00:00:00'),
(33, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '12:00 PM - 01:00 PM', '2021-10-16', 4, 'Done', '2021-10-24 01:22:03', '0000-00-00 00:00:00'),
(34, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '12:00 PM - 01:00 PM', '2021-10-16', 4, 'Approved', '2021-10-21 22:15:07', '0000-00-00 00:00:00'),
(35, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '12:00 PM - 01:00 PM', '2021-10-14', 2, 'Decline', '2021-10-08 21:08:31', '0000-00-00 00:00:00'),
(36, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '01:00 PM - 02:00 PM', '2021-10-18', 4, 'Expired', '2021-10-24 06:01:15', '2021-10-24 14:01:15'),
(37, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '01:00 PM - 02:00 PM', '2021-10-27', 6, 'Decline', '2021-10-24 06:19:30', '0000-00-00 00:00:00'),
(38, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 24, '12:00 PM - 01:00 PM', '2021-10-19', 6, 'Expired', '2021-10-24 06:01:15', '2021-10-24 14:01:15'),
(39, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 21, '02:00 PM - 03:00 PM', '2021-10-20', 8, 'Expired', '2021-10-24 06:01:15', '2021-10-24 14:01:15'),
(40, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '02:00 PM - 03:00 PM', '2021-10-28', 4, 'Pending', '2021-10-07 19:20:16', '0000-00-00 00:00:00'),
(41, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '02:00 PM - 03:00 PM', '2021-10-28', 4, 'Decline', '2021-10-24 06:18:06', '0000-00-00 00:00:00'),
(42, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '02:00 PM - 03:00 PM', '2021-10-28', 4, 'Decline', '2021-10-24 06:18:20', '0000-00-00 00:00:00'),
(43, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '02:00 PM - 03:00 PM', '2021-10-28', 4, 'Decline', '2021-10-24 06:17:45', '0000-00-00 00:00:00'),
(44, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '02:00 PM - 03:00 PM', '2021-10-28', 4, 'Decline', '2021-10-24 06:16:25', '0000-00-00 00:00:00'),
(45, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 21, '12:00 PM - 01:00 PM', '2021-10-21', 4, 'Expired', '2021-10-24 06:03:44', '2021-10-24 14:03:44'),
(46, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 21, '12:00 PM - 01:00 PM', '2021-10-18', 4, 'Expired', '2021-10-24 06:01:15', '2021-10-24 14:01:15'),
(47, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 21, '12:00 PM - 01:00 PM', '2021-10-21', 3, 'Expired', '2021-10-24 06:01:15', '2021-10-24 14:01:15'),
(48, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '02:00 PM - 03:00 PM', '2021-11-01', 3, 'Pending', '2021-10-07 19:27:09', '0000-00-00 00:00:00'),
(49, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 24, '04:00 PM - 05:00 PM', '2021-10-09', 2, 'Done', '2021-10-08 21:03:52', '0000-00-00 00:00:00'),
(50, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 24, '03:00 PM - 04:00 PM', '2021-11-30', 3, 'Pending', '2021-10-08 20:45:41', '0000-00-00 00:00:00'),
(51, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 24, '03:00 PM - 04:00 PM', '2021-11-30', 3, 'Pending', '2021-10-08 20:45:42', '0000-00-00 00:00:00'),
(52, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '08:00 AM - 09:00 AM', '2021-10-10', 2, 'Done', '2021-10-09 16:47:45', '0000-00-00 00:00:00'),
(53, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 19, '12:00 PM - 01:00 PM', '2021-10-22', 2, 'Expired', '2021-10-24 06:01:15', '2021-10-24 14:01:15'),
(54, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 21, '01:00 PM - 02:00 PM', '2021-10-27', 8, 'Approved', '2021-10-24 06:19:14', '0000-00-00 00:00:00'),
(55, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 24, '11:00 AM - 12:00 PM', '2021-11-02', 24, 'Done', '2021-10-24 05:42:04', '0000-00-00 00:00:00'),
(56, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 23, '03:00 PM - 04:00 PM', '2021-10-24', 24, 'Expired', '2021-10-25 12:57:07', '2021-10-25 20:57:07'),
(57, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 21, '04:00 PM - 05:00 PM', '2021-10-24', 31, 'Done', '2021-10-24 07:26:15', '0000-00-00 00:00:00'),
(58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 19, '04:00 PM - 05:00 PM', '2021-10-24', 31, 'Approved', '2021-10-24 07:51:13', '0000-00-00 00:00:00'),
(59, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 75, 23, '03:00 PM - 04:00 PM', '2021-10-24', 3, 'Expired', '2021-10-24 16:12:33', '2021-10-25 00:12:33'),
(60, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '03:00 PM - 04:00 PM', '2021-10-24', 8, 'Expired', '2021-10-24 16:12:33', '2021-10-25 00:12:33'),
(61, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '01:00 PM - 02:00 PM', '2021-10-26', 4, 'Expired', '2021-10-26 16:04:33', '2021-10-27 00:04:33'),
(62, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 21, '01:00 PM - 02:00 PM', '2021-10-26', 3, 'Expired', '2021-10-26 16:04:33', '2021-10-27 00:04:33'),
(63, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '02:00 PM - 03:00 PM', '2021-10-26', 4, 'Expired', '2021-10-26 16:04:33', '2021-10-27 00:04:33'),
(64, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-10-27', 3, 'Pending', '2021-10-24 13:56:43', '0000-00-00 00:00:00'),
(65, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-10-26', 2, 'Expired', '2021-10-26 16:04:33', '2021-10-27 00:04:33'),
(66, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '02:00 PM - 03:00 PM', '2021-10-27', 3, 'Pending', '2021-10-24 13:59:03', '0000-00-00 00:00:00'),
(67, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 19, '02:00 PM - 03:00 PM', '2021-10-28', 4, 'Pending', '2021-10-24 14:00:19', '0000-00-00 00:00:00'),
(68, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '02:00 PM - 03:00 PM', '2021-10-28', 4, 'Pending', '2021-10-24 14:01:29', '0000-00-00 00:00:00'),
(69, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-11-02', 4, 'Pending', '2021-10-24 14:04:20', '0000-00-00 00:00:00'),
(70, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-11-02', 4, 'Pending', '2021-10-24 14:04:25', '0000-00-00 00:00:00'),
(71, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-11-02', 4, 'Pending', '2021-10-24 14:16:12', '0000-00-00 00:00:00'),
(72, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-11-02', 4, 'Pending', '2021-10-24 14:16:14', '0000-00-00 00:00:00'),
(73, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-11-02', 4, 'Pending', '2021-10-24 14:16:14', '0000-00-00 00:00:00'),
(74, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-11-02', 4, 'Pending', '2021-10-24 14:16:14', '0000-00-00 00:00:00'),
(75, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-11-02', 4, 'Pending', '2021-10-24 14:16:14', '0000-00-00 00:00:00'),
(76, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-11-02', 4, 'Pending', '2021-10-24 14:16:15', '0000-00-00 00:00:00'),
(77, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-11-02', 4, 'Pending', '2021-10-24 14:16:15', '0000-00-00 00:00:00'),
(78, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-11-02', 4, 'Pending', '2021-10-24 14:16:15', '0000-00-00 00:00:00'),
(79, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-11-02', 4, 'Pending', '2021-10-24 14:16:15', '0000-00-00 00:00:00'),
(80, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '03:00 PM - 04:00 PM', '2021-10-28', 3, 'Pending', '2021-10-24 14:17:52', '0000-00-00 00:00:00'),
(81, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '01:00 PM - 02:00 PM', '2021-10-26', 4, 'Expired', '2021-10-26 16:04:33', '2021-10-27 00:04:33'),
(82, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '02:00 PM - 03:00 PM', '2021-10-27', 4, 'Pending', '2021-10-24 14:20:10', '0000-00-00 00:00:00'),
(83, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '01:00 PM - 02:00 PM', '2021-10-25', 3, 'Expired', '2021-10-26 16:04:33', '2021-10-27 00:04:33'),
(84, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-10-28', 4, 'Pending', '2021-10-24 14:24:22', '0000-00-00 00:00:00'),
(85, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '03:00 PM - 04:00 PM', '2021-10-28', 4, 'Pending', '2021-10-24 14:27:01', '0000-00-00 00:00:00'),
(86, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 21, '01:00 PM - 02:00 PM', '2021-10-27', 3, 'Pending', '2021-10-24 14:30:35', '0000-00-00 00:00:00'),
(87, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '01:00 PM - 02:00 PM', '2021-10-27', 4, 'Pending', '2021-10-24 14:35:07', '0000-00-00 00:00:00'),
(88, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '03:00 PM - 04:00 PM', '2021-10-30', 4, 'Pending', '2021-10-24 14:37:25', '0000-00-00 00:00:00'),
(89, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 21, '02:00 PM - 03:00 PM', '2021-10-25', 3, 'Expired', '2021-10-26 16:04:33', '2021-10-27 00:04:33'),
(90, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 21, '02:00 PM - 03:00 PM', '2021-11-04', 3, 'Pending', '2021-10-24 14:47:43', '0000-00-00 00:00:00'),
(91, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 21, '12:00 PM - 01:00 PM', '2021-10-27', 31, 'Pending', '2021-10-24 14:48:48', '0000-00-00 00:00:00'),
(92, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 19, '02:00 PM - 03:00 PM', '2021-11-06', 4, 'Pending', '2021-10-24 14:51:15', '0000-00-00 00:00:00'),
(93, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 18, '03:00 PM - 04:00 PM', '2021-11-03', 3, 'Pending', '2021-10-24 15:00:53', '0000-00-00 00:00:00'),
(94, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 21, '01:00 PM - 02:00 PM', '2021-11-04', 4, 'Pending', '2021-10-24 15:02:23', '0000-00-00 00:00:00'),
(95, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-11-06', 4, 'Pending', '2021-10-24 15:06:01', '0000-00-00 00:00:00'),
(96, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '01:00 PM - 02:00 PM', '2021-10-26', 3, 'Expired', '2021-10-26 16:04:33', '2021-10-27 00:04:33'),
(97, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '02:00 PM - 03:00 PM', '2021-10-28', 3, 'Pending', '2021-10-24 15:34:27', '0000-00-00 00:00:00'),
(98, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '03:00 PM - 04:00 PM', '2021-10-28', 4, 'Pending', '2021-10-24 15:38:24', '0000-00-00 00:00:00'),
(99, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '02:00 PM - 03:00 PM', '2021-10-28', 4, 'Pending', '2021-10-24 15:39:58', '0000-00-00 00:00:00'),
(100, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '02:00 PM - 03:00 PM', '2021-10-28', 3, 'Pending', '2021-10-24 15:42:13', '0000-00-00 00:00:00'),
(101, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-11-02', 31, 'Pending', '2021-10-24 15:44:34', '0000-00-00 00:00:00'),
(102, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '02:00 PM - 03:00 PM', '2021-11-03', 2, 'Pending', '2021-10-24 15:45:47', '0000-00-00 00:00:00'),
(103, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 23, '03:00 PM - 04:00 PM', '2021-10-25', 31, 'Expired', '2021-10-26 16:04:33', '2021-10-27 00:04:33'),
(104, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 24, '02:00 PM - 03:00 PM', '2021-10-26', 3, 'Expired', '2021-10-26 16:04:33', '2021-10-27 00:04:33'),
(105, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 18, '02:00 PM - 03:00 PM', '2021-10-30', 2, 'Pending', '2021-10-24 15:49:57', '0000-00-00 00:00:00'),
(106, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '02:00 PM - 03:00 PM', '2021-10-27', 8, 'Pending', '2021-10-24 15:52:49', '0000-00-00 00:00:00'),
(107, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 58, 22, '03:00 PM - 04:00 PM', '2021-10-26', 3, 'Expired', '2021-10-26 16:04:33', '2021-10-27 00:04:33'),
(108, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 19, '01:00 PM - 02:00 PM', '2021-10-25', 18, 'Approved', '2021-10-25 12:59:53', '0000-00-00 00:00:00'),
(109, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 23, '02:00 PM - 03:00 PM', '2021-10-27', 18, 'Expired', '2021-10-27 18:28:26', '2021-10-28 02:28:26'),
(110, '$2b$10$Mb3CCA1C9F1UMR0FIc3LAujtXoUuVQiAIoZJ28ILLZsf9byONGZ3i', 58, 18, '01:00 PM - 02:00 PM', '2021-10-27', 32, 'Done', '2021-10-25 13:58:16', '0000-00-00 00:00:00'),
(111, '$2b$10$Mb3CCA1C9F1UMR0FIc3LAujtXoUuVQiAIoZJ28ILLZsf9byONGZ3i', 58, 24, '03:00 PM - 04:00 PM', '2021-11-06', 32, 'Cancelled', '2021-10-26 18:39:48', '0000-00-00 00:00:00'),
(112, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 58, 22, '02:00 PM - 03:00 PM', '2021-10-27', 18, 'Expired', '2021-10-27 18:28:26', '2021-10-28 02:28:26');

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
(38, '09739399234', '7813', '2021-10-22 20:23:50');

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
  `appointment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `immunization_history`
--

INSERT INTO `immunization_history` (`immunization_id`, `pet_id`, `pet_weight`, `date`, `vaccine_name`, `againts`, `vaccine_number`, `manufacturer`, `appointment_id`) VALUES
(4, 19, 10, '2021-10-24 07:10:08', 'Sample', 'Anti-rABIES', '12123232323', 'Sample', 22),
(5, 19, 12, '2021-10-24 07:10:12', 'DHCP', 'Anti-Distemper', '121314414', 'ashgdahsvdjavdasdasda', 24),
(7, 21, 10, '2021-10-24 07:26:15', 'Sinovac', 'Anti Rabies', '106871598', 'China', 57),
(8, 18, 20, '2021-10-25 13:58:16', 'Anti rabies', 'rabies', '0934342', 'rabies', 110);

-- --------------------------------------------------------

--
-- Table structure for table `medical_history`
--

CREATE TABLE `medical_history` (
  `medical_history_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `pet_name` varchar(50) NOT NULL,
  `Date` date NOT NULL,
  `Service_Type` varchar(100) NOT NULL,
  `vet_admin_id` int(11) NOT NULL,
  `vet_name` varchar(100) NOT NULL,
  `tests_performed` varchar(150) NOT NULL,
  `test_result` varchar(100) NOT NULL,
  `recommendation` varchar(300) NOT NULL,
  `medication` varchar(300) NOT NULL,
  `remarks` varchar(300) NOT NULL
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

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`message_id`, `thread_id`, `pet_owner_id`, `vetid`, `user_message`, `created_time_date`, `message_content`) VALUES
(1, 1, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, '2021-08-30 19:00:00', 'asdasdasdasdsda'),
(2, 1, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, '2021-08-31 16:00:00', 'asdasdasdasdasdasdasdasd'),
(3, 1, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, '2021-09-18 03:34:24', 'Hello'),
(4, 1, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, '2021-09-18 03:35:02', 'Hiiii'),
(7, 2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, '2021-09-23 17:52:38', 'POOOOOO'),
(8, 2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, '2021-09-23 17:52:38', 'LOOOOO'),
(9, 2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 2, '2021-10-10 15:29:00', 'hello'),
(10, 1, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, '2021-10-15 02:16:23', 'Hello'),
(11, 1, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, '2021-10-15 02:16:30', 'Kumain ka na ba?'),
(12, 2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 1, '2021-10-19 04:04:36', 'Welcome'),
(13, 2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 2, '2021-10-19 04:04:47', 'No problem'),
(14, 2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 2, '2021-10-19 04:05:00', 'Naoil mabilis magreply'),
(15, 2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 1, '2021-10-19 04:05:10', 'Sa simula lang yan'),
(16, 2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 1, '2021-10-24 01:31:45', 'Are you available today?'),
(17, 2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 2, '2021-10-24 01:33:04', 'Yes, we are available'),
(18, 2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 2, '2021-10-24 01:33:23', 'How can I help you?'),
(19, 1, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, '2021-10-25 12:48:18', 'Video call room number is 43346343. \n Instruction: Click the video conference button located in the upper right corner of your screen, enter the room number to start video call. Thankyou!'),
(20, 2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 2, '2021-10-25 14:07:10', 'heloo'),
(21, 2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 1, '2021-10-25 14:08:03', 'huiii'),
(22, 2, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 2, '2021-10-25 14:08:49', 'Video call room number is 84726076. \n Instruction: Click the video conference button located in the upper right corner of your screen, enter the room number to start video call. Thankyou!'),
(23, 3, 58, '$2b$10$Mb3CCA1C9F1UMR0FIc3LAujtXoUuVQiAIoZJ28ILLZsf9byONGZ3i', 1, '2021-10-25 14:13:45', 'hello'),
(24, 3, 58, '$2b$10$Mb3CCA1C9F1UMR0FIc3LAujtXoUuVQiAIoZJ28ILLZsf9byONGZ3i', 1, '2021-10-25 14:13:48', 'heloo');

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
  `isViewed` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `appointment_id`, `service_id`, `status`, `date_time_created`, `isViewed`) VALUES
(60, 112, 18, 'Pending', '2021-10-27 18:00:48', 1);

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
  `isViewed` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notification_reservation`
--

INSERT INTO `notification_reservation` (`notif_reserve_id`, `reserve_id`, `product_id`, `status`, `date_time_created`, `isViewed`) VALUES
(2, 68, '30375976', 'Reserved', '2021-10-27 15:52:52', 1),
(3, 70, '30375976', 'Reserved', '2021-10-27 15:58:10', 1),
(4, 71, '3006381', 'Reserved', '2021-10-27 15:59:04', 1),
(5, 69, '30375976', 'Cancelled', '2021-10-27 16:15:19', 1),
(6, 73, '28528578', 'Cancelled', '2021-10-27 16:15:42', 1),
(7, 73, '30375976', 'Reserved', '2021-10-27 16:35:42', 1),
(8, 74, '30375976', 'Purchased', '2021-10-27 16:35:59', 1),
(10, 79, '3006381', 'Purchased', '2021-10-27 21:39:53', 1),
(11, 76, '30375976', 'Purchased', '2021-10-27 21:39:55', 1),
(12, 77, '30375976', 'Purchased', '2021-10-27 21:39:58', 1),
(13, 78, '30375976', 'Purchased', '2021-10-27 21:40:00', 1),
(14, 80, '3006381', 'Cancelled', '2021-10-27 21:49:10', 0),
(15, 81, '3006381', 'Cancelled', '2021-10-27 21:51:22', 0),
(16, 82, '3006381', 'Cancelled', '2021-10-27 22:06:23', 0),
(17, 83, '30375976', 'Cancelled', '2021-10-27 22:06:27', 0),
(18, 87, '8926439', 'Reserved', '2021-10-27 22:11:21', 0),
(19, 84, '30375976', 'Cancelled', '2021-10-27 22:15:29', 0),
(20, 85, '3006381', 'Cancelled', '2021-10-27 22:15:32', 0),
(21, 87, '3006381', 'Cancelled', '2021-10-27 22:15:34', 0),
(22, 86, '30375976', 'Cancelled', '2021-10-27 22:15:36', 0),
(23, 88, '8926439', 'Cancelled', '2021-10-27 22:15:39', 0),
(24, 89, '28528578', 'Cancelled', '2021-10-27 22:15:42', 0),
(25, 89, '30375976', 'Reserved', '2021-10-27 22:15:53', 0),
(26, 91, '30375976', 'Reserved', '2021-10-27 22:15:56', 0),
(27, 91, '8926439', 'Reserved', '2021-10-27 22:16:51', 0),
(28, 92, '30375976', 'Reserved', '2021-10-27 22:18:05', 0),
(29, 93, '8926439', 'Reserved', '2021-10-27 22:19:49', 0),
(30, 94, '30375976', 'Reserved', '2021-10-27 22:20:44', 0),
(31, 95, '30375976', 'Reserved', '2021-10-27 22:21:13', 0),
(32, 96, '8926439', 'Reserved', '2021-10-27 22:21:38', 0),
(33, 97, '30375976', 'Reserved', '2021-10-28 06:46:47', 0);

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
(20, 75, 'John Carlos Llaneta', 'Sam', 'Cat', 'Persian Cat', 'Female', '2019-06-07', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/res.jpg?alt=media&token=048b0b97-0eb5-458a-b761-3a319de2e638', 0),
(21, 58, 'Jhaycee Llaneta', 'Yoda', 'Dog', 'Aspin', 'Male', '2021-05-05', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/elisa-kennemer-0TdrHK0po7I-unsplash.jpg?alt=media&token=0a0d77b3-0d86-44a4-83ea-60168c25bde5', 0),
(22, 58, 'Jhaycee Llaneta', 'Chardeeiii', 'Dog', 'Corgi', 'Male', '2020-12-12', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/International-Corgi-Day-1.jpg?alt=media&token=1f250eb9-25d5-4354-8999-7a6f2a83ea71', 0),
(23, 58, 'Jhaycee Llaneta', 'Togon', 'Dog', 'Aspin', 'Female', '2021-09-16', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/International-Corgi-Day-1.jpg?alt=media&token=6ecaa530-8479-4ab2-9867-2d3b4d20861e', 0),
(24, 58, 'Jhaycee Llaneta', 'Max', 'Dog', 'Corgi', 'Male', '2021-09-06', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/International-Corgi-Day-1.jpg?alt=media&token=e87f827e-3e68-4b90-b0e9-1affd2deae3b', 0),
(28, 76, 'Jimuel Mercado', 'Buddy', 'Dog', 'Bulldog', 'Male', '2021-06-21', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/jim1.jfif?alt=media&token=dcd83a21-394a-4d06-be3b-1c7d285e302c', 0),
(29, 76, 'Jimuel Mercado', 'Archie', 'Dog', 'Shih Tzu', 'Female', '2021-09-13', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/jim2.jfif?alt=media&token=1ee7dda3-0863-471e-8958-02a542f49df1', 0),
(30, 76, 'Jimuel Mercado', ' Oscar', 'Dog', 'Labrador', 'Male', '2021-09-10', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/jim3.jfif?alt=media&token=4aecd36d-d7f8-41d0-96bc-4223af9fe452', 0),
(31, 77, 'Richard Sasis', 'Mina', 'Cat', 'Scottish Fold', 'Female', '2021-05-02', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/chard1.jfif?alt=media&token=8ba6e14b-fd70-4a4d-9dec-cf41ab2d02aa', 0),
(33, 77, 'Richard Sasis', 'Charlie', 'Dog', 'Beagle', 'Male', '2020-12-12', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/chard2.jpg?alt=media&token=01bae7ba-7d5f-43a3-8841-f742c7b0f129', 0),
(34, 77, 'Richard Sasis', 'Chardei', 'Dog', 'Corgi', 'Male', '2021-02-16', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/corgi3.jfif?alt=media&token=03cd1e0c-e495-4249-aea3-a307d1cf9d99', 0),
(36, 78, 'Carmella Joy Guelas', 'Teddy', 'Dog', 'Bulldog', 'Male', '2021-03-30', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/jim1.jfif?alt=media&token=80e825eb-c026-4ec9-af16-09dbb205f67b', 0),
(37, 78, 'Carmella Joy Guelas', 'Alfie', 'Dog', 'Corgi', 'Female', '2020-07-21', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/corgi1.jpg?alt=media&token=7c5c194f-5bc9-4c6c-ae67-8349357f7c4e', 0),
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
  `created_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pet_owners`
--

INSERT INTO `pet_owners` (`pet_owner_id`, `email`, `password`, `name`, `address`, `contact_number`, `profilePicture`, `isArchived`, `created_date`) VALUES
(58, 'john040717@gmail.com', '$2b$10$zxbmiHBi0suCVcCycR0VdOtZdu6qHCj4LYq9hGn6a85QFTKvtmMi6', 'Jhaycee Llaneta', 'Tondo, Manila', '09558264299', 'http://localhost:3001/profile/petowner/profile_petowner_1621987617668.jpg', 0, '2021-06-02 18:53:08'),
(75, 'johnllaneta05@gmail.com', '$2b$10$sHzWHZBm9Sfg4TcQqs4H/edHSMcgs77eBcvt/VgLLIc752M.oeuPW', 'John Carlos Llaneta', '', '09081052103', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/1IMG_20210709_083300.jpg?alt=media&token=34e0e607-e549-424e-90fc-c09b2fd800e2', 0, '2021-08-07 03:36:53'),
(76, 'jimuel78@gmail.com', '$2b$10$ftTcuaqcRQXUL2Zo5OJgru17f5PFeTXXiK6KKlndKJzSPoWt8scBe', 'Jimuel Mercado', '', '09873627372', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/jimuel.jpg?alt=media&token=d1767f25-8cfa-4b84-83c7-d03ff8f92832', 1, '2021-09-30 00:33:26'),
(77, 'richard12@gmail.com', '$2b$10$eElK2PuOplQkkQCR3lHgROZr.pK9sjOEgB7qVIoZvs7sE4CzJV8T6', 'Richard Sasis', '', '09354555893', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/richard.jpg?alt=media&token=8981c0e4-fee4-4e82-aede-fd90783db9db', 0, '2021-09-30 00:41:55'),
(78, 'carmella08@gmail.com', '$2b$10$FV6o6EL6T5H1RmHuvP0Q2OXdnWREGg8vjy2n8dEZbGCujAQ8TKAwS', 'Carmella Joy Guelas', '', '09364792733', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/carmella.jpg?alt=media&token=feff4ba1-4c98-4589-9aee-10219f59f5c7', 0, '2021-09-30 00:45:08'),
(82, 'carl@gmail.com', '$2b$10$2dAbtv4S3PL3xPUON7ZVT.YWSq3SHUf6KYIMjufe3VjEhX/2H3J7m', 'Carl Maritana', '1123 Cavite Street,Tondo, Manila', '09473857842', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/carm1.jfif?alt=media&token=fa31314b-05ee-4c0e-a832-394dcca600f4', 0, '2021-10-05 14:22:35'),
(83, 'johnpenazo@gmail.com', '$2b$10$l15chJ9ByIE1Is8MVm1UHuulhYPQxnKpfnSsK.0ZURBRoyHll0IR.', 'John Penazo', '1601 varona street,tondo manila', '09072069351', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/21369213_1609700262438143_6979360524817941722_n.jpg?alt=media&token=ede1ed8b-3adb-4529-ae3e-f6be9de7db8d', 0, '2021-10-21 02:56:20'),
(85, 'janella02@gmail.com', '$2b$10$3BIwgv35SWPvgWK2SQplaupsP1XoOlQ1cGdS9QdnSUHLTuQ9cgrKm', 'janella', '004 Sabino Alley, Maysan,Valenzuela City', '09389302032', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/johna.jpg?alt=media&token=245439a6-270d-4cce-a5af-004a69cd22e7', 0, '2021-10-22 10:18:40'),
(87, 'clarisa098@gmail.com', '$2b$10$3YMHkHcbBFWRNUlbrH..uuUf4e7BfYeHXhkHy5zOE20aThZYfc0g2', 'clarisa', '008 legarda,Quezon', '09789473999', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/carmella.jpg?alt=media&token=fca46a43-afaa-45d9-a445-a9ab394fb17c', 0, '2021-10-22 21:12:33'),
(88, 'alord10@gmail.com', '$2b$10$F6q.tDGOzfklf5M48x6smeOJsCNCs/NeSbTp9HEAUY8JG53Mgio/2', 'alord', '008 legarda,Quezon', '09776645454', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/carmella.jpg?alt=media&token=ecc47f74-66b9-4d37-8ae6-ec8eb7b05399', 0, '2021-10-22 21:34:30'),
(89, 'justin24@gmail.com', '$2b$10$9KJBOotE7mAqOo8ZLK6A0Ojf/8Ysr4bZBIz/Ikao1rjrzmJmCdgWW', 'justin', '008 legarda,Quezon', '09487593899', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/chard1.jfif?alt=media&token=2129cedf-ce65-4e72-ab46-16492a78ac01', 0, '2021-10-22 21:38:30');

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
  `med_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pharmacy`
--

INSERT INTO `pharmacy` (`medicine_id`, `medicine_name`, `medicine_description`, `status`, `price`, `vetid`, `medicine_image`, `med_id`) VALUES
(14, 'Heartgard (ivermectin/pyrantel)', 'Heartgard (ivermectin/pyrantel)\nFor Dogs 51 - 100 lbs\n6 Chewables', 1, 260, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Web%20capture_15-6-2021_234216_www.1800petmeds.com.jpeg?alt=media&token=8a5ed239-5445-4f11-b22d-565e97f62890', '93697429'),
(16, 'MONDEX WATER SOLUBLE POWDER 100G ENERGY SUPPLEMENT', 'Contains 99.9% glucose monohydrate U.S.P. grade\nFast absorbed from the digestive tract to provide instant energy', 1, 95, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/mondex-water-soluble-powder-100g-energy-supplement.jpg?alt=media&token=e7b5821c-a934-48dc-84e2-bfb012d09327', '92162827'),
(17, 'Rabisin', 'Rabisin description', 1, 250, '$2b$10$Mb3CCA1C9F1UMR0FIc3LAujtXoUuVQiAIoZJ28ILLZsf9byONGZ3i', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/download.jfif?alt=media&token=3f698df9-fc17-4674-94eb-7bf564029c65', '94702417');

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
('22022844', 'Pedigree', 'pedigree desc', '$2b$10$Mb3CCA1C9F1UMR0FIc3LAujtXoUuVQiAIoZJ28ILLZsf9byONGZ3i', 18, 300, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/91Kucfnn5KL._AC_SX522_.jpg?alt=media&token=bc8ff792-b7cf-4cf4-bf54-4675f1e9b7c3', 'Food', 'Dogs'),
('28528578', 'ZEE.DOG BLACK POOP BAG DISPENSER', 'Comes with 1 poop bag roll\nEasy to attach to the leash, does not bounce and bother while walking\nReflective rope with custom design\nHolds Zee.Dog poop-bags rolls, bags never jam\nEasy screw system for bag replacement', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 44, 350, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Web%20capture_20-8-2021_32238_www.petwarehouse.ph.jpeg?alt=media&token=7c33dd90-5caa-443d-a0d2-e1553e116765', 'Accessories', 'Dogs'),
('3006381', 'Royal Canin', 'Cat food for cats', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 140, 450, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Web%20capture_15-6-2021_221343_www.petwarehouse.ph.jpeg?alt=media&token=9eed0363-96ad-4512-8453-d38e11614cc4', 'Food', 'Cat'),
('30375976', 'Fancy Feast (Classic Pate)', 'Cat food that taste good', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 90, 350, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Web%20capture_15-6-2021_225219_www.petwarehouse.ph.jpeg?alt=media&token=88d85381-c5f2-45a0-8a23-e8f8d469fc7b', 'Food', 'Cat'),
('8926439', 'WEST PAW QWIZL DOG CHEW TOY', 'MADE IN THE USA\nBUILT FOR TOUGH CHEWERS\nMade with Zogoflex® material, non-toxic and dishwasher safe (top rack)\nPuzzle toy helps stimulate dogs’ brains to support healthy growth\nExtends life of spendy treats\n', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 195, 1095, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/west-paw-qwizl-dog-chew-toy.jpg?alt=media&token=1d955463-914d-4002-9432-ddad32612cd8', 'Toys', 'Dogs');

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
(68, 8926439, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, 'Expired', '2021-10-27 23:42:25', '2021-10-28 00:18:29'),
(69, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, 'Expired', '2021-10-27 23:52:52', '2021-10-28 00:18:29'),
(70, 8926439, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, 'Expired', '2021-10-27 23:57:24', '2021-10-28 00:18:29'),
(71, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 3, 'Expired', '2021-10-27 23:58:10', '2021-10-28 00:18:29'),
(72, 3006381, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, 'Expired', '2021-10-27 23:59:04', '2021-10-28 00:18:29'),
(73, 28528578, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, 'Expired', '2021-10-27 23:59:31', '2021-10-28 00:18:29'),
(74, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, 'Done', '2021-10-28 00:35:42', '2021-10-28 00:35:59'),
(76, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, 'Done', '2021-10-28 05:32:25', '2021-10-28 05:39:55'),
(77, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, 'Done', '2021-10-28 05:34:31', '2021-10-28 05:39:57'),
(78, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, 'Done', '2021-10-28 05:35:39', '2021-10-28 05:39:59'),
(79, 3006381, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 5, 'Done', '2021-10-28 05:38:44', '2021-10-28 05:39:52'),
(80, 3006381, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, 'Cancelled', '2021-10-28 05:42:17', '0000-00-00 00:00:00'),
(81, 3006381, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 10, 'Cancelled', '2021-10-28 05:50:32', '0000-00-00 00:00:00'),
(82, 3006381, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 4, 'Cancelled', '2021-10-28 05:58:34', '0000-00-00 00:00:00'),
(83, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 3, 'Cancelled', '2021-10-28 05:58:34', '0000-00-00 00:00:00'),
(84, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 3, 'Cancelled', '2021-10-28 06:06:53', '0000-00-00 00:00:00'),
(85, 3006381, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 3, 'Cancelled', '2021-10-28 06:08:55', '0000-00-00 00:00:00'),
(86, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 3, 'Cancelled', '2021-10-28 06:10:57', '0000-00-00 00:00:00'),
(87, 3006381, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 3, 'Cancelled', '2021-10-28 06:10:57', '0000-00-00 00:00:00'),
(88, 8926439, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 4, 'Cancelled', '2021-10-28 06:11:21', '0000-00-00 00:00:00'),
(89, 28528578, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 3, 'Cancelled', '2021-10-28 06:12:07', '0000-00-00 00:00:00'),
(90, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 3, 'Pending', '2021-10-28 06:15:53', '0000-00-00 00:00:00'),
(91, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 3, 'Pending', '2021-10-28 06:15:56', '0000-00-00 00:00:00'),
(92, 8926439, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, 'Pending', '2021-10-28 06:16:51', '0000-00-00 00:00:00'),
(93, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, 'Pending', '2021-10-28 06:18:05', '0000-00-00 00:00:00'),
(94, 8926439, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, 'Pending', '2021-10-28 06:19:49', '0000-00-00 00:00:00'),
(95, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, 'Pending', '2021-10-28 06:20:44', '0000-00-00 00:00:00'),
(96, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, 'Pending', '2021-10-28 06:21:13', '0000-00-00 00:00:00'),
(97, 8926439, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, 'Pending', '2021-10-28 06:21:38', '0000-00-00 00:00:00'),
(98, 30375976, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, 'Pending', '2021-10-28 14:46:47', '0000-00-00 00:00:00');

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
(6, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 3006381, '2021-10-23 00:57:37', 50);

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
(2, 0, '28528578', '2021-10-22 21:24:53', 2);

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
  `isArchived` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `system_administrator`
--

INSERT INTO `system_administrator` (`admin_id`, `email`, `password`, `name`, `profilePicture`, `phone_number`, `isArchived`) VALUES
(1, 'admin@gmail.com', '$2b$10$qrfPll4/KDZU1PLePJVKRuQrM7K5sHuPXbKb8Mz3vk8ae2EGNd.n.', 'kingchardddffff', 'http://localhost:3001/profile/petowner/profile_petowner_1621552793508.jpg', '', 0),
(2, 'walton@gmail.com', '$2b$10$8uBWLrC4T02lDLv5ACFBteT2YROk02xygz56aDGOuwgoP8hdf7KDS', 'Luke walton', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/21369213_1609700262438143_6979360524817941722_n.jpg?alt=media&token=371a4a3b-3458-4150-a269-a676e4727a4a', '09308161836', 0),
(3, 'smith@gmail.com', '$2b$10$3f/ePFXnqGmV2bDB6VmA1.Rl9/KwdYF5ERBULZGtQvXVDRR9nZy4y', 'Sam Smith', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/21369213_1609700262438143_6979360524817941722_n.jpg?alt=media&token=6a96b25a-1d89-483a-ac73-88c11d65b12c', '09302658794', 0),
(4, 'samsmith@gmail.com', '$2b$10$5yJtwwsQfE4dOZEtWoy.NOTkQwxH7nZF4bGKKXc2XKvaJaXS72tTW', 'Sam Smith', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/21369213_1609700262438143_6979360524817941722_n.jpg?alt=media&token=ddbbc98a-725f-4308-9dae-7f4120ecb903', '09558264289', 0),
(7, 'jocylyn14@gmail.com', '$2b$10$j/lRyGsPkyEYaqdubLxUUu.xZkqzma5hmJllqEgld0dgD5s3pTrYe', 'jocylyn', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/go.jfif?alt=media&token=a34d1d73-ffab-4c76-8f56-4ec27097f4e3', '09748394934', 0),
(8, 'regino123@gmail.com', '$2b$10$PHoZMWP5nIUnnv2RTZo2WO6dpPinztGkGUaci25zOqMTFkjrR/E/G', 'regino', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/go.jfif?alt=media&token=e3f56890-0c5c-403f-baf8-1a4ec69c03c4', '09847836834', 0),
(9, 'carlos12@gmail.com', '$2b$10$1iULY8iTCGQuqm43zjz89uEMSQ4sFSibSfSu43wfH6QSkaUX1SbsW', 'carlos', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/carm3.jfif?alt=media&token=87b3704a-c8c2-4c58-8656-e8c29e5f6165', '09739399234', 0);

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
(3, 58, '$2b$10$Mb3CCA1C9F1UMR0FIc3LAujtXoUuVQiAIoZJ28ILLZsf9byONGZ3i', '2021-10-25 14:13:32'),
(4, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', '2021-10-27 21:38:29');

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
(48, 'tricity@gmail.com', 2, ''),
(74, 'animalhouse@gmail.com', 2, ''),
(75, 'johnllaneta05@gmail.com', 1, ''),
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
(86, 'manila_vet1@gmail.com', 2, '09763723846'),
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
(119, 'myvet@gmail.com', 2, '09357498232');

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
(19, 'tricity@gmail.com', '$2b$10$9i2h.drYBR5hqXnv1zgr3evSS3s6Fi/rq97RdxjS/H.Wj1xLmnhbm', 'Tri-City Animal Hospital', '1942 Int. 5 Blk 10 Sta.Mesa, Manila', '09354555893', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Letter-to-the-Client-Signed.pdf?alt=media&token=b8e535fc-b41d-4aa9-9334-6a23c4fc351a', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Letter-to-the-Client-Signed.pdf?alt=media&token=b8e535fc-b41d-4aa9-9334-6a23c4fc351a', 'Verified', '06:00 - 20:29', '07:06 - 19:10', '19:06 - 18:07', '06:37 - 18:37', '06:36 - 18:37', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 0, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 1, '', 0, 121.006, 14.5993, 0),
(27, 'animalhouse@gmail.com', '$2b$10$54fDvasYHYzCg65QlFVQmu/EcHS/j3Q4s8eL6z.xycwEVSLddfjyq', 'Animal House Vet Clinic', '1602 int 5 F varona Street, Tondo,Manila', '09558261232', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Letter-to-the-Client-Signed.pdf?alt=media&token=b8e535fc-b41d-4aa9-9334-6a23c4fc351a', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Screen-Shot-2020-11-19-at-10.39.49-PM.png?alt=media&token=eb67c2d4-80f8-4fd1-bbc4-34961609fa5a', 'Unverified', '', '', '', '', '', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 0, '', 0, '', 0, 120.996, 14.6031, 0),
(28, 'westvalley@gmail.com', '$2b$10$L68mQGeYEoFlBAVtYCJBZOKLr08agfMDD0igxzWpaZtByT8rzNdV.', 'West Valley Animal Clinic', '1241 blk. 15 Velasquez Street,Tondo, Manila', '09081052103', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Letter-to-the-Client-Signed.pdf?alt=media&token=5b6c9bfc-8c86-472f-a436-3c2b392ecf4b', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/images.png?alt=media&token=a79fd71a-d4d2-4a2f-9a00-e7f9bd24afde', 'Verified', '', '', '', '', '', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 1, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, '', 0, 120.988, 14.6066, 0),
(29, 'cayco_clinic@gmail.com', '$2b$10$pjWTNfzrIXFmSrmHKjE/ReZ9E.G6iBIR4celVJwau9EBgXtBiFDx6', 'Cayco Animal Clinic', '434 Cayco St,Sampaloc, Manila', '09456372342', '', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/cayco.jpg?alt=media&token=7c994819-1883-4bb6-a42b-e0f426f2273a', 'Unverified', '', '', '', '', '', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 0, '$2b$10$0CCEKK4oxKnd8idkyaINEOiagaJiiw//ZQmKM7h2MUwbRY5Lxgt52', 0, '', 0, 120.996, 14.6038, 0),
(30, 'curapet@gmail.com', '$2b$10$s8kcX0EpUas0lLtaWvHQc.S/iHIK1PHAUQMB9v6UESRYVOZoIT51q', 'CuraPet Veterinary Clinic', '1009  Tejeron St,Santa Ana, Manila', '09564837642', '', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/curapet.jpg?alt=media&token=802deb0a-5e0b-4096-9094-3a2153f7de05', 'Unverified', '', '', '', '', '', '', '', 1, 0, 1, 1, 1, 1, 1, 0, 0, '$2b$10$7xnKUIcrfoLLpUJJtAeH.uJ1yEwfKkOnDjJUY0flkyLhlN4HeGram', 0, '', 0, 120.966, 14.6158, 0),
(31, 'wt_clinic@gmail.com', '$2b$10$KapEC.Th7JJF/Ev8.J2Ux.DCVcYE.mw0GrojzaOoI.6.cipBW9O6G', 'WT Veterinary Clinic', '1989 Gerardo Tuazon St,Sampaloc, Manila', '09354675835', '', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/wt.jpg?alt=media&token=c907f290-6be8-4897-a1ac-440364c3576d', 'Unverified', '', '', '', '', '', '', '', 0, 1, 1, 1, 1, 0, 0, 0, 0, '$2b$10$01F/oODEbFFTtyhDFcYs/OMKDRQ8At3ROUudj4CquGW.U1msEKfwC', 0, '', 0, 126.995, 15.9007, 0),
(32, 'pspca@gmail.com', '$2b$10$S4r9VpD4u7H6r.QD1pyiTuN8ZkXrCYfu7zp0FFht9Rubj2pQH8t/G', 'PSPCA', '2044 Recto Ave,Quiapo, Manila', '09127438382', '', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/pspca.jpg?alt=media&token=5befad38-6fdc-408c-8cef-56c1250b5431', 'Unverified', '', '', '', '', '', '', '', 0, 0, 1, 1, 1, 0, 1, 0, 0, '$2b$10$oQ7J0h33sHywkcfo.nBY9Or25rqUrqI5ZshmV7u5KOsmSpuakmiF.', 0, '', 0, 120.991, 14.6112, 0),
(33, 'manila_vet1@gmail.com', '$2b$10$DBoYQ2qwVj8nL/Gg7M87Fukuju6.L5.d7Tn2/pt62QA2vKNbHTMLi', 'ManilaVets Animal Clinic', '683  Manga Ave,Sampaloc, Manila', '09763723846', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/CENTIE-1.pdf?alt=media&token=9c12b1d6-7cf2-4098-9f86-9d2abb89cb9b', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/manila.png?alt=media&token=c4423ffe-75cf-42ef-82d4-3274044f8db8', 'Verified', '', '', '', '', '', '', '', 0, 1, 0, 0, 0, 0, 0, 0, 0, '$2b$10$zor8SCCINsCdzXSSsDQWueRicLReZ/yfHKtPtnVqdeWKGYP6cRkga', 0, '', 0, 120.983, 14.6111, 0),
(34, 'tumanivetclinic@gmail.com', '$2b$10$XDqigGcyKiIOLJzMoTB/NuluN.UHi3sopFZGGc/5cW3NoCpihU1na', 'Tumani Vet Clinic', '431 Tayuman Street,Manila City', '09073654951', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Letter-to-the-Client-Signed.pdf?alt=media&token=2a6bd727-4565-483a-9209-ae4a5418ceb5', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Screen-Shot-2020-11-19-at-10.39.49-PM.png?alt=media&token=3667d389-3e44-4aa5-90f4-26c28d3860c7', 'Pending', '', '', '', '', '', '', '', 1, 1, 1, 1, 1, 1, 1, 0, 0, '$2b$10$WWr2zCDq2UTcaVRwue5qje4xGr0Ss2L62ktt3yNFD.72dGlJsaIWu', 0, '', 0, 0, 0, 0),
(35, 'eastlife@gmail.com', '$2b$10$jUILWZcN9mrYImF7Mk5c1OYGbb8ogTXVQn9N7afLP7zxF1/gUdune', 'east life vet clinic', '1042 Tayuman Street,Tondo Manila', '09558264223', '', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/DOC%2BFERDS%2BANIMAL%2BWELLNESS%2BCENTER.jpg?alt=media&token=836d5381-b5ee-4538-9093-2e666bb01bb0', 'Unverified', '', '', '', '', '', '', '', 1, 1, 1, 1, 1, 1, 1, 0, 1, '$2b$10$ob2IFbTBfc0G6/tweyOD.OVNyPSH2hmoxzQPBZIJftaXWC9mQu6Ua', 0, '', 0, 0, 0, 0),
(37, 'chardVet@gmail.com', '$2b$10$jQw/tzIEdk6eB2pTzjLHeO2hPYOJIuLiGjgoevAwSOeL/pIWAdW9.', 'chardVet Clinic', '008 legarda,Quezon', '09836728223', '', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/manila.png?alt=media&token=b854aae6-685b-411c-87ba-82df6d21be78', 'Unverified', '', '', '', '', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, '$2b$10$.GJFLQbn5eJEvmzuATWJSeU.QG8hl0HbEs1O2DArRUZWRzMNxPbd.', 0, '', 0, 0, 0, 0),
(38, 'vetvetClinic@gmail.com', '$2b$10$Z14/HAVAqt1o0NEeuKlGUeRV5lzfCCvKZJJfJckC/yCRlbA/rmD1.', 'vetvetClinic', '008 legarda,Quezon', '09587939393', '', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/carm3.jfif?alt=media&token=907dcdd8-718c-4408-86bc-36fe5aff817b', 'Unverified', '', '', '', '', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, '$2b$10$p7zyewBK9Umy9akgNVNUquQR0XNCsX.eFSbBTHs9VxafOvK6t9CCi', 0, '', 0, 0, 0, 0),
(39, 'myvet@gmail.com', '$2b$10$qJEPI2NqaieUOoHMjf6eQeuyrBEEcFdxALL62HiRS2SMQyaAZb4p2', 'MyVet Clinic', '008 legarda,Quezon', '09357498232', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Consent%20Form.pdf?alt=media&token=38fc1ab5-fe2a-422f-a4d1-b477d9d02ad8', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/cayco.jpg?alt=media&token=67488d75-1c58-4616-b065-ccc35cb868d4', 'Verified', '', '', '', '', '', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 0, '$2b$10$Mb3CCA1C9F1UMR0FIc3LAujtXoUuVQiAIoZJ28ILLZsf9byONGZ3i', 0, '', 0, 0, 0, 0);

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
(23, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 35, '2021-10-19', '15:18:41', 0, 0, 0),
(24, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 35, '2021-10-19', '15:21:34', 1, 1, 1),
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
  ADD KEY `pet_id` (`pet_id`);

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
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `forget_password`
--
ALTER TABLE `forget_password`
  MODIFY `verify_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `immunization_history`
--
ALTER TABLE `immunization_history`
  MODIFY `immunization_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `medical_history`
--
ALTER TABLE `medical_history`
  MODIFY `medical_history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `notification_reservation`
--
ALTER TABLE `notification_reservation`
  MODIFY `notif_reserve_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

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
  MODIFY `medicine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `rate_feedback`
--
ALTER TABLE `rate_feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `reserve_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `stock_in`
--
ALTER TABLE `stock_in`
  MODIFY `stock_in_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `stock_used`
--
ALTER TABLE `stock_used`
  MODIFY `stockused_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `system_administrator`
--
ALTER TABLE `system_administrator`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `system_logs`
--
ALTER TABLE `system_logs`
  MODIFY `logs_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=218;

--
-- AUTO_INCREMENT for table `thread`
--
ALTER TABLE `thread`
  MODIFY `thread_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_role`
--
ALTER TABLE `user_role`
  MODIFY `user_role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `vaccination`
--
ALTER TABLE `vaccination`
  MODIFY `vaccination_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vet_clinic`
--
ALTER TABLE `vet_clinic`
  MODIFY `vet_admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

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
  ADD CONSTRAINT `medical_history_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`);

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
-- Constraints for table `visitor_monitoring`
--
ALTER TABLE `visitor_monitoring`
  ADD CONSTRAINT `visitor_monitoring_ibfk_1` FOREIGN KEY (`pet_owner_id`) REFERENCES `pet_owners` (`pet_owner_id`),
  ADD CONSTRAINT `visitor_monitoring_ibfk_2` FOREIGN KEY (`vetid`) REFERENCES `vet_clinic` (`vetid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
