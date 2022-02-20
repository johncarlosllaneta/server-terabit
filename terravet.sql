-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 20, 2022 at 07:35 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
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

-- --------------------------------------------------------

--
-- Table structure for table `consultation`
--

CREATE TABLE `consultation` (
  `consultation_id` int(11) NOT NULL,
  `consultation_type` varchar(100) NOT NULL,
  `vet_admin_id` int(11) NOT NULL,
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
(38, 'johnllaneta05@gmail.com', 5042, '2021-12-23 22:56:44'),
(39, 'johnllaneta05@gmail.com', 9653, '2022-01-24 15:24:59'),
(40, 'terravetapp00@gmail.com', 6222, '2022-01-24 15:30:43'),
(41, 'terravetapp00@gmail.com', 9978, '2022-01-29 20:13:32');

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

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`message_id`, `thread_id`, `pet_owner_id`, `vetid`, `user_message`, `created_time_date`, `message_content`) VALUES
(1, 5, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 1, '2022-01-23 17:38:26', 'Hello Sir are you available?'),
(2, 5, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, '2022-01-23 17:58:30', 'Yes sir'),
(3, 5, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 2, '2022-01-23 17:58:30', 'Yes sir');

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
(58, 'john040717@gmail.com', '$2b$10$zxbmiHBi0suCVcCycR0VdOtZdu6qHCj4LYq9hGn6a85QFTKvtmMi6', 'Jhaycee Llaneta', 'Tondo, Manila', '09558264299', 'http://localhost:3001/profile/petowner/profile_petowner_1621987617668.jpg', 0, 0, '2021-06-02 18:53:08');

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
  `lot_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pharmacy`
--

