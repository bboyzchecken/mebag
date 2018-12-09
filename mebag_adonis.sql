-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2018 at 05:41 PM
-- Server version: 10.1.31-MariaDB
-- PHP Version: 7.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mebag_adonis`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `Admin_ID` int(11) NOT NULL,
  `Admin_FirstName` text COLLATE utf8_unicode_ci NOT NULL,
  `Admin_LastName` text COLLATE utf8_unicode_ci NOT NULL,
  `Admin_Permission` text COLLATE utf8_unicode_ci NOT NULL,
  `Admin_Email` text COLLATE utf8_unicode_ci NOT NULL,
  `Admin_Password` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`Admin_ID`, `Admin_FirstName`, `Admin_LastName`, `Admin_Permission`, `Admin_Email`, `Admin_Password`, `created_at`, `updated_at`) VALUES
(1, 'แอดมิน', 'ใหญ่', '1', 'admin@mebag.com', '$2a$10$dmitmJ9SVutDVnB.Y8u5COKKQoeQGgXDNrlMKUn21EWJDFGvl84Ya', '2018-12-08 16:24:21', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `balances`
--

CREATE TABLE `balances` (
  `Balance_ID` int(11) NOT NULL,
  `Order_ID` int(11) NOT NULL,
  `Balance_Get` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `balances`
--

INSERT INTO `balances` (`Balance_ID`, `Order_ID`, `Balance_Get`, `created_at`, `updated_at`) VALUES
(1, 73, 100, '2018-12-08 19:15:28', '2018-12-08 19:15:28'),
(2, 74, 5, '2018-12-08 19:45:56', '2018-12-08 19:45:56'),
(3, 75, 5, '2018-12-08 20:15:36', '2018-12-08 20:15:36'),
(4, 82, 20, '2018-12-08 20:17:28', '2018-12-08 20:17:28'),
(5, 81, 20, '2018-12-08 20:21:22', '2018-12-08 20:21:22'),
(6, 83, 20, '2018-12-09 15:50:14', '2018-12-09 15:50:14');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `Event_ID` int(11) NOT NULL,
  `Event_Name` text COLLATE utf8_unicode_ci NOT NULL,
  `Event_Detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Event_Place` text COLLATE utf8_unicode_ci NOT NULL,
  `Event_Type` int(11) NOT NULL,
  `Event_Start` text COLLATE utf8_unicode_ci NOT NULL,
  `Event_End` text COLLATE utf8_unicode_ci NOT NULL,
  `Event_CoverImage` text COLLATE utf8_unicode_ci NOT NULL,
  `Event_Price` int(11) NOT NULL,
  `Event_TransportPrice` int(11) NOT NULL,
  `Event_Whose` int(11) NOT NULL,
  `Event_Status` int(11) NOT NULL,
  `Event_TimePayment` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`Event_ID`, `Event_Name`, `Event_Detail`, `Event_Place`, `Event_Type`, `Event_Start`, `Event_End`, `Event_CoverImage`, `Event_Price`, `Event_TransportPrice`, `Event_Whose`, `Event_Status`, `Event_TimePayment`, `created_at`, `updated_at`) VALUES
(28, 'MINON แผ่นมาร์กหน้าเนื้อเจล', 'lkhjkj', 'เซนทรัลลาดพร้าว', 2, '2018-12-01', '2018-12-29', '18_00dc271ac7b5165c460e4cc198e913aaVGD93nF2VfQv6G0XBulMRg==.jpeg', 50, 50, 18, 0, '', '2018-12-06 09:53:08', '2018-12-06 09:53:53'),
(29, 'ทดสอบจริงจังอีกครั้ง', 'test', 'ทดสอบจริงจังอีกครั้ง', 1, '2018-12-08', '2018-12-09', '19_aba679c4b094cd4b6c84a193adfa4a813hD/qpBjcqs63Ti2+y6zwg==.jpeg', 200, 150, 19, 0, '', '2018-12-08 14:53:43', '2018-12-08 14:53:43');

-- --------------------------------------------------------

--
-- Table structure for table `event_images`
--

CREATE TABLE `event_images` (
  `Img_ID` int(11) NOT NULL,
  `Event_ID` int(11) NOT NULL,
  `Img_FileName` text COLLATE utf8_unicode_ci NOT NULL,
  `Img_FilePath` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `event_images`
--

INSERT INTO `event_images` (`Img_ID`, `Event_ID`, `Img_FileName`, `Img_FilePath`, `created_at`, `updated_at`) VALUES
(88, 28, '18_00dc271ac7b5165c460e4cc198e913aaVGD93nF2VfQv6G0XBulMRg==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-b22218e3-e594-4742-81c3-bc0ae5602ced.tmp', '2018-12-06 09:53:08', '2018-12-06 09:53:08'),
(89, 29, '19_aba679c4b094cd4b6c84a193adfa4a813hD/qpBjcqs63Ti2+y6zwg==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-4097f83e-3b06-4cf1-96ac-5ab969be8207.tmp', '2018-12-08 14:53:43', '2018-12-08 14:53:43');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `Order_ID` int(11) NOT NULL,
  `Order_Whose` int(11) NOT NULL,
  `Order_ToWho` text COLLATE utf8_unicode_ci NOT NULL,
  `Event_ID` int(11) NOT NULL,
  `Event_Name` text COLLATE utf8_unicode_ci NOT NULL,
  `Order_SumEvent` text COLLATE utf8_unicode_ci NOT NULL,
  `Order_SumTransport` text COLLATE utf8_unicode_ci NOT NULL,
  `Order_SumProduct` text COLLATE utf8_unicode_ci NOT NULL,
  `Order_Total` int(11) NOT NULL,
  `Order_Status` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `Order_Date` text COLLATE utf8_unicode_ci NOT NULL,
  `Order_Payment` text COLLATE utf8_unicode_ci NOT NULL,
  `Order_Track` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`Order_ID`, `Order_Whose`, `Order_ToWho`, `Event_ID`, `Event_Name`, `Order_SumEvent`, `Order_SumTransport`, `Order_SumProduct`, `Order_Total`, `Order_Status`, `Order_Date`, `Order_Payment`, `Order_Track`, `created_at`, `updated_at`) VALUES
(68, 18, '18', 28, 'MINON แผ่นมาร์กหน้าเนื้อเจล', '50', '50', '289', 389, 'success', '06-12-2018', '12', 'EV 1515455451 TH', '2018-12-06 09:54:26', '2018-12-06 10:08:48'),
(69, 18, '18', 28, 'MINON แผ่นมาร์กหน้าเนื้อเจล', '100', '100', '578', 778, 'success', '06-12-2018', '13', 'EV1515455451TH', '2018-12-06 10:04:00', '2018-12-06 10:08:52'),
(70, 18, '18', 28, 'MINON แผ่นมาร์กหน้าเนื้อเจล', '350', '350', '2023', 2723, 'reject', '06-12-2018', '', '', '2018-12-06 10:13:42', '2018-12-06 10:13:55'),
(71, 18, '18', 28, 'MINON แผ่นมาร์กหน้าเนื้อเจล', '100', '100', '578', 778, 'cancel', '06-12-2018', '14', '', '2018-12-06 10:14:27', '2018-12-06 10:15:55'),
(72, 18, '18', 28, 'MINON แผ่นมาร์กหน้าเนื้อเจล', '50', '50', '289', 389, 'paid', '06-12-2018', '15', 'EV 1515455451 TH', '2018-12-06 11:20:03', '2018-12-08 15:09:17'),
(73, 19, '19', 29, 'ทดสอบจริงจังอีกครั้ง', '1000', '750', '2500', 4250, 'success', '08-12-2018', '17', 'ES 123456789 TH', '2018-12-08 14:56:26', '2018-12-08 19:15:28'),
(74, 20, '18', 28, 'MINON แผ่นมาร์กหน้าเนื้อเจล', '50', '50', '289', 389, 'success', '09-12-2018', '18', 'EV 1515455451 TH', '2018-12-08 18:30:57', '2018-12-08 19:45:56'),
(75, 20, '18', 28, 'MINON แผ่นมาร์กหน้าเนื้อเจล', '50', '50', '289', 389, 'success', '09-12-2018', '19', 'EV 1515455451 TH', '2018-12-08 19:46:07', '2018-12-08 20:15:36'),
(76, 20, '18', 28, 'MINON แผ่นมาร์กหน้าเนื้อเจล', '50', '50', '289', 389, 'paid', '09-12-2018', '20', '', '2018-12-08 19:54:54', '2018-12-08 19:58:56'),
(77, 20, '19', 29, 'ทดสอบจริงจังอีกครั้ง', '200', '150', '500', 850, 'reject_recive', '09-12-2018', '21', 'ES 123456789 TH', '2018-12-08 20:01:35', '2018-12-08 20:21:18'),
(78, 20, '18', 28, 'MINON แผ่นมาร์กหน้าเนื้อเจล', '50', '50', '289', 389, '0', '09-12-2018', '', '', '2018-12-08 20:10:34', '2018-12-08 20:10:34'),
(79, 20, '19', 29, 'ทดสอบจริงจังอีกครั้ง', '400', '300', '1000', 1700, 'reject_recive', '09-12-2018', '22', 'ES 123456789 TH', '2018-12-08 20:11:12', '2018-12-08 20:20:51'),
(80, 20, '19', 29, 'ทดสอบจริงจังอีกครั้ง', '200', '150', '500', 850, 'reject_recive', '09-12-2018', '23', 'ES 123456789 TH', '2018-12-08 20:11:25', '2018-12-08 20:21:10'),
(81, 20, '19', 29, 'ทดสอบจริงจังอีกครั้ง', '200', '150', '500', 850, 'success', '09-12-2018', '24', 'ES 123456789 TH', '2018-12-08 20:14:02', '2018-12-08 20:21:22'),
(82, 20, '19', 29, 'ทดสอบจริงจังอีกครั้ง', '200', '150', '500', 850, 'success', '09-12-2018', '25', 'ES 123456789 TH', '2018-12-08 20:16:03', '2018-12-08 20:17:28'),
(83, 21, '19', 29, 'ทดสอบจริงจังอีกครั้ง', '200', '150', '500', 850, 'success', '09-12-2018', '26', 'ES 123456789 TH', '2018-12-09 15:41:35', '2018-12-09 15:50:14');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `Detail_ID` int(11) NOT NULL,
  `Order_ID` int(11) NOT NULL,
  `Product_ID` text COLLATE utf8_unicode_ci NOT NULL,
  `Product_Name` text COLLATE utf8_unicode_ci NOT NULL,
  `Product_Type` text COLLATE utf8_unicode_ci NOT NULL,
  `Product_Price` text COLLATE utf8_unicode_ci NOT NULL,
  `qty` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`Detail_ID`, `Order_ID`, `Product_ID`, `Product_Name`, `Product_Type`, `Product_Price`, `qty`, `created_at`, `updated_at`) VALUES
(23, 68, '34', 'NewBalance', '1 ซอง มี 1 แผ่น', '289', '1', '2018-12-06 09:54:26', '2018-12-06 09:54:26'),
(24, 69, '34', 'NewBalance', '1 ซอง มี 1 แผ่น', '289', '2', '2018-12-06 10:04:00', '2018-12-06 10:04:00'),
(25, 70, '34', 'NewBalance', '1 ซอง มี 1 แผ่น', '289', '7', '2018-12-06 10:13:42', '2018-12-06 10:13:42'),
(26, 71, '34', 'NewBalance', '1 ซอง มี 1 แผ่น', '289', '2', '2018-12-06 10:14:27', '2018-12-06 10:14:27'),
(27, 72, '34', 'NewBalance', '1 ซอง มี 1 แผ่น', '289', '1', '2018-12-06 11:20:03', '2018-12-06 11:20:03'),
(28, 73, '35', 'รถยน', 'VEGO', '500', '5', '2018-12-08 14:56:26', '2018-12-08 14:56:26'),
(29, 74, '34', 'NewBalance', '1 ซอง มี 1 แผ่น', '289', '1', '2018-12-08 18:30:57', '2018-12-08 18:30:57'),
(30, 75, '34', 'NewBalance', '1 ซอง มี 1 แผ่น', '289', '1', '2018-12-08 19:46:07', '2018-12-08 19:46:07'),
(31, 76, '34', 'NewBalance', '1 ซอง มี 1 แผ่น', '289', '1', '2018-12-08 19:54:54', '2018-12-08 19:54:54'),
(32, 77, '35', 'รถยน', 'VEGO', '500', '1', '2018-12-08 20:01:35', '2018-12-08 20:01:35'),
(33, 78, '34', 'NewBalance', '1 ซอง มี 1 แผ่น', '289', '1', '2018-12-08 20:10:34', '2018-12-08 20:10:34'),
(34, 79, '35', 'รถยน', 'VEGO', '500', '2', '2018-12-08 20:11:12', '2018-12-08 20:11:12'),
(35, 80, '35', 'รถยน', 'VEGO', '500', '1', '2018-12-08 20:11:25', '2018-12-08 20:11:25'),
(36, 81, '35', 'รถยน', 'VEGO', '500', '1', '2018-12-08 20:14:02', '2018-12-08 20:14:02'),
(37, 82, '35', 'รถยน', 'VEGO', '500', '1', '2018-12-08 20:16:03', '2018-12-08 20:16:03'),
(38, 83, '35', 'รถยน', 'VEGO', '500', '1', '2018-12-09 15:41:35', '2018-12-09 15:41:35');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `Payment_ID` int(11) NOT NULL,
  `Order_ID` int(11) NOT NULL,
  `Payment_Urgent` text COLLATE utf8_unicode_ci NOT NULL,
  `Payment_Bank` text COLLATE utf8_unicode_ci NOT NULL,
  `Payment_Time` text COLLATE utf8_unicode_ci NOT NULL,
  `Payment_Date` text COLLATE utf8_unicode_ci NOT NULL,
  `Payment_Amount` text COLLATE utf8_unicode_ci NOT NULL,
  `Payment_Message` text COLLATE utf8_unicode_ci NOT NULL,
  `Payment_Whose` text COLLATE utf8_unicode_ci NOT NULL,
  `Payment_Receipt` text COLLATE utf8_unicode_ci NOT NULL,
  `Payment_Status` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`Payment_ID`, `Order_ID`, `Payment_Urgent`, `Payment_Bank`, `Payment_Time`, `Payment_Date`, `Payment_Amount`, `Payment_Message`, `Payment_Whose`, `Payment_Receipt`, `Payment_Status`) VALUES
(12, 68, 'Medium', 'กรุงไทย(KTB)', '11.59', '12/12/61', '389', '', '18', '18_bf152cbfb0da6eb941de6af4a1167777yLQjWqVJVZNUFDmBfXsTtw==.jpeg', 'accept'),
(13, 69, 'Medium', 'กรุงไทย(KTB)', '11.59', '12/12/61', '778', '', '18', '18_b4ed855677e303e5d614cb376071978faIB/TL5OlSKySwRyU0IcFw==.jpeg', 'accept'),
(14, 71, 'Medium', 'กรุงไทย(KTB)', '11.59', '12/12/61', '778', '', '18', '18_e2c54f645c1730945526971d6a966cfdY71ecazQNLEoGsINBEE8qw==.jpeg', 'reject'),
(15, 72, 'Medium', 'กรุงไทย(KTB)', '11.59', '12/12/61', '389', 'retert', '18', '18_cff51cf2f3a6a6d579dfc380ee140adfQXBed32zsBMi3WbyM/wYwg==.jpeg', 'accept'),
(16, 73, 'Medium', 'กรุงไทย(KTB)', '24.59', '12/32/11', '999.24', 'tqtwtwq', '19', '19_588bb5460b26e59674df07ee0c3235e5W0gZdsjB5k2dHDoVsXMD5A==.jpeg', 'accept'),
(17, 73, 'Medium', 'กรุงไทย(KTB)', '24.59', '12/32/11', '999.24', 'teqweqw', '19', '19_92b4ef1b82462e580391347ee470b8faOFvYx48ZCW0HlIjJBoOH1w==.jpeg', 'accept'),
(18, 74, 'Medium', 'กรุงไทย(KTB)', '11.59', '12/12/61', '389', 'dfsdsd', '20', '20_ff6f7e06f30a5f47df35413462a963b6eFGHJDWFZG4Rbh/L8cvE2w==.jpeg', 'accept'),
(19, 75, 'Medium', 'กรุงไทย(KTB)', '11.59', '12/12/61', '389', '', '20', '20_e81b2bc534597633dbe5075b11371c6aQk2roCd2kTn5Fu2veW0eRg==.jpeg', 'accept'),
(20, 76, 'Medium', 'กรุงไทย(KTB)', '11.59', '12/12/61', '389', 'ที่อยู่ 124 สหกหหเิอก', '20', '20_7e3099bac705b368545bfc865889a9581e/ZOoSMgfAw72dBXVCAlQ==.jpeg', 'accept'),
(21, 77, 'Medium', 'กรุงไทย(KTB)', '11.59', '12/12/61', '700', 'หมู่ 654 อ เมือง จ พะเยา ', '20', '20_62bc39601f8b2e71757ead6c1148376dgrYqe7+p0vuB06Lqh7UTag==.jpeg', 'accept'),
(22, 79, 'Medium', 'กรุงไทย(KTB)', '11.59', '12/12/61', '700', '', '20', '20_5ba1bd46e3a892e11a51205097754075CnxYny9rTBaeK6JeKNJh9w==.jpeg', 'accept'),
(23, 80, 'Medium', 'กรุงไทย(KTB)', '11.59', '12/12/61', '1700', '222/14 อำเภอเมือง ตำบล ฟ้าฮ่าม จังหวัดเชียงใหม่ 50000 หมู่บ้าน เอ็มเพอร์เร่อ 2\r\nโทร 097512632', '20', '20_251318304c151fffc5c742009b048b90K4u9aZCRWuvglLWP6T4JoQ==.jpeg', 'accept'),
(24, 81, 'Medium', 'กรุงไทย(KTB)', '11.59', '12/12/61', '700', '', '20', '20_655f5b4b5cf9417df5fff8e7dbf7f22ejqY/ElRqdr1GS1llIskeKg==.jpeg', 'accept'),
(25, 82, 'Medium', 'กรุงไทย(KTB)', '11.59', '12/12/61', '700', '', '20', '20_2f9a761238411e27db64a5a94a45a92arQhTxOl2VX24YTTsefj+yA==.jpeg', 'accept'),
(26, 83, 'Medium', 'กรุงไทย(KTB)', '24.59', '12/32/11', '999.24', '', '21', '21_50a7fadce1b8d83ab368938d2279a2d3RoCrVpgoUjBD13atOrHvWQ==.jpeg', 'accept');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `Product_ID` int(11) NOT NULL,
  `Event_ID` int(11) NOT NULL,
  `Product_Code` text COLLATE utf8_unicode_ci NOT NULL,
  `Product_Name` text COLLATE utf8_unicode_ci NOT NULL,
  `Product_Type` text COLLATE utf8_unicode_ci NOT NULL,
  `Product_Price` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`Product_ID`, `Event_ID`, `Product_Code`, `Product_Name`, `Product_Type`, `Product_Price`, `created_at`, `updated_at`) VALUES
(34, 28, '', 'NewBalance', '1 ซอง มี 1 แผ่น', 289, '2018-12-06 09:53:24', '2018-12-06 09:53:24'),
(35, 29, '', 'รถยน', 'VEGO', 500, '2018-12-08 14:55:53', '2018-12-08 14:55:53');

-- --------------------------------------------------------

--
-- Table structure for table `tranfers`
--

CREATE TABLE `tranfers` (
  `Tranfer_ID` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Tranfer_Receipt` text COLLATE utf8_unicode_ci NOT NULL,
  `Tranfer_Amount` text COLLATE utf8_unicode_ci NOT NULL,
  `Tranfer_Date` text COLLATE utf8_unicode_ci NOT NULL,
  `Tranfer_Time` text COLLATE utf8_unicode_ci NOT NULL,
  `Tranfer_BankNumber` text COLLATE utf8_unicode_ci NOT NULL,
  `Tranfer_Status` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tranfers`
--

INSERT INTO `tranfers` (`Tranfer_ID`, `User_ID`, `Tranfer_Receipt`, `Tranfer_Amount`, `Tranfer_Date`, `Tranfer_Time`, `Tranfer_BankNumber`, `Tranfer_Status`, `created_at`, `updated_at`) VALUES
(1, 18, '19_d1c4135831266c24cb9d8a224897466ewHmJivgGvHo4NNsJdilojw==.jpeg', '500', '9/12/2018', '24.59', '555555555555555555555555555555555555555555', 1, '2018-12-08 18:21:06', '2018-12-08 18:21:06'),
(2, 19, '19_f7c458ad42adeda903dcc29f90f3bb74Vkt3iQkLYO9svTLZWtPRjA==.jpeg', '6643', '9/12/2018', '24.59', '123456789', 0, '2018-12-09 16:37:06', '2018-12-09 16:37:06');

-- --------------------------------------------------------

--
-- Table structure for table `tranfer_date`
--

CREATE TABLE `tranfer_date` (
  `Date_ID` int(11) NOT NULL,
  `Tranfer_Date` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tranfer_date`
