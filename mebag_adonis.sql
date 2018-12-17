-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 17, 2018 at 07:26 PM
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
(44, ' Texas Chicken คอมโบเซ็ต 2 ชุดใหม่! 229.- ', '🍗 Texas Chicken คอมโบเซ็ต 2 ชุดใหม่! 229.-  <br>\r\n💬 ช่วงนี้ก็จะอินๆ กับเทศกาลหน่อยน้า...Texas Chicken เลยจัดชุดใหญ่มาให้ฟินๆ กัน ทุกชุด 229.- ไม่มาโดนถือว่าพลาด!<br><br><br>\r\n\r\n💕 3 ข้อต้องรู้<br>\r\n🍗 ชุดแรก Merry Texas 1 จุกมาก มีไก่ทอด 4 ชิ้น, ไก่ไม่มีกระดูก 4 ชิ้น, มันบดขนาดกลาง และช็อกโกแลตชิพบิสกิต 2 ชิ้น<br>\r\n🍗 ส่วนชุด Merry Texas 2 อิ่มพุงกางกันไปข้าง มีไก่ทอด 6 ชิ้น, มันบดขนาดกลาง, และช็อกโกแลตชิพบิสกิต 2 ชิ้น <br>\r\n🥤 คุ้มไปอีกกก! เมื่อซื้อชุด Merry Texas ชุดไหนก็ได้ รับสิทธ์แลกซื้อเครื่องดื่มแบบรีฟีล ราคาเพียง 29.- (ปกติ 49.-) อิ่มจุกๆ แบบครบเซ็ตไปเลยจ้าาา<br>\r\n\r\n⭐️ #กดติดดาวเพจปันโปรไว้นะคะจะได้ไม่พลาดโปรแรงๆจากเรา<br><br>\r\n\r\n🗓 วันนี้ - 20 ม.ค. 62 (หรือจนกว่าสินค้าจะหมด)<br>\r\n📍 Texas Chicken ทุกสาขา (ราคาอาจแตกต่างกันในบางสาขาน้า)\r\n\r\n#ปันโปร\r\n#เรื่องดีๆมีไว้แชร์\r\n#โปรโมชั่น #ลดราคา\r\n#เซล #TexasChickenTH\r\n#MerryTexas\r\n#Sale #Promotion', 'Texas Chicken ทุกสาขา (ราคาอาจแตกต่างกันในบางสาขาน้า)', 7, '2018-12-18', '2019-01-20', '91_f7c9ccefa73315a1c77c885632460e47XhpLwm54ZTck0N3qHyjAww==.jpeg', 30, 30, 91, 0, '', '2018-12-17 17:54:44', '2018-12-17 17:54:44');

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
(90, 44, '91_f7c9ccefa73315a1c77c885632460e47XhpLwm54ZTck0N3qHyjAww==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-32d247ac-49fc-49aa-ae6a-f4ee8ad557ab.tmp', '2018-12-17 17:54:44', '2018-12-17 17:54:44');

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
(36, 44, '', 'ไก่คอมโบ SET', 'BOX', 229, '2018-12-17 17:55:17', '2018-12-17 17:55:17');

-- --------------------------------------------------------

--
-- Table structure for table `subscribes`
--

CREATE TABLE `subscribes` (
  `Sub_ID` int(11) NOT NULL,
  `Sub_Email` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `subscribes`
--

INSERT INTO `subscribes` (`Sub_ID`, `Sub_Email`, `created_at`, `updated_at`) VALUES
(1, '0', '2018-12-17 17:43:20', '2018-12-17 17:43:20'),
(2, 'jirapatsintuwong@gmail.com', '2018-12-17 17:46:01', '2018-12-17 17:46:01'),
(3, 'jirapatsintuwong@gmail.com', '2018-12-17 17:46:54', '2018-12-17 17:46:54'),
(4, 'admin@mebag.com', '2018-12-17 17:47:34', '2018-12-17 17:47:34');

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
(91, 'จิรพัฒน์', 'สินธุวงศ์', 'Male', '1996-10-06', '0882328949', 'jirapatsintuwong@gmail.com', '172 จันทร์แก้ว2 หมู่ 2', '$2a$10$H.LpferFop0WRQBgJqCdKesZO2qnh8DXHh0VJqB/VJIxNxzKO3c2C', '1', '91_bc200b716f03e48d1533028a79faee9fxVCYpFZXsmRnJHqwtMETMg==.jpeg', 'สวัสดีจ้า ♥', 0, '2018-12-17 16:53:27', '2018-12-17 18:12:09');

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
(14, 91, 'กรุงไทย', '12345678901234', '91_74ecb27f1a02f80db2a75b6ff98a3f84SyB2g+2dQ1vj1RJzvCnKvg==.jpeg', '91_bb961a6f4f872aacd424e57aae240e6bmOR/39NsPvZbvhR0e0rOGQ==.jpeg', '1559900314909', '2018-12-17 16:53:27', '2018-12-17 17:50:58');

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
-- Indexes for table `subscribes`
--
ALTER TABLE `subscribes`
  ADD PRIMARY KEY (`Sub_ID`);

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
  MODIFY `Balance_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `Event_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `event_images`
--
ALTER TABLE `event_images`
  MODIFY `Img_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `Order_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `Detail_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `Payment_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `Product_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `subscribes`
--
ALTER TABLE `subscribes`
  MODIFY `Sub_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `verifies`
--
ALTER TABLE `verifies`
  MODIFY `Verify_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
