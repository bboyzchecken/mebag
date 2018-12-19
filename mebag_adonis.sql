-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 19, 2018 at 08:41 PM
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
(4, 9, 10, '2018-12-19 17:12:08', '2018-12-19 17:12:08'),
(5, 10, 15, '2018-12-19 19:05:15', '2018-12-19 19:05:15'),
(6, 11, 300, '2018-12-19 19:15:44', '2018-12-19 19:15:44'),
(7, 13, 300, '2018-12-19 19:20:13', '2018-12-19 19:20:13');

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
(48, 'Adidas ลด 50 %', '🎒#Adidas #เป้ไซซ์มินิ #สีม่วงพาสเทล\r\n💬 งู้ยยย~ แพ้ความพาสเทลแบบเน้...ขนาดกระทัดรัดกำลังดี เห็นใบเล็กๆ แบบนี้ แต่ใส่ของได้จุอยู่นะ จะสะพายหรือถือคือได้หมด จิ๋วแต่แจ๋วสุดๆ ใบละ 1,800.- ช้อปครบทุก 1,000.- รับทันที! Gift Voucher มูลค่า 100.- จ้าาาา ดี๊ดีอ่ะ!', 'Shop Adidas ทุกสาขา ', 4, '2018-12-19', '2018-12-31', '96_30abc5193f254a3041af1392a9c36888r63Q5Q2IZEtjB/veoAwObA==.jpeg', 100, 50, 96, 0, '', '2018-12-19 18:39:36', '2018-12-19 18:39:36'),
(49, 'Loft The World of Ultimate Gifts 2019 Pop up', '💬 ช่วงเทศกาลแบบนี้ ใครกำลังมองหาของขวัญจับฉลากขอให้พุ่งมาที่งานนี้ด่วนๆ เลยค่า ~ #มีบริการห่อของขวัญด้วยนะ\r\n❤️ 3 ข้อต้องรู้ \r\n😍 งานนี้จัดเต็มมากๆ เพราะเค้าขนสินค้ามาให้เลือกเยอะสุดๆ มีทั้งตุ๊กตา หมอน ผ้าห่ม ของใช้สำนักงานแบบเก๋ๆ เพียบ!!\r\n🥳 ที่สำคัญสินค้าลิขสิทธิ์อย่าง Moomin Webearbears และ Warbie ก็ลดสูงสุดถึง 20 % เลยน้าาา ~\r\n😘 พิเศษ! ลูกค้าที่ช้อปครบ 800.- จะได้รับคูปองส่วนลด 80.- (สามารถนำมาใช้ได้ในการซื้อครั้งถัดไป) หากช้อปครบ 1,200.- รับฟรีไปเลย ถังอเนกประสงค์ หรือ Light Pen Case (เลือกได้แค่หนึ่งชิ้นเท่านั้นนะ)', 'Amarin Plaza', 3, '2018-12-20', '2018-12-31', '96_0fe7e8fc3d3ac7ced17fe6da4ec21d5dlmqgV4eBZ2T9KPwEldvACA==.jpeg', 50, 50, 96, 0, '', '2018-12-19 18:43:01', '2018-12-19 18:57:34'),
(50, 'Tsuruha รวมเซ็ตของขวัญ', '💬 เทศกาลซื้อของขวัญใกล้เข้ามาแล้ว...ใครยังหาของขวัญไม่ได้แวะมาที่ซูรูฮะเลยจ้าา เซ็ตของขวัญน่าซื้อ ราคาหลักร้อยมาเพียบ!\r\n\r\n💖 3 ข้อต้องรู้\r\n👏🏻 แต่ละเซ็ตบอกเลยควรค่าแก่การซื้อเป็นของขวัญมากอ่ะ แถมราคาไม่แรงด้วย เริ่มต้น 299.- เท่านั้น คุ้มสุดๆ\r\n✨ มีตั้งแต่เซ็ตบำรุงผิวหน้า บำรุงผิวกาย ไปจนถึงเซ็ตอาหารเสริมบำรุงร่างกายกันเลยจ้าา\r\n🎉 นอกจากเซ็ตของขวัญราคาน่าซื้อแล้ว ยังมีโปรแน่นๆ อีกเพียบ! ทั้งซื้อ 1 แถม 1 / ซื้อ 2 แถม 1 ไปค่ะซิสสส รีบตุนด่วนนน!', 'Tsuruha ทุกสาขา', 2, '2018-12-20', '2019-01-31', '96_472ef72d785f26756faaabe3eab542869ymNsy5kU/rDGtg2SZY97w==.jpeg', 100, 50, 96, 0, '', '2018-12-19 18:44:49', '2018-12-19 18:44:49'),
(51, '? #Nike #ลดเพิ่ม30% #ShowDC ', '💬 ไม่พูดเยอะเนอะ...ใครไปก่อนได้ก่อนนะ รอบนี้รุ่นสวยๆ มีเยอะเลย รองเท้าแตะเริ่มต้น 400+ อ่ะ ส่วนผ้าใบรอบนี้รุ่นสวยๆ มีเพียบ อย่าง cortez เหลือ 1,890.-เอง(ปกติ 3,100.-) โอ้ยยยย แต่ของจะสลับเปลี่ยนไปแต่ละอาทิตย์นะ รีบเลย!', 'Nike Factory Store ชั้น 3 @Show DC', 5, '2018-12-20', '2018-12-31', '96_b6ffc8335cbd006847748954b62dbd57Ds+vdmhjxMGel3oMgnVHVA==.jpeg', 150, 50, 96, 0, '', '2018-12-19 18:46:51', '2018-12-19 18:57:47'),
(52, 'Bake A Wish กระเช้าคุ้กกี้แทนใจ ', '💬 ใครกำลังมองหาของขวัญคริสต์มาส ปีใหม่ ต้องนี่เลยจ้าา กระเช้าคุ้กกี้ น่ารักก แถมกินได้ด้วยย!!\r\n\r\n🌈 3 ข้อต้องรู้\r\n🎉 กระเช้าคุ้กกี้มีให้เลือกหลายแบบเลยน้าา ตั้งแต่แบบเล็กๆ น่ารักกุ๊กกิ๊ก เริ่มต้น 170.- ไปจนถึงกระเช้าใหญ่อลังการเลยจ้าาา!!\r\n🍪 คุ้กกี้ในกระเช้า มีตั้ง 3 รสชาติเลย! ทั้งช็อกโกแลตชิพ ชาเขียว แยมสตรอว์เบอว์รี่ ว้าววว น่ากินนน และยังเก็บได้นาน 1 เดือนเลยนะ เพราะตะกร้ากับคุ้กกี้ผลิตแค่ช่วงเทศกาลเท่านั้นค่าา รีบมาสั่งกัน~\r\n🚗 นอกจากนั้นยังมีบริการส่งด้วยน้า ซื้อครบ 5,000.- ขึ้นไป ส่งฟรีไปเลยจ้าา และซื้อครบ 600.- ขึ้นไป บริการส่งทั่วกรุงเทพฯ ปริมณฑล (คิดค่าจัดส่งตามระยะทางน้า) หรือสามารถสั่งและรับสินค้าตะกร้าได้ทุกสาขาของเลยค่า', 'Bake A Wish ทุกสาขา ', 7, '2018-12-29', '2018-12-31', '96_47dd752bc238eb962bc8479ead968a3dzcseVhoF4uPfwdepE5hcdw==.jpeg', 150, 50, 96, 0, '', '2018-12-19 18:49:39', '2018-12-19 18:57:53'),
(53, 'I Phone XR', 'IPhone XR สี Coral ราคา 29,900.-', 'Apple Store ทุกสาขา', 1, '2018-12-18', '2018-12-29', '96_0070b30e795630901ade86e77b0f87baQsv+1tV0fBHHVzfZixvO6A==.jpeg', 300, 50, 96, 0, '', '2018-12-19 18:55:53', '2018-12-19 18:55:53');

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
(96, 48, '96_30abc5193f254a3041af1392a9c36888r63Q5Q2IZEtjB/veoAwObA==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-ce3e5745-7610-49ed-baf6-d9325d9961b9.tmp', '2018-12-19 18:39:36', '2018-12-19 18:39:36'),
(97, 49, '96_0fe7e8fc3d3ac7ced17fe6da4ec21d5dlmqgV4eBZ2T9KPwEldvACA==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-9ca267ea-14ed-4b82-b3b7-6343a00c154d.tmp', '2018-12-19 18:43:01', '2018-12-19 18:43:01'),
(98, 50, '96_472ef72d785f26756faaabe3eab542869ymNsy5kU/rDGtg2SZY97w==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-9a14a68e-700c-49e2-95e7-c71799303cde.tmp', '2018-12-19 18:44:49', '2018-12-19 18:44:49'),
(99, 51, '96_b6ffc8335cbd006847748954b62dbd57Ds+vdmhjxMGel3oMgnVHVA==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-ec05ddf2-0fdf-468a-b258-975c6c6b9155.tmp', '2018-12-19 18:46:51', '2018-12-19 18:46:51'),
(100, 52, '96_47dd752bc238eb962bc8479ead968a3dzcseVhoF4uPfwdepE5hcdw==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-ca676511-3903-4410-9ce2-a5da46ebdded.tmp', '2018-12-19 18:49:39', '2018-12-19 18:49:39'),
(101, 52, '96_4acdbf028244c8ddd847ce690fdd9c02mCEHgJSpDAB2xS+DMMZw0g==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-3cfc480c-6eeb-4907-906f-53893f8ec1f6.tmp', '2018-12-19 18:51:15', '2018-12-19 18:51:15'),
(102, 52, '96_f0751d5291da7f123f5fdf48f7313bac3lxCaA/Z6trCamboU3DHCA==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-816884b5-9141-482d-9e06-e8c0649604ba.tmp', '2018-12-19 18:51:15', '2018-12-19 18:51:15'),
(103, 51, '96_b75d393be5fd509f4a83e75e0b27de78GC+LpBydEB+3ITTY5CP4xQ==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-98d234f0-a821-4a52-8d54-bbd2a02962f2.tmp', '2018-12-19 18:51:38', '2018-12-19 18:51:38'),
(104, 51, '96_5c4ec73e66601f44d877542ac0f7b7a1Yrd3Cr3V+8JyadeTAcaxmw==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-fc914d37-58af-4230-830a-3dce64f78e83.tmp', '2018-12-19 18:51:38', '2018-12-19 18:51:38'),
(105, 50, '96_9a08be5278b97adaabeed9a6971c8502inngd9PD6OmmlkGQXeYYIw==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-2c8174fb-4d20-4f46-b4be-706b991add98.tmp', '2018-12-19 18:52:05', '2018-12-19 18:52:05'),
(106, 50, '96_e57a8d18898f52f256e7d6349c38323dQSl3Z5uOgaWLpCIvEhrmFg==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-7ffab73f-496e-43ce-a2f9-bde5299c1f3e.tmp', '2018-12-19 18:52:05', '2018-12-19 18:52:05'),
(107, 49, '96_98792cf3ddf0ad7dcac3af5e064e2f47L0fgzI1PsEESyCJ064lvbQ==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-07b93d2b-6369-4da0-9f39-92d07c5744d0.tmp', '2018-12-19 18:52:42', '2018-12-19 18:52:42'),
(108, 49, '96_9bb59da33bdfccc4cbba81021d7acc3aNBtI8VQPeaD5+k8arWaz6Q==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-18891744-9c8e-479d-9a16-f013bdf9e222.tmp', '2018-12-19 18:52:42', '2018-12-19 18:52:42'),
(109, 53, '96_0070b30e795630901ade86e77b0f87baQsv+1tV0fBHHVzfZixvO6A==.jpeg', 'C:\\Users\\checken\\AppData\\Local\\Temp\\ab-77886b0c-b784-4e8b-a8a9-d17d5f01c214.tmp', '2018-12-19 18:55:53', '2018-12-19 18:55:53');

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
(9, 96, '96', 47, 'MINON แผ่นมาร์กหน้าเนื้อเจล', '100', '60', '500', 660, 'success', '19-12-2018', '5', 'EV 1515455451 TH', '2018-12-19 16:42:40', '2018-12-19 17:12:08'),
(10, 97, '96', 52, 'Bake A Wish กระเช้าคุ้กกี้แทนใจ ', '150', '50', '1200', 1400, 'success', '20-12-2018', '6', 'EV 1515455451 TH', '2018-12-19 19:03:05', '2018-12-19 19:05:15'),
(11, 91, '96', 53, 'I Phone XR', '3000', '500', '299000', 302500, 'success', '20-12-2018', '7', 'EV1515455451TH', '2018-12-19 19:07:54', '2018-12-19 19:15:44'),
(12, 91, '96', 50, 'Tsuruha รวมเซ็ตของขวัญ', '1400', '700', '4186', 6286, 'reject', '20-12-2018', '', '', '2018-12-19 19:17:06', '2018-12-19 19:17:19'),
(13, 91, '96', 53, 'I Phone XR', '3000', '500', '299000', 302500, 'success', '20-12-2018', '8', 'EV1515455451TH', '2018-12-19 19:17:52', '2018-12-19 19:20:13');

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
(9, 9, '38', 'Malissa Kiss', 'ไซส์ eur42.5 ยาว 27 cm. (สีชมพู)', '500', '1', '2018-12-19 16:42:40', '2018-12-19 16:42:40'),
(10, 10, '43', 'กระเช้าคุ้กกี้แทนใจ', '-', '1200', '1', '2018-12-19 19:03:05', '2018-12-19 19:03:05'),
(11, 11, '44', 'I phone XR', '-', '29900', '10', '2018-12-19 19:07:54', '2018-12-19 19:07:54'),
(12, 12, '41', 'เซ็ตเฟเชียลคลีนซิ่ง', '-', '299', '14', '2018-12-19 19:17:06', '2018-12-19 19:17:06'),
(13, 13, '44', 'I phone XR', '-', '29900', '10', '2018-12-19 19:17:52', '2018-12-19 19:17:52');

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
(5, 9, 'Medium', 'กรุงไทย(KTB)', '04:14', '2018-12-08', '660', '', '96', '96_2f877785647fd9dcaf81963c279d4504zGCz0T8fzIJ6ItiM1Cl36w==.jpeg', 'accept'),
(6, 10, 'Medium', 'กรุงไทย(KTB)', '18:08', '2018-12-28', '778', '', '97', '97_c09317316a015cfe2a55f2dcdbad7b620ZxzW6sYumzMMfOxSPKkGw==.jpeg', 'accept'),
(7, 11, 'Medium', ' กสิกรไทย(KBank)', '02:14', '2018-12-20', ' 302500', '', '91', '91_5c449fd963b8ccdaaf5faeb18ce8a2c9zBrqaVsVDHM8SrhMsbtupQ==.jpeg', 'accept'),
(8, 13, 'Medium', 'กรุงไทย(KTB)', '21:21', '132132-03-21', '213213213213213', '', '91', '91_2a95d46f7a60b6dbbccdbe053a8e9583XgotzsE9X5SiJaBmpS4Vbg==.jpeg', 'accept');

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
(38, 47, '', 'Malissa Kiss', 'ไซส์ eur42.5 ยาว 27 cm. (สีชมพู)', 500, '2018-12-19 16:42:20', '2018-12-19 16:42:20'),
(39, 48, '', 'เป้ Adidas ไซซ์มินิ', 'สีฟ้าอ่อน', 1800, '2018-12-19 18:40:19', '2018-12-19 18:40:19'),
(40, 49, '', 'ตุ๊กตาน้องหมู', 'สีชมพู', 250, '2018-12-19 18:43:25', '2018-12-19 18:43:25'),
(41, 50, '', 'เซ็ตเฟเชียลคลีนซิ่ง', '-', 299, '2018-12-19 18:45:40', '2018-12-19 18:45:40'),
(42, 51, '', 'Nike vapormax', 'ไซส์ eur42.5 ยาว 27 cm.', 5390, '2018-12-19 18:47:30', '2018-12-19 18:47:30'),
(43, 52, '', 'กระเช้าคุ้กกี้แทนใจ', '-', 1200, '2018-12-19 18:50:14', '2018-12-19 18:50:14'),
(44, 53, '', 'I phone XR', '-', 29900, '2018-12-19 18:56:18', '2018-12-19 18:56:18');

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
(2, 91, '97_8322917b5403b731142d5c7ebaf28b689SEdx7YjMcGfIKpWPYrVrQ==.jpeg', '666', '17/12/2018', '9.50', '5456', 1, '2018-12-19 19:02:38', '2018-12-19 19:02:38'),
(3, 96, '96_734cfa71f6b3beab12720bbd2e23dbeb/Aco1GAZiWZqcrG9k57GQQ==.jpeg', '606435', '20/12/2018', '9.50', '5456', 1, '2018-12-19 19:23:50', '2018-12-19 19:23:50');

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
(1, '2018-12-20', '2018-12-19 15:19:20', '2018-12-19 15:19:20'),
(2, '2018-12-20', '2018-12-19 19:21:04', '2018-12-19 19:21:04');

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
(91, 'จิรพัฒน์', 'สินธุวงศ์', 'Male', '1996-10-06', '0882328949', 'jirapatsintuwong@gmail.com', '172 จันทร์แก้ว2 หมู่ 2', '$2a$10$4PR.hIFK.W9qBLy68pUIOuNykPGTtDwbk1lVUgo9.2sxsmLA3IMG6', '1', '91_bc200b716f03e48d1533028a79faee9fxVCYpFZXsmRnJHqwtMETMg==.jpeg', 'สวัสดีจ้า ♥', 0, '2018-12-17 16:53:27', '2018-12-19 19:02:38'),
(92, 'Davit', 'Sanpote', 'Male', '2222-02-22', '22222222', 'sanpotedavit@gmail.com', '45454 ', '$2a$10$wKCnhhzBAbeP4By4QjMXd.AiTk1AtlsX1ESR.vWVOq7bjYxNWs1OK', '1', '0', '', 990, '2018-12-18 06:19:51', '2018-12-19 16:23:20'),
(93, 'Davit02', 'Sanpote02', 'Male', '3333-11-12', '33333', 'davit.sa@up.ac.th', '1235456', '$2a$10$wKCnhhzBAbeP4By4QjMXd.AiTk1AtlsX1ESR.vWVOq7bjYxNWs1OK', '0', '0', '', 0, '2018-12-18 06:29:56', '2018-12-19 16:23:20'),
(94, 'Bboyz', 'CHECKEN', 'Male', '2018-12-19', '0882328949', 'testcase@gmail.com', '172 จันทร์แก้ว2 หมู่ 2', '$2a$10$wKCnhhzBAbeP4By4QjMXd.AiTk1AtlsX1ESR.vWVOq7bjYxNWs1OK', '1', '0', '', 0, '2018-12-19 05:16:30', '2018-12-19 16:23:20'),
(95, 'testcase1', 'testcase1', 'Male', '2018-12-19', '0882328949', 'testcase1@mebag.com', '172 จันทร์แก้ว2 หมู่ 2', '$2a$10$wKCnhhzBAbeP4By4QjMXd.AiTk1AtlsX1ESR.vWVOq7bjYxNWs1OK', '0', '0', '', 0, '2018-12-19 14:07:29', '2018-12-19 16:23:20'),
(96, 'nuttaporn', 'Phanyingyok', 'Female', '2018-12-08', '000000000', 'Test1@hotmail.com', '', '$2a$10$543luZptGgU7WiQ34YUNEeHRTk8mNE9FziV6YDyuudpA3HGa0xK/O', '1', '96_3b2028ada32509a6f7160a1836d11aa5YKTgjvQXd8v8slvGOPOetQ==.jpeg', 'สวัสดีจ้า', 0, '2018-12-19 16:29:05', '2018-12-19 19:23:50'),
(97, 'Nuttaporn', 'Phanyingyok', 'Female', '1997-08-11', '0981240931', 'qnutnuttaporn@gmail.com', '222/14 หมู่บ้านเอ็มเพอร์เร่อ 2\r\nต.ฟ้าฮ่าม อ.เมือง จ.เชียงใหม่ 50000', '$2a$10$PT0NDF/V8zrg0qDgsZzcHegqe1rsj9ycChrhykYLeDGs1bKZvZTOG', '1', '97_e33d84b0f37f2e87d487089744eeda61dsuamC0Zkt6mbO7EFmZAvg==.jpeg', '', 0, '2018-12-19 18:29:52', '2018-12-19 18:36:15');

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
(14, 91, 'กรุงไทย', '12345678901234', '91_74ecb27f1a02f80db2a75b6ff98a3f84SyB2g+2dQ1vj1RJzvCnKvg==.jpeg', '91_bb961a6f4f872aacd424e57aae240e6bmOR/39NsPvZbvhR0e0rOGQ==.jpeg', '1559900314909', '2018-12-17 16:53:27', '2018-12-17 17:50:58'),
(15, 92, 'SCA', '1111111111111', '92_c610663602f9cc4933f69196bc5372e9ELY31CseNN6y6S+eHL/mww==.jpeg', '92_3e4cce29fd011d802a1cf5c2bcd769beJLkHDBNOv/hL5IjNUGFTGw==.png', '16586456868', '2018-12-18 06:19:51', '2018-12-18 06:21:43'),
(16, 93, '', '', '', '', '', '2018-12-18 06:29:56', '2018-12-18 06:29:56'),
(17, 94, 'กรุงไทย', '12345678901234', '94_847c8d02261673fe18794ba7c362b7cdRTZfKdjK3pPZPPIJTIi8kA==.jpeg', '94_9369c4632a7440d8dbb503d6a441f543WmUFQm+RCKHHTmw1lzEgYw==.jpeg', '1559900314909', '2018-12-19 05:16:30', '2018-12-19 05:16:56'),
(18, 95, '', '', '', '', '', '2018-12-19 14:07:29', '2018-12-19 14:07:29'),
(19, 96, 'กรุงไทย', '1215483215452', '96_f32fcc41850b78e09e969f2e631c30f5fq2izVEfQ2ayLANG7hC+bQ==.jpeg', '96_c34ac94b1ac70e72da5ec14cf1b7f564LI9eavly9a/DqObPHiMpDA==.jpeg', '1034567891012', '2018-12-19 16:29:05', '2018-12-19 16:29:29'),
(20, 97, 'กรุงไทย', '1215483215452', '97_740b689272ef4834e7dabcd2486a2da34U3lvEBbOWcHBprUS0OhCg==.jpeg', '97_9b48bf4a0466d22138ecb909edc5a577RGYk5X2CdQhLawYaEECjBA==.jpeg', '1579900745597', '2018-12-19 18:29:52', '2018-12-19 18:35:37');

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
  MODIFY `Event_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `event_images`
--
ALTER TABLE `event_images`
  MODIFY `Img_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `Order_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `Detail_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `Payment_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `Product_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `subscribes`
--
ALTER TABLE `subscribes`
  MODIFY `Sub_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tranfers`
--
ALTER TABLE `tranfers`
  MODIFY `Tranfer_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tranfer_date`
--
ALTER TABLE `tranfer_date`
  MODIFY `Date_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `verifies`
--
ALTER TABLE `verifies`
  MODIFY `Verify_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