--

INSERT INTO `tranfer_date` (`Date_ID`, `Tranfer_Date`, `created_at`, `updated_at`) VALUES
(1, '2018-12-06', '2018-12-06 11:57:12', '2018-12-06 11:57:12'),
(2, '2018-12-06', '2018-12-06 11:58:28', '2018-12-06 11:58:28'),
(3, '2018-12-22', '2018-12-06 12:01:07', '2018-12-06 12:01:07'),
(4, '2018-12-08', '2018-12-08 14:59:23', '2018-12-08 14:59:23'),
(5, '2018-12-19', '2018-12-08 15:06:18', '2018-12-08 15:06:18'),
(6, '2018-12-15', '2018-12-08 15:20:59', '2018-12-08 15:20:59'),
(7, '2018-12-23', '2018-12-08 15:29:17', '2018-12-08 15:29:17');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `User_ID` int(11) NOT NULL,
  `User_FirstName` text COLLATE utf8_unicode_ci NOT NULL,
  `User_LastName` text COLLATE utf8_unicode_ci NOT NULL,
  `User_Sex` text COLLATE utf8_unicode_ci NOT NULL,
  `User_BirthDay` text COLLATE utf8_unicode_ci NOT NULL,
  `User_Tel` text COLLATE utf8_unicode_ci NOT NULL,
  `User_Email` text COLLATE utf8_unicode_ci NOT NULL,
  `User_Address` text COLLATE utf8_unicode_ci NOT NULL,
  `User_Password` text COLLATE utf8_unicode_ci NOT NULL,
  `User_Permission` text COLLATE utf8_unicode_ci NOT NULL,
  `User_Image` text COLLATE utf8_unicode_ci NOT NULL,
  `User_Intro` text COLLATE utf8_unicode_ci NOT NULL,
  `User_Wallet` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`User_ID`, `User_FirstName`, `User_LastName`, `User_Sex`, `User_BirthDay`, `User_Tel`, `User_Email`, `User_Address`, `User_Password`, `User_Permission`, `User_Image`, `User_Intro`, `User_Wallet`, `created_at`, `updated_at`) VALUES