INSERT INTO `pharmacy` (`medicine_id`, `medicine_name`, `medicine_description`, `status`, `price`, `vetid`, `medicine_image`, `lot_id`) VALUES
(24, 'heartgard', 'chewables 6', 1, 250, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Web%20capture_15-6-2021_234216_www.1800petmeds.com.jpeg?alt=media&token=e3a098c2-ed05-416c-b179-50ef57582ca9', '123456789');

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
('21265134', 'Pet bed', 'pet bed for dogs', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 50, 500, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/221406245091125820?alt=media&token=0ebb420e-b56a-4345-8d79-b7929446e2a1', 'Merchandise', 'Dogs'),
('27675781', 'Dog bed', 'beds for dogs', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 20, 611, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/177096012507373950?alt=media&token=d2154eb4-dfb2-4d79-abf7-f674b7a82a92', 'Merchandise', 'Dogs'),
('31634188', 'Dog can', 'can for dog', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 50, 350, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/41854690632238790?alt=media&token=b854e4fa-aa27-48b4-b82f-30bbbe20fbd7', 'Food', 'Dogs'),
('60798523', 'Poop bag', 'Poop bag for dogs and cat', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 200, 499, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/670083399747242400?alt=media&token=3dcc2af9-2a8c-4b66-a6ee-2e640e6a1e70', 'Merchandise', 'Cat'),
('61848732', 'Cat Food', 'Cat Foods for cats', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 500, 198, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/781026826956475500?alt=media&token=f1156dd5-ebb7-4d54-814e-4e98313cb473', 'Food', 'Cat'),
('69798868', 'Bone toy', 'toy for dogs', '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 50, 300, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/166108208346230400?alt=media&token=5868c025-1dfb-4afe-a2d6-b3398cbf96c4', 'Toys', 'Dogs');

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
(33, 'Plea and Tick Control', 'Removing plea and tick controls', 'Preventive Controls', 500, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(38, 'Urine Testing', 'Testing Urine', 'Pet Examination', 300, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(40, 'Nail Trimming', 'Trimming Nails for cats and dogs', 'Pet Grooming', 250, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai'),
(42, 'SinoVac', 'SinoVac vaccine', 'Vaccination', 300, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai');

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
(1, 'admin@gmail.com', '$2b$10$qrfPll4/KDZU1PLePJVKRuQrM7K5sHuPXbKb8Mz3vk8ae2EGNd.n.', 'kingchardddffff', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/21369213_1609700262438143_6979360524817941722_n.jpg?alt=media&token=371a4a3b-3458-4150-a269-a676e4727a4a', '', 0, 0);

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
(401, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-01-23 17:10:56'),
(402, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-01-23 18:53:43'),
(403, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-01-24 06:06:59'),
(404, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-01-24 07:53:43'),
(405, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-01-25 08:10:11'),
(406, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-01-25 09:14:50'),
(407, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-01-29 11:59:58'),
(408, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-01-29 12:03:54'),
(409, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-01-29 12:04:13'),
(410, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-01 10:53:27'),
(411, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-01 19:02:30'),
(412, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-01 19:03:12'),
(413, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-01 19:03:21'),
(414, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-05 15:12:53'),
(415, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-05 18:37:53'),
(416, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-06 16:22:02'),
(417, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-06 18:49:00'),
(418, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-14 09:40:13'),
(419, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-14 10:11:46'),
(420, 'Tri City Animal Hospital has been logged in as vet clinic', 1, '2022-02-14 10:12:36'),
(421, 'Tri City Animal Hospital has been logged out as vet clinic', 3, '2022-02-14 10:13:04'),
(422, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-14 10:13:18'),
(423, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-14 11:15:49'),
(424, 'West Valley Animal Clinic has been logged in as vet clinic', 1, '2022-02-20 16:48:32'),
(425, 'West Valley Animal Clinic has been logged out as vet clinic', 3, '2022-02-20 18:34:17');

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
(5, 58, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', '2022-01-23 17:37:51');

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
(136, 'tricity@gmail.com', 2, '09072069351'),
(137, 'westvalley@gmail.com', 2, '09558264298'),
(138, 'john040717@gmail.com', 1, '09558264299'),
(139, 'admin@gmail.com', 3, '09081052103'),
(140, 'johnllaneta05@gmail.com', 4, '09081052104'),
(142, 'terravetapp00@gmail.com', 5, '09668264989');

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
(19, 'tricity@gmail.com', '$2b$10$9i2h.drYBR5hqXnv1zgr3evSS3s6Fi/rq97RdxjS/H.Wj1xLmnhbm', 'Tri City Animal Hospital', '1949 Int. 5 Blk 10 Sta.Mesa, Manila', '09404555898', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Letter-to-the-Client-Signed.pdf?alt=media&token=b8e535fc-b41d-4aa9-9334-6a23c4fc351a', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Letter-to-the-Client-Signed.pdf?alt=media&token=b8e535fc-b41d-4aa9-9334-6a23c4fc351a', 'Verified', '06:00 - 20:29', '07:06 - 19:10', '19:06 - 18:07', '06:37 - 18:37', '06:36 - 18:37', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 0, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhbc', 0, '', 0, 121.006, 14.5993, 0),
(28, 'westvalley@gmail.com', '$2b$10$L68mQGeYEoFlBAVtYCJBZOKLr08agfMDD0igxzWpaZtByT8rzNdV.', 'West Valley Animal Clinic', '1241 blk. 15 Velasquez Street,Tondo, Manila', '09081052103', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Letter-to-the-Client-Signed.pdf?alt=media&token=5b6c9bfc-8c86-472f-a436-3c2b392ecf4b', 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/867179326322626200?alt=media&token=8f83e09d-e86a-4e7c-9354-51c1d75b378e', 'Verified', '06:00 - 20:29', '', '', '', '', '', '', 1, 1, 1, 1, 1, 1, 1, 1, 1, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 0, '', 0, 120.988, 14.6066, 0);

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
(6, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 'Jhaycee', 'Llaneta', 'Enriquez', '09081052103', 'johnllaneta05@gmail.com', NULL, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/Presentation1.jpg?alt=med', '$2b$10$xbAw3madurA4p7ncLdI2F.8y000QUQOwlSmQFWiqas3ubWZFibwFy', 'Male', 0, 0),
(7, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 'James', 'Llaneta', 'Enriquez', '09081052104', 'johnllaneta05@gmail.com', NULL, 'https://firebasestorage.googleapis.com/v0/b/terravet-website.appspot.com/o/payment-wallet.png?alt=me', '$2b$10$vsdwQyDvSnoUCnvLtC2EO.hYSfWw7j.Qm7wYmj7g2aKA4oafSDYda', 'Male', 0, 0);

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
(3, '$2b$10$4RujGwsxeIvMLoeOjX6PYOShX5Xl5sA5A72yHDYdjBLjRWLyhLhai', 'James', 'Llaneta', 'Johan', '09668264989', 'terravetapp00@gmail.com', '', '$2b$10$MVJPlErIWLvbsthdGsefQOh5XA.AwyHpmqutcEHwJZOYVN5BV9/VW', 0, 0);

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
  ADD KEY `vet_admin_id` (`vet_admin_id`),
  ADD KEY `vet_doc_id` (`vet_doc_id`),
  ADD KEY `pet_id` (`pet_id`);

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
  ADD UNIQUE KEY `med_id` (`lot_id`),
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
  MODIFY `email_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

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
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

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
  MODIFY `logs_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=426;

--
-- AUTO_INCREMENT for table `thread`
--
ALTER TABLE `thread`
  MODIFY `thread_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_role`
--
ALTER TABLE `user_role`
  MODIFY `user_role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=143;

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
  MODIFY `vet_doc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
  ADD CONSTRAINT `consultation_ibfk_1` FOREIGN KEY (`vet_admin_id`) REFERENCES `vet_clinic` (`vet_admin_id`),
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