(18, 'Test1', 'Test1', 'Male', '2018-12-01', '000000000', 'Test1@hotmail.com', '1', '$2a$10$wYtwkDT3TW2Z9Y2n5hBtNeT/ryuGXk7S5cTzXGizv1bvV2rGRH9cS', '1', '0', '', 1268, '2018-12-06 09:44:54', '2018-12-08 20:15:36'),
(19, 'จิรพัฒน์', 'สินธุวงศ์', 'Male', '1996-10-06', '0882328949', 'jirapatsintuwong@gmail.com', '172 จันทร์แก้ว2 หมู่ 2', '$2a$10$EnKwMonXRhoKxYHTiRRsKuGjVooxWF0v2VBQeDw6ehQ8izkiGxb6a', '1', '19_336149bdabdc4c80639bc23ad104138buDzr1pT9okGsMKj/CT9whQ==.jpeg', '', 6643, '2018-12-06 09:49:35', '2018-12-09 15:50:14'),
(20, 'nuttaporn', 'Phanyingyok', 'Male', '2018-12-21', '0981240931', 'nuttaporn@gmail.com', '453453t6utyu', '$2a$10$0POsan7azapm8yUyECZ.O.2jpLzMyL0UUYM53du11DChYrCg8zeBu', '2', '20_8b47c120c2f78779b711201bf9ae8c8fxVhUEEGdAXWVaAzu0pT4aA==.jpeg', '', 0, '2018-12-08 14:59:12', '2018-12-08 19:41:22'),
(21, 'นายทดสอบ', 'นามสกุลสมมุติ', 'Male', '2018-12-09', '0882328949', 'test@mebag.com', '172 จันทร์แก้ว2 หมู่ 2', '$2a$10$vkNPGr0o4gYffQm.cQSac.dA6uDuq4qJTTaK/Kcrdfuwxu3QO.aOm', '0', '21_4972ff45f66d0f7ec5959bf814ac32a0+/qIwG3JCf/zL9aj6TTK8A==.jpeg', '', 0, '2018-12-09 15:37:51', '2018-12-09 15:38:15');

-- --------------------------------------------------------

--
-- Table structure for table `verifies`
--

CREATE TABLE `verifies` (
  `Verify_ID` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Verify_BankName` text COLLATE utf8_unicode_ci NOT NULL,
  `Verify_BankNumber` text COLLATE utf8_unicode_ci NOT NULL,
  `Verify_BankImage` text COLLATE utf8_unicode_ci NOT NULL,
  `Verify_CardImage` text COLLATE utf8_unicode_ci NOT NULL,
  `Verify_CardID` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `verifies`
--

INSERT INTO `verifies` (`Verify_ID`, `User_ID`, `Verify_BankName`, `Verify_BankNumber`, `Verify_BankImage`, `Verify_CardImage`, `Verify_CardID`, `created_at`, `updated_at`) VALUES
(9, 18, 'กรุงไทย', '154789642522', '18_5599ad5e0aaa62c0089006726b8e5ad2cYtZFfST/p5I84Y0cYBd6A==.png', '18_f2db62e0c40839f637698a2f6e35cd56e5K6QqsTvZV+uDckFJ39iQ==.png', '1034567891012', '2018-12-06 09:44:54', '2018-12-06 09:48:34'),
(10, 19, 'กรุงไทย', '12345678901234', '19_edb7fd52709524d6a42ddbf590167641eLKnaRIKPL+C/Cf80DJAug==.jpeg', '19_9bbda26593217986736dd5206c48789fAGhPZyyJImUIo8HzhvoV6g==.jpeg', '1559900314909', '2018-12-06 09:49:35', '2018-12-06 11:13:06'),
(11, 20, 'กรุงไทย', '1215483215452', '20_ca7fa166bbd7f92d866b05d103ac29735OgDpIXMTMtXxQTVyP6IRA==.jpeg', '20_c9b574070f25541505576a936aa70a29zCmlkV6darpdPF39eMJRJw==.jpeg', '1034567891012', '2018-12-08 14:59:12', '2018-12-08 15:03:14'),
(12, 21, '', '', '', '', '', '2018-12-09 15:37:51', '2018-12-09 15:37:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`Admin_ID`);

--
-- Indexes for table `balances`
--
ALTER TABLE `balances`
  ADD PRIMARY KEY (`Balance_ID`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`Event_ID`);

--
-- Indexes for table `event_images`
--
ALTER TABLE `event_images`
  ADD PRIMARY KEY (`Img_ID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`Order_ID`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`Detail_ID`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`Payment_ID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`Product_ID`);

--
-- Indexes for table `tranfers`
--
ALTER TABLE `tranfers`
  ADD PRIMARY KEY (`Tranfer_ID`);

--
-- Indexes for table `tranfer_date`
--
ALTER TABLE `tranfer_date`
  ADD PRIMARY KEY (`Date_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`User_ID`);

--
-- Indexes for table `verifies`
--
ALTER TABLE `verifies`
  ADD PRIMARY KEY (`Verify_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `Admin_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `balances`
--
ALTER TABLE `balances`
  MODIFY `Balance_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `Event_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `event_images`
--
ALTER TABLE `event_images`
  MODIFY `Img_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `Order_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `Detail_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `Payment_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `Product_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `tranfers`
--
ALTER TABLE `tranfers`
  MODIFY `Tranfer_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tranfer_date`
--
ALTER TABLE `tranfer_date`
  MODIFY `Date_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `verifies`
--
ALTER TABLE `verifies`
  MODIFY `Verify_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
