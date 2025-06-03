-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2025 at 09:30 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medibook_ecoms`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_address_info`
--

CREATE TABLE `account_address_info` (
  `address_id` int(11) NOT NULL,
  `house_no` varchar(100) NOT NULL,
  `street` varchar(50) NOT NULL,
  `barangay` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `province` varchar(50) NOT NULL,
  `region` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account_address_info`
--

INSERT INTO `account_address_info` (`address_id`, `house_no`, `street`, `barangay`, `city`, `province`, `region`) VALUES
(1, '050', '050', 'Jasaan', 'Santa Cruz (Capital)', 'Laguna', 'Region IV-A (CALABARZON)'),
(2, '454', 'Blk 8 Lot', 'Bagumbayan', 'Santa Cruz (Capital)', 'Laguna', 'Region IV-A (CALABARZON)'),
(3, '1', 'Blk 9 Lot', 'Jasaan', 'Santa Cruz (Capital)', 'Laguna', 'Region IV-A (CALABARZON)'),
(4, '13', 'Blk 3 Lot', 'Malinao', 'Santa Cruz (Capital)', 'Laguna', 'Region IV-A (CALABARZON)');

-- --------------------------------------------------------

--
-- Table structure for table `account_business_info`
--

CREATE TABLE `account_business_info` (
  `business_id` int(11) NOT NULL,
  `business_name` varchar(100) NOT NULL,
  `permit_no` varchar(50) NOT NULL,
  `issue_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `business_location` varchar(100) NOT NULL,
  `permit_pic` varchar(299) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account_business_info`
--

INSERT INTO `account_business_info` (`business_id`, `business_name`, `permit_no`, `issue_date`, `expiry_date`, `business_location`, `permit_pic`) VALUES
(1, 'books store', 'BP-2024-0155', '2025-07-18', '2027-02-23', '', '0_o0GqfecglzWdgaQMhXaw_uptrend.png');

-- --------------------------------------------------------

--
-- Table structure for table `account_contact_info`
--

CREATE TABLE `account_contact_info` (
  `contact_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account_contact_info`
--

INSERT INTO `account_contact_info` (`contact_id`, `email`, `phone`) VALUES
(1, 'ejseno3@gmail.com', '09689239847'),
(2, 'laranomaczeon@gmail.com', '09203735159'),
(3, 'laranozeon@gmail.com', '09352235950'),
(4, 'cherubssss412@gmail.com', '09914826781');

-- --------------------------------------------------------

--
-- Table structure for table `account_login_info`
--

CREATE TABLE `account_login_info` (
  `login_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(299) NOT NULL,
  `user_role` enum('Buyer','Seller','Admin','Courier') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account_login_info`
--

INSERT INTO `account_login_info` (`login_id`, `username`, `password`, `user_role`) VALUES
(1, 'ejseno3@gmail.com', 'scrypt:32768:8:1$7sFMGVzbxqmlnVfB$92bce4089326a49d600b833401b421196e1f24feb83d74eb5d470cb477f3c00971f66a4255aaa3a0015b743e5f07eb7e9138802fbf8ce0caae24d632f7392524', 'Admin'),
(2, 'laranomaczeon@gmail.com', 'scrypt:32768:8:1$nR805tUyCasGZjuK$354b56c72af1ced4d4cdd2028b4d99548030e40e2b90ef83ec23e8bc45f6f9e8ebebdbd2b1051b79a05be3bf31ff379047d70ef6fd617e0c4b10507d88095494', 'Buyer'),
(3, 'laranozeon@gmail.com', 'scrypt:32768:8:1$MpfdkF9hvywrdwkD$508e646597c4698b1b5c5752b71178d776ae7a05bbc4a4df04742531ce3fc948f964da6d3a2237cb5dce2ae1b88fa124bda624d2760fdbf6b1aafacbcebf54ff', 'Seller'),
(4, 'cherubssss412@gmail.com', 'scrypt:32768:8:1$ygSOIojX85aWcYac$bf4d608991f25b95a05b6a1cb0c88cb9cd615bb209a7491ffc06a01b13472808ae79a55540b986f7f3134fde094b0db183ba2f76ef4acf8ea5818ebf545fb14c', 'Courier');

-- --------------------------------------------------------

--
-- Table structure for table `account_personal_info`
--

CREATE TABLE `account_personal_info` (
  `personal_id` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `sex` enum('Male','Female') NOT NULL,
  `age` int(11) NOT NULL,
  `birthdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account_personal_info`
--

INSERT INTO `account_personal_info` (`personal_id`, `firstname`, `lastname`, `sex`, `age`, `birthdate`) VALUES
(1, 'Erroll', 'seno', 'Male', 22, '2003-06-01'),
(2, 'zeon', 'larano', 'Male', 20, '2004-06-25'),
(3, 'zeons', 'laranoss', 'Male', 24, '2001-04-29'),
(4, 'zeons', 'tagadeliver', 'Male', 25, '2000-01-19');

-- --------------------------------------------------------

--
-- Table structure for table `account_valid_info`
--

CREATE TABLE `account_valid_info` (
  `valid_id` int(11) NOT NULL,
  `id_type` varchar(50) NOT NULL,
  `id_no` varchar(50) NOT NULL,
  `id_pic` varchar(299) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account_valid_info`
--

INSERT INTO `account_valid_info` (`valid_id`, `id_type`, `id_no`, `id_pic`) VALUES
(1, 'Driver\'s License', 'DL9051231542', 'NlDkSj6sOzXHbhTUYiWBuA_dl_man.jpg'),
(2, 'PhilHealth', 'PH 7523934', 'd4ZNNBU3l62HW6sUVSEnRA_postal_woman.jpg'),
(3, 'Birth Certificate', 'asdaddasa12341', 'QTXeH-DvlA88quTbWTPWng_dl_man.jpg'),
(4, 'Driver\'s License', 'DL13213124', 'OEuhT0gIXaoybNbLapwFAA_dl_man.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `admin_order_commission`
--

CREATE TABLE `admin_order_commission` (
  `commission_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `commission_rate` decimal(10,2) NOT NULL DEFAULT 8.00,
  `commission_amount` decimal(10,2) NOT NULL CHECK (`commission_amount` >= 0),
  `status` enum('Pending','Paid') NOT NULL DEFAULT 'Pending',
  `date_generated` datetime NOT NULL DEFAULT current_timestamp(),
  `date_paid` datetime DEFAULT NULL,
  `rate_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_order_commission`
--

INSERT INTO `admin_order_commission` (`commission_id`, `order_id`, `seller_id`, `commission_rate`, `commission_amount`, `status`, `date_generated`, `date_paid`, `rate_id`) VALUES
(1, 5, 3, 8.00, 3680.00, 'Pending', '2025-06-02 02:17:41', NULL, NULL),
(2, 5, 4, 8.00, 9.60, 'Pending', '2025-06-02 02:17:41', NULL, NULL),
(3, 6, 3, 8.00, 1840.00, 'Pending', '2025-06-02 03:25:44', NULL, NULL),
(4, 6, 4, 8.00, 9.60, 'Pending', '2025-06-02 03:25:44', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admin_sales`
--

CREATE TABLE `admin_sales` (
  `sales_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` enum('Seller','Courier') DEFAULT NULL,
  `order_id` int(11) NOT NULL,
  `total_sales` decimal(10,2) NOT NULL CHECK (`total_sales` >= 0),
  `date_generated` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_sales`
--

INSERT INTO `admin_sales` (`sales_id`, `admin_id`, `user_id`, `user_type`, `order_id`, `total_sales`, `date_generated`) VALUES
(1, 1, 3, 'Seller', 5, 3680.00, '2025-06-02 02:17:41'),
(2, 1, 4, 'Courier', 5, 9.60, '2025-06-02 02:17:41'),
(3, 1, 3, 'Seller', 6, 1840.00, '2025-06-02 03:25:44'),
(4, 1, 4, 'Courier', 6, 9.60, '2025-06-02 03:25:44');

-- --------------------------------------------------------

--
-- Table structure for table `buyer_cart`
--

CREATE TABLE `buyer_cart` (
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL CHECK (`quantity` > 0),
  `total_amount` decimal(10,2) NOT NULL CHECK (`total_amount` >= 0),
  `status` enum('On cart','Checked Out') NOT NULL DEFAULT 'On cart',
  `date_added` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buyer_cart`
--

INSERT INTO `buyer_cart` (`cart_id`, `product_id`, `buyer_id`, `quantity`, `total_amount`, `status`, `date_added`) VALUES
(1, 1, 2, 1, 24.00, 'Checked Out', '2025-06-02 01:16:47'),
(2, 1, 2, 20, 480.00, 'Checked Out', '2025-06-02 01:41:46'),
(5, 1, 2, 11, 264.00, 'Checked Out', '2025-06-02 01:51:26'),
(6, 2, 2, 10, 12340.00, 'Checked Out', '2025-06-02 02:00:06'),
(7, 3, 2, 2, 46000.00, 'Checked Out', '2025-06-02 02:16:13'),
(9, 3, 2, 1, 23000.00, 'Checked Out', '2025-06-02 03:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `buyer_like`
--

CREATE TABLE `buyer_like` (
  `like_id` int(11) NOT NULL,
  `product_info_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `status` enum('Liked','Unliked') NOT NULL DEFAULT 'Liked',
  `date_liked` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buyer_like`
--

INSERT INTO `buyer_like` (`like_id`, `product_info_id`, `buyer_id`, `status`, `date_liked`) VALUES
(6, 1, 1, 'Liked', '2025-06-02 02:42:23'),
(7, 3, 2, 'Liked', '2025-06-02 03:21:15');

-- --------------------------------------------------------

--
-- Table structure for table `buyer_order`
--

CREATE TABLE `buyer_order` (
  `order_id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL CHECK (`quantity` > 0),
  `total_amount` decimal(10,2) NOT NULL CHECK (`total_amount` >= 0),
  `payment_method` enum('Cash on Delivery') NOT NULL,
  `payment_status` enum('Unpaid','Paid') NOT NULL DEFAULT 'Unpaid',
  `status` enum('Pending','To Pack','Packed','Shipping','Shipped','For Delivery','Out for Delivery','Delivered','Received','Rejected') NOT NULL DEFAULT 'Pending',
  `date_ordered` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buyer_order`
--

INSERT INTO `buyer_order` (`order_id`, `shop_id`, `seller_id`, `product_id`, `buyer_id`, `quantity`, `total_amount`, `payment_method`, `payment_status`, `status`, `date_ordered`) VALUES
(1, 1, 3, 1, 2, 1, 67.00, 'Cash on Delivery', 'Unpaid', 'Pending', '2025-06-02 01:19:35'),
(2, 1, 3, 1, 2, 20, 523.00, 'Cash on Delivery', 'Unpaid', 'Pending', '2025-06-02 01:49:28'),
(3, 1, 3, 1, 2, 11, 307.00, 'Cash on Delivery', 'Unpaid', 'Pending', '2025-06-02 01:59:50'),
(4, 1, 3, 2, 2, 10, 12362.00, 'Cash on Delivery', 'Unpaid', 'Pending', '2025-06-02 02:00:17'),
(5, 1, 3, 3, 2, 2, 46120.00, 'Cash on Delivery', 'Paid', 'Received', '2025-06-02 02:16:21'),
(6, 1, 3, 3, 2, 1, 23120.00, 'Cash on Delivery', 'Paid', 'Received', '2025-06-02 03:24:34');

-- --------------------------------------------------------

--
-- Table structure for table `courier_sales`
--

CREATE TABLE `courier_sales` (
  `sales_id` int(11) NOT NULL,
  `courier_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `sale` decimal(10,2) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courier_sales`
--

INSERT INTO `courier_sales` (`sales_id`, `courier_id`, `order_id`, `sale`, `date_created`) VALUES
(1, 4, 5, 110.40, '2025-06-02 02:17:41'),
(2, 4, 6, 110.40, '2025-06-02 03:25:44');

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_type` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`id`, `user_id`, `email`, `ip_address`, `user_type`, `status`, `timestamp`) VALUES
(1, 2, 'laranomaczeon@gmail.com', '127.0.0.1', 'Buyer', 'success', '2025-06-01 22:08:59'),
(2, NULL, 'laranozeon@gmail.com', '127.0.0.1', NULL, 'failed', '2025-06-01 22:15:47'),
(3, 3, 'laranozeon@gmail.com', '127.0.0.1', 'Seller', 'success', '2025-06-01 22:16:00'),
(4, 1, 'ejseno3@gmail.com', '127.0.0.1', 'Admin', 'success', '2025-06-01 22:16:32'),
(5, 3, 'laranozeon@gmail.com', '127.0.0.1', 'Seller', 'success', '2025-06-01 22:17:39'),
(6, 1, 'ejseno3@gmail.com', '127.0.0.1', 'Admin', 'success', '2025-06-01 22:20:58'),
(7, 4, 'cherubssss412@gmail.com', '127.0.0.1', 'Courier', 'success', '2025-06-01 22:21:37'),
(8, 1, 'ejseno3@gmail.com', '127.0.0.1', 'Admin', 'success', '2025-06-01 22:21:56'),
(9, 4, 'cherubssss412@gmail.com', '127.0.0.1', 'Courier', 'success', '2025-06-01 22:22:38'),
(10, 2, 'laranomaczeon@gmail.com', '127.0.0.1', 'Buyer', 'success', '2025-06-01 22:35:58'),
(11, NULL, 'laranozeon@gmail.com', '127.0.0.1', NULL, 'failed', '2025-06-01 23:23:21'),
(12, 3, 'laranozeon@gmail.com', '127.0.0.1', 'Seller', 'success', '2025-06-01 23:23:30'),
(13, 2, 'laranomaczeon@gmail.com', '127.0.0.1', 'Buyer', 'success', '2025-06-01 23:59:14'),
(14, 1, 'ejseno3@gmail.com', '127.0.0.1', 'Admin', 'success', '2025-06-02 00:11:34'),
(15, 4, 'cherubssss412@gmail.com', '127.0.0.1', 'Courier', 'success', '2025-06-02 00:18:10'),
(16, NULL, 'laranozeon@gmail.com', '127.0.0.1', NULL, 'failed', '2025-06-02 00:25:35'),
(17, 3, 'laranozeon@gmail.com', '127.0.0.1', 'Seller', 'success', '2025-06-02 00:25:44'),
(18, 4, 'cherubssss412@gmail.com', '127.0.0.1', 'Courier', 'success', '2025-06-02 02:17:18'),
(19, 2, 'laranomaczeon@gmail.com', '127.0.0.1', 'Buyer', 'success', '2025-06-02 02:58:59'),
(20, 3, 'laranozeon@gmail.com', '127.0.0.1', 'Seller', 'success', '2025-06-02 03:07:34'),
(21, 4, 'cherubssss412@gmail.com', '127.0.0.1', 'Courier', 'success', '2025-06-02 03:08:10');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `status` enum('Sent','Delivered','Read') DEFAULT 'Sent',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `notification_type` varchar(100) NOT NULL,
  `notification_title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `status` enum('Unread','Read') DEFAULT 'Unread',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `recipient_id`, `sender_id`, `notification_type`, `notification_title`, `content`, `status`, `created_at`) VALUES
(1, 1, 1, 'Account Registration', 'New Buyer Registration - Erroll seno', 'A new buyer has successfully registered and is waiting for your approval. Check Now!', 'Read', '2025-06-01 22:01:12'),
(2, 1, 1, 'Account Registration', 'Registration Success', 'Congratulations! 🎉 Your buyer account registration has been created successfully. You can now explore a wide range of the latest products in technology, gadgets, and more.', 'Read', '2025-06-01 22:01:12'),
(3, 1, 2, 'Account Registration', 'New Buyer Registration - zeon larano', 'A new buyer has successfully registered and is waiting for your approval. Check Now!', 'Read', '2025-06-01 22:08:36'),
(4, 2, 1, 'Account Registration', 'Registration Success', 'Congratulations! 🎉 Your buyer account registration has been created successfully. You can now explore a wide range of the latest products in technology, gadgets, and more.', 'Read', '2025-06-01 22:08:36'),
(5, 1, 3, 'Account Registration', 'New Seller Registration - zeons laranoss', 'A new seller has successfully registered and is waiting for your approval. Check Now!', 'Read', '2025-06-01 22:15:28'),
(6, 3, 1, 'Account Registration', 'Account Approved', 'Congratulations! 🎉 Your seller account has been approved. You can now start managing your shop and selling your products.', 'Read', '2025-06-01 22:17:05'),
(7, 1, 4, 'Account Registration', 'New Courier Registration - zeons tagadeliver', 'A new courier has successfully registered and is waiting for your approval. Check Now!', 'Read', '2025-06-01 22:20:40'),
(8, 4, 1, 'Account Registration', 'Account Approved', 'Your courier account has been approved! You can now start accepting delivery requests.', 'Read', '2025-06-01 22:22:16'),
(9, 3, 1, 'New Product', 'New Product Added!', 'Your product **asafaf** has been successfully added to your inventory.', 'Read', '2025-06-02 00:27:30'),
(10, 2, 1, 'Order Confirmation', 'Order Placed Successfully', 'Your order has been placed successfully. Orders will be processed soon.', 'Read', '2025-06-02 01:19:35'),
(11, 3, 1, 'New Order', 'New Order Received - zeon larano', 'zeon larano has placed an order for: Aec. Please check your orders section to process the order.', 'Read', '2025-06-02 01:19:35'),
(12, 2, 1, 'Order Confirmation', 'Order Placed Successfully', 'Your order has been placed successfully. Orders will be processed soon.', 'Read', '2025-06-02 01:49:28'),
(13, 3, 1, 'New Order', 'New Order Received - zeon larano', 'zeon larano has placed an order for: Aec. Please check your orders section to process the order.', 'Read', '2025-06-02 01:49:28'),
(14, 3, 1, 'Stock Alert', 'Out of Stock Alert!', 'Your product **Aec** is completely out of stock. Restock as soon as possible.', 'Read', '2025-06-02 01:49:40'),
(15, 3, 1, 'New Product', 'New Product Added!', 'Your product **r3324** has been successfully added to your inventory.', 'Read', '2025-06-02 01:59:20'),
(16, 3, 1, 'Stock Alert', 'Low Stock Warning!', 'Your product **r3324** has 10 items left. Restock now!', 'Read', '2025-06-02 01:59:30'),
(17, 2, 1, 'Order Confirmation', 'Order Placed Successfully', 'Your order has been placed successfully. Orders will be processed soon.', 'Read', '2025-06-02 01:59:50'),
(18, 3, 1, 'New Order', 'New Order Received - zeon larano', 'zeon larano has placed an order for: Aec. Please check your orders section to process the order.', 'Read', '2025-06-02 01:59:50'),
(19, 2, 1, 'Order Confirmation', 'Order Placed Successfully', 'Your order has been placed successfully. Orders will be processed soon.', 'Read', '2025-06-02 02:00:17'),
(20, 3, 1, 'New Order', 'New Order Received - zeon larano', 'zeon larano has placed an order for: r3324. Please check your orders section to process the order.', 'Read', '2025-06-02 02:00:17'),
(21, 3, 1, 'Stock Alert', 'Out of Stock Alert!', 'Your product **r3324** is completely out of stock. Restock as soon as possible.', 'Read', '2025-06-02 02:00:20'),
(22, 3, 1, 'New Product', 'New Product Added!', 'Your product **Sample** has been successfully added to your inventory.', 'Read', '2025-06-02 02:07:15'),
(23, 2, 1, 'Order Confirmation', 'Order Placed Successfully', 'Your order has been placed successfully. Orders will be processed soon.', 'Read', '2025-06-02 02:16:21'),
(24, 3, 1, 'New Order', 'New Order Received - zeon larano', 'zeon larano has placed an order for: Sample. Please check your orders section to process the order.', 'Read', '2025-06-02 02:16:21'),
(25, 2, 1, 'Order Update', 'Order Approved', 'Your order for Sample has been approved and is now being prepared for packing.', 'Read', '2025-06-02 02:16:41'),
(26, 2, 1, 'Order Update', 'Order Packed', 'Your order for Sample has been packed and is ready for shipment.', 'Read', '2025-06-02 02:16:45'),
(27, 2, 1, 'Order Update', 'Order in Shipping', 'Your order for Sample has been handed off to Standard Shipping and is now in shipping process.', 'Read', '2025-06-02 02:16:48'),
(28, 2, 1, 'Order Update', 'Order Shipped', 'Your order for Sample has been shipped and is on its way to you.', 'Read', '2025-06-02 02:16:52'),
(29, 2, 1, 'Order Update', 'Courier Assigned', 'Your order #5 for Sample has been assigned to courier zeons tagadeliver and is awaiting acceptance for delivery.', 'Read', '2025-06-02 02:16:56'),
(30, 4, 1, 'Delivery Assignment', 'New Delivery Assignment - Order #5', 'You have been assigned to deliver Order #5 for Sample to zeon larano. Please accept or decline this delivery assignment within 8 hours.', 'Read', '2025-06-02 02:16:56'),
(31, 2, 1, 'Delivery Update', 'Order Out for Delivery', 'Great news! Your order #5 for Sample is now out for delivery with courier  .', 'Read', '2025-06-02 02:17:29'),
(32, 3, 1, 'Delivery Update', 'Order Out for Delivery', 'Order #5 for Sample has been accepted by courier   and is now out for delivery to zeon larano.', 'Read', '2025-06-02 02:17:29'),
(33, 2, 1, 'Order Complete', 'Order Delivered & Payment Confirmed', 'Your order #5 for Sample has been successfully delivered and payment has been confirmed. Thank you for your purchase!', 'Read', '2025-06-02 02:17:37'),
(34, 3, 1, 'Order Complete', 'Order Delivered & Payment Confirmed', 'Order #5 for Sample has been successfully delivered to zeon larano by courier  . Payment has been confirmed and the order is now complete.', 'Read', '2025-06-02 02:17:37'),
(35, 3, 1, 'Order Received', 'Order Received & Payment Confirmed', 'zeon larano has received Order #5 (Sample). Payment has been confirmed and the order is now complete.', 'Read', '2025-06-02 02:17:41'),
(36, 3, 1, 'New Review', 'Customer Review Received', 'zeon larano left a 3-star review (★★★☆☆) for Order #5 (Sample): \"bshsh\"', 'Read', '2025-06-02 02:28:11'),
(37, 2, 1, 'Order Confirmation', 'Order Placed Successfully', 'Your order has been placed successfully. Orders will be processed soon.', 'Unread', '2025-06-02 03:24:34'),
(38, 3, 1, 'New Order', 'New Order Received - zeon larano', 'zeon larano has placed an order for: Sample. Please check your orders section to process the order.', 'Unread', '2025-06-02 03:24:34'),
(39, 2, 1, 'Order Update', 'Order Approved', 'Your order for Sample has been approved and is now being prepared for packing.', 'Unread', '2025-06-02 03:24:49'),
(40, 2, 1, 'Order Update', 'Order Packed', 'Your order for Sample has been packed and is ready for shipment.', 'Unread', '2025-06-02 03:24:53'),
(41, 2, 1, 'Order Update', 'Order in Shipping', 'Your order for Sample has been handed off to Standard Shipping and is now in shipping process.', 'Unread', '2025-06-02 03:24:58'),
(42, 2, 1, 'Order Update', 'Order Shipped', 'Your order for Sample has been shipped and is on its way to you.', 'Unread', '2025-06-02 03:25:01'),
(43, 2, 1, 'Order Update', 'Courier Assigned', 'Your order #6 for Sample has been assigned to courier zeons tagadeliver and is awaiting acceptance for delivery.', 'Unread', '2025-06-02 03:25:05'),
(44, 4, 1, 'Delivery Assignment', 'New Delivery Assignment - Order #6', 'You have been assigned to deliver Order #6 for Sample to zeon larano. Please accept or decline this delivery assignment within 8 hours.', 'Unread', '2025-06-02 03:25:05'),
(45, 2, 1, 'Delivery Update', 'Order Out for Delivery', 'Great news! Your order #6 for Sample is now out for delivery with courier  .', 'Unread', '2025-06-02 03:25:18'),
(46, 3, 1, 'Delivery Update', 'Order Out for Delivery', 'Order #6 for Sample has been accepted by courier   and is now out for delivery to zeon larano.', 'Unread', '2025-06-02 03:25:18'),
(47, 2, 1, 'Order Complete', 'Order Delivered & Payment Confirmed', 'Your order #6 for Sample has been successfully delivered and payment has been confirmed. Thank you for your purchase!', 'Unread', '2025-06-02 03:25:37'),
(48, 3, 1, 'Order Complete', 'Order Delivered & Payment Confirmed', 'Order #6 for Sample has been successfully delivered to zeon larano by courier  . Payment has been confirmed and the order is now complete.', 'Unread', '2025-06-02 03:25:37'),
(49, 3, 1, 'Order Received', 'Order Received & Payment Confirmed', 'zeon larano has received Order #6 (Sample). Payment has been confirmed and the order is now complete.', 'Unread', '2025-06-02 03:25:44');

-- --------------------------------------------------------

--
-- Table structure for table `order_completed`
--

CREATE TABLE `order_completed` (
  `completed_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `date_completed` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('Completed') NOT NULL DEFAULT 'Completed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_completed`
--

INSERT INTO `order_completed` (`completed_id`, `order_id`, `date_completed`, `status`) VALUES
(1, 5, '2025-06-02 02:17:37', 'Completed'),
(2, 6, '2025-06-02 03:25:37', 'Completed');

-- --------------------------------------------------------

--
-- Table structure for table `order_delivery`
--

CREATE TABLE `order_delivery` (
  `delivery_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `courier_id` int(11) NOT NULL,
  `date_delivered` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('For Delivery','Out for Delivery','Delivered') NOT NULL DEFAULT 'For Delivery'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_delivery`
--

INSERT INTO `order_delivery` (`delivery_id`, `order_id`, `courier_id`, `date_delivered`, `status`) VALUES
(1, 5, 4, '2025-06-02 02:16:56', 'Delivered'),
(2, 6, 4, '2025-06-02 03:25:05', 'Delivered');

-- --------------------------------------------------------

--
-- Table structure for table `order_packing`
--

CREATE TABLE `order_packing` (
  `packing_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `status` enum('Packing','Packed') NOT NULL DEFAULT 'Packing',
  `date_packed` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_packing`
--

INSERT INTO `order_packing` (`packing_id`, `order_id`, `status`, `date_packed`) VALUES
(1, 5, 'Packed', '2025-06-02 02:16:45'),
(2, 6, 'Packed', '2025-06-02 03:24:53');

-- --------------------------------------------------------

--
-- Table structure for table `order_received`
--

CREATE TABLE `order_received` (
  `received_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `date_received` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('To Receive','Received') NOT NULL DEFAULT 'To Receive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_received`
--

INSERT INTO `order_received` (`received_id`, `order_id`, `buyer_id`, `date_received`, `status`) VALUES
(1, 5, 2, '2025-06-02 02:17:37', 'Received'),
(2, 5, 2, '2025-06-02 02:17:41', 'Received'),
(3, 6, 2, '2025-06-02 03:25:37', 'Received'),
(4, 6, 2, '2025-06-02 03:25:44', 'Received');

-- --------------------------------------------------------

--
-- Table structure for table `order_shipping`
--

CREATE TABLE `order_shipping` (
  `shipping_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `logistic_name` varchar(50) NOT NULL,
  `date_shipping` datetime NOT NULL DEFAULT current_timestamp(),
  `date_shipped` datetime DEFAULT NULL,
  `status` enum('Shipping','Shipped') NOT NULL DEFAULT 'Shipping'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_shipping`
--

INSERT INTO `order_shipping` (`shipping_id`, `order_id`, `logistic_name`, `date_shipping`, `date_shipped`, `status`) VALUES
(1, 5, 'Standard Shipping', '2025-06-02 02:16:48', '2025-06-02 02:16:52', 'Shipped'),
(2, 6, 'Standard Shipping', '2025-06-02 03:24:58', '2025-06-02 03:25:01', 'Shipped');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `product_info_id` int(11) NOT NULL,
  `stock` int(11) NOT NULL CHECK (`stock` >= 0),
  `stock_status` enum('Active','Nearly Out of Stock','Out of Stock') DEFAULT NULL,
  `price` decimal(10,2) NOT NULL CHECK (`price` >= 0),
  `shipping_fee` decimal(10,2) NOT NULL,
  `status` enum('Active','Archived','Deleted') NOT NULL DEFAULT 'Active',
  `date_added` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_info_id`, `stock`, `stock_status`, `price`, `shipping_fee`, `status`, `date_added`) VALUES
(1, 1, 0, 'Out of Stock', 24.00, 43.00, 'Active', '2025-06-02 00:27:30'),
(2, 2, 0, 'Out of Stock', 1234.00, 22.00, 'Active', '2025-06-02 01:59:20'),
(3, 3, 17, 'Active', 23000.00, 120.00, 'Active', '2025-06-02 02:07:15');

-- --------------------------------------------------------

--
-- Table structure for table `product_feedback`
--

CREATE TABLE `product_feedback` (
  `feedback_id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `feedback` text NOT NULL,
  `date_feedback` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_feedback`
--

INSERT INTO `product_feedback` (`feedback_id`, `shop_id`, `product_id`, `sender_id`, `feedback`, `date_feedback`) VALUES
(1, 1, 3, 2, 'bshsh', '2025-06-02 02:28:11');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `images_id` int(11) NOT NULL,
  `product_info_id` int(11) NOT NULL,
  `product_image` varchar(299) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`images_id`, `product_info_id`, `product_image`) VALUES
(1, 1, 'U3lIhyq9t3xxxza8_As1Hw_Screenshot_2025-05-28_143749.png'),
(2, 1, 'CR5uD9Hp15-ilE_7OmJOvA_Screenshot_2025-05-28_143736.png'),
(3, 2, 'MzrDpNNRqKR3u2YZ6MRG0g_sg-11134201-23020-qsu3yk2khunvfc.jpg'),
(4, 2, 'zMBWtpQ5kao5Mw2r3t3O4g_615H7BPmmL.jpg'),
(5, 2, 'M_xCCnP9T86HaReIwBpAjQ_images_63.jpg'),
(6, 3, 'qG8EKLnOxRVHeODIShCUKg_images_33.jpg'),
(7, 3, 'allGDJUs-7ajQEl3l_hO3w_images_32.jpg'),
(8, 3, 'EoqUACy-C1NypuDb81Vr-Q_download_24.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `product_info`
--

CREATE TABLE `product_info` (
  `product_info_id` int(11) NOT NULL,
  `product_category` varchar(50) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_description` text NOT NULL,
  `product_main_pic` varchar(299) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_info`
--

INSERT INTO `product_info` (`product_info_id`, `product_category`, `product_name`, `product_description`, `product_main_pic`) VALUES
(1, 'Fiction', 'Aec', 'asf211asdddddddddddddddddddddddddddddddddd', 'S0Mi1eBdM0izKDDIiArMug_Screenshot_2025-05-28_143709.png'),
(2, 'Non-Fiction', 'r3324', 'sdaqweeeeeeeeeeeeeeeeeeeee', 'soUVVS7DZaDSQk5AMuNfHw_images_65.jpg'),
(3, 'Fiction', 'Sample', 'asjdjaskdhakshdkhasjdjahsdjhaskd', 'yGgrjIYKWAZhoSUixipBtg_Screenshot_2025-05-28_130910.png');

-- --------------------------------------------------------

--
-- Table structure for table `product_rating`
--

CREATE TABLE `product_rating` (
  `rating_id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `rate` int(11) NOT NULL CHECK (`rate` between 1 and 5),
  `date_rated` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_rating`
--

INSERT INTO `product_rating` (`rating_id`, `shop_id`, `product_id`, `sender_id`, `rate`, `date_rated`) VALUES
(1, 1, 3, 2, 3, '2025-06-02 02:28:11');

-- --------------------------------------------------------

--
-- Table structure for table `product_specs`
--

CREATE TABLE `product_specs` (
  `specs_id` int(11) NOT NULL,
  `product_info_id` int(11) NOT NULL,
  `specs_type` varchar(100) NOT NULL,
  `specs_content` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variant_images`
--

CREATE TABLE `product_variant_images` (
  `images_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_image` varchar(299) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seller_sales`
--

CREATE TABLE `seller_sales` (
  `sales_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `sale` decimal(10,2) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `seller_sales`
--

INSERT INTO `seller_sales` (`sales_id`, `seller_id`, `order_id`, `sale`, `date_created`) VALUES
(1, 3, 5, 42320.00, '2025-06-02 02:17:41'),
(2, 3, 6, 21160.00, '2025-06-02 03:25:44');

-- --------------------------------------------------------

--
-- Table structure for table `seller_vouchers`
--

CREATE TABLE `seller_vouchers` (
  `voucher_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `voucher_type` varchar(30) NOT NULL,
  `voucher_name` varchar(255) NOT NULL,
  `voucher_description` text DEFAULT NULL,
  `voucher_min_spend` decimal(10,2) NOT NULL,
  `voucher_value` decimal(10,2) DEFAULT 0.00,
  `voucher_start_date` date NOT NULL,
  `voucher_end_date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shop`
--

CREATE TABLE `shop` (
  `shop_id` int(11) NOT NULL,
  `shop_info_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop`
--

INSERT INTO `shop` (`shop_id`, `shop_info_id`, `seller_id`, `date_created`) VALUES
(1, 1, 3, '2025-06-01 22:15:28');

-- --------------------------------------------------------

--
-- Table structure for table `shop_info`
--

CREATE TABLE `shop_info` (
  `shop_info_id` int(11) NOT NULL,
  `shop_name` varchar(100) NOT NULL,
  `shop_description` text NOT NULL,
  `shop_pic` varchar(299) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_info`
--

INSERT INTO `shop_info` (`shop_info_id`, `shop_name`, `shop_description`, `shop_pic`) VALUES
(1, 'bookssssss', 'bili na kayo', 'uX6CU2QIWh_5oEFVsfqD9A_Blog-Software-Developers-Communication-Skills.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `shop_listing`
--

CREATE TABLE `shop_listing` (
  `shop_listing_id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_listing`
--

INSERT INTO `shop_listing` (`shop_listing_id`, `shop_id`, `seller_id`, `product_id`) VALUES
(1, 1, 3, 1),
(2, 1, 3, 2),
(3, 1, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `user_account`
--

CREATE TABLE `user_account` (
  `user_id` int(11) NOT NULL,
  `personal_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `valid_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  `login_id` int(11) NOT NULL,
  `business_id` int(11) DEFAULT NULL,
  `user_role` enum('Buyer','Seller','Admin','Courier') NOT NULL,
  `profile_pic` varchar(299) DEFAULT NULL,
  `status` enum('Pending','Approved','Declined','Banned','Suspended','Archived') NOT NULL DEFAULT 'Pending',
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_account`
--

INSERT INTO `user_account` (`user_id`, `personal_id`, `address_id`, `valid_id`, `contact_id`, `login_id`, `business_id`, `user_role`, `profile_pic`, `status`, `date_created`) VALUES
(1, 1, 1, 1, 1, 1, NULL, 'Admin', NULL, 'Approved', '2025-06-01 22:01:12'),
(2, 2, 2, 2, 2, 2, NULL, 'Buyer', NULL, 'Approved', '2025-06-01 22:08:36'),
(3, 3, 3, 3, 3, 3, 1, 'Seller', NULL, 'Approved', '2025-06-01 22:15:28'),
(4, 4, 4, 4, 4, 4, NULL, 'Courier', 'rJr-jaahUXXkHsclv7O2sA_images_10.jpg', 'Approved', '2025-06-01 22:20:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_address_info`
--
ALTER TABLE `account_address_info`
  ADD PRIMARY KEY (`address_id`);

--
-- Indexes for table `account_business_info`
--
ALTER TABLE `account_business_info`
  ADD PRIMARY KEY (`business_id`);

--
-- Indexes for table `account_contact_info`
--
ALTER TABLE `account_contact_info`
  ADD PRIMARY KEY (`contact_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `account_login_info`
--
ALTER TABLE `account_login_info`
  ADD PRIMARY KEY (`login_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `account_personal_info`
--
ALTER TABLE `account_personal_info`
  ADD PRIMARY KEY (`personal_id`);

--
-- Indexes for table `account_valid_info`
--
ALTER TABLE `account_valid_info`
  ADD PRIMARY KEY (`valid_id`),
  ADD UNIQUE KEY `id_no` (`id_no`);

--
-- Indexes for table `admin_order_commission`
--
ALTER TABLE `admin_order_commission`
  ADD PRIMARY KEY (`commission_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `admin_sales`
--
ALTER TABLE `admin_sales`
  ADD PRIMARY KEY (`sales_id`),
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `buyer_cart`
--
ALTER TABLE `buyer_cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `buyer_id` (`buyer_id`);

--
-- Indexes for table `buyer_like`
--
ALTER TABLE `buyer_like`
  ADD PRIMARY KEY (`like_id`),
  ADD KEY `product_info_id` (`product_info_id`),
  ADD KEY `buyer_id` (`buyer_id`);

--
-- Indexes for table `buyer_order`
--
ALTER TABLE `buyer_order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `shop_id` (`shop_id`),
  ADD KEY `seller_id` (`seller_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `buyer_id` (`buyer_id`);

--
-- Indexes for table `courier_sales`
--
ALTER TABLE `courier_sales`
  ADD PRIMARY KEY (`sales_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `courier_id` (`courier_id`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `recipient_id` (`recipient_id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `recipient_id` (`recipient_id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Indexes for table `order_completed`
--
ALTER TABLE `order_completed`
  ADD PRIMARY KEY (`completed_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `order_delivery`
--
ALTER TABLE `order_delivery`
  ADD PRIMARY KEY (`delivery_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `courier_id` (`courier_id`);

--
-- Indexes for table `order_packing`
--
ALTER TABLE `order_packing`
  ADD PRIMARY KEY (`packing_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `order_received`
--
ALTER TABLE `order_received`
  ADD PRIMARY KEY (`received_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `buyer_id` (`buyer_id`);

--
-- Indexes for table `order_shipping`
--
ALTER TABLE `order_shipping`
  ADD PRIMARY KEY (`shipping_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `product_info_id` (`product_info_id`);

--
-- Indexes for table `product_feedback`
--
ALTER TABLE `product_feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `shop_id` (`shop_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`images_id`),
  ADD KEY `product_info_id` (`product_info_id`);

--
-- Indexes for table `product_info`
--
ALTER TABLE `product_info`
  ADD PRIMARY KEY (`product_info_id`);

--
-- Indexes for table `product_rating`
--
ALTER TABLE `product_rating`
  ADD PRIMARY KEY (`rating_id`),
  ADD KEY `shop_id` (`shop_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Indexes for table `product_specs`
--
ALTER TABLE `product_specs`
  ADD PRIMARY KEY (`specs_id`),
  ADD KEY `product_info_id` (`product_info_id`);

--
-- Indexes for table `product_variant_images`
--
ALTER TABLE `product_variant_images`
  ADD PRIMARY KEY (`images_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `seller_sales`
--
ALTER TABLE `seller_sales`
  ADD PRIMARY KEY (`sales_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `seller_vouchers`
--
ALTER TABLE `seller_vouchers`
  ADD PRIMARY KEY (`voucher_id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `shop`
--
ALTER TABLE `shop`
  ADD PRIMARY KEY (`shop_id`),
  ADD KEY `shop_info_id` (`shop_info_id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `shop_info`
--
ALTER TABLE `shop_info`
  ADD PRIMARY KEY (`shop_info_id`);

--
-- Indexes for table `shop_listing`
--
ALTER TABLE `shop_listing`
  ADD PRIMARY KEY (`shop_listing_id`),
  ADD KEY `shop_id` (`shop_id`),
  ADD KEY `seller_id` (`seller_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `user_account`
--
ALTER TABLE `user_account`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `personal_id` (`personal_id`),
  ADD KEY `address_id` (`address_id`),
  ADD KEY `contact_id` (`contact_id`),
  ADD KEY `valid_id` (`valid_id`),
  ADD KEY `login_id` (`login_id`),
  ADD KEY `business_id` (`business_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_address_info`
--
ALTER TABLE `account_address_info`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `account_business_info`
--
ALTER TABLE `account_business_info`
  MODIFY `business_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `account_contact_info`
--
ALTER TABLE `account_contact_info`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `account_login_info`
--
ALTER TABLE `account_login_info`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `account_personal_info`
--
ALTER TABLE `account_personal_info`
  MODIFY `personal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `account_valid_info`
--
ALTER TABLE `account_valid_info`
  MODIFY `valid_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `admin_order_commission`
--
ALTER TABLE `admin_order_commission`
  MODIFY `commission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `admin_sales`
--
ALTER TABLE `admin_sales`
  MODIFY `sales_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `buyer_cart`
--
ALTER TABLE `buyer_cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `buyer_like`
--
ALTER TABLE `buyer_like`
  MODIFY `like_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `buyer_order`
--
ALTER TABLE `buyer_order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `courier_sales`
--
ALTER TABLE `courier_sales`
  MODIFY `sales_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `order_completed`
--
ALTER TABLE `order_completed`
  MODIFY `completed_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_delivery`
--
ALTER TABLE `order_delivery`
  MODIFY `delivery_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_packing`
--
ALTER TABLE `order_packing`
  MODIFY `packing_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_received`
--
ALTER TABLE `order_received`
  MODIFY `received_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `order_shipping`
--
ALTER TABLE `order_shipping`
  MODIFY `shipping_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_feedback`
--
ALTER TABLE `product_feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `images_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `product_info`
--
ALTER TABLE `product_info`
  MODIFY `product_info_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_rating`
--
ALTER TABLE `product_rating`
  MODIFY `rating_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_specs`
--
ALTER TABLE `product_specs`
  MODIFY `specs_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_variant_images`
--
ALTER TABLE `product_variant_images`
  MODIFY `images_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seller_sales`
--
ALTER TABLE `seller_sales`
  MODIFY `sales_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `seller_vouchers`
--
ALTER TABLE `seller_vouchers`
  MODIFY `voucher_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shop`
--
ALTER TABLE `shop`
  MODIFY `shop_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `shop_info`
--
ALTER TABLE `shop_info`
  MODIFY `shop_info_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `shop_listing`
--
ALTER TABLE `shop_listing`
  MODIFY `shop_listing_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_account`
--
ALTER TABLE `user_account`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_order_commission`
--
ALTER TABLE `admin_order_commission`
  ADD CONSTRAINT `admin_order_commission_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `buyer_order` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `admin_order_commission_ibfk_2` FOREIGN KEY (`seller_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `admin_sales`
--
ALTER TABLE `admin_sales`
  ADD CONSTRAINT `admin_sales_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `admin_sales_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `admin_sales_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `buyer_order` (`order_id`) ON DELETE CASCADE;

--
-- Constraints for table `buyer_cart`
--
ALTER TABLE `buyer_cart`
  ADD CONSTRAINT `buyer_cart_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `buyer_cart_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `buyer_like`
--
ALTER TABLE `buyer_like`
  ADD CONSTRAINT `buyer_like_ibfk_1` FOREIGN KEY (`product_info_id`) REFERENCES `product` (`product_info_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `buyer_like_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `buyer_order`
--
ALTER TABLE `buyer_order`
  ADD CONSTRAINT `buyer_order_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `buyer_order_ibfk_2` FOREIGN KEY (`seller_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `buyer_order_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `buyer_order_ibfk_4` FOREIGN KEY (`buyer_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `courier_sales`
--
ALTER TABLE `courier_sales`
  ADD CONSTRAINT `courier_sales_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `buyer_order` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `courier_sales_ibfk_2` FOREIGN KEY (`courier_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD CONSTRAINT `login_attempts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`recipient_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`recipient_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `order_completed`
--
ALTER TABLE `order_completed`
  ADD CONSTRAINT `order_completed_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `buyer_order` (`order_id`) ON DELETE CASCADE;

--
-- Constraints for table `order_delivery`
--
ALTER TABLE `order_delivery`
  ADD CONSTRAINT `order_delivery_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `buyer_order` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_delivery_ibfk_2` FOREIGN KEY (`courier_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `order_packing`
--
ALTER TABLE `order_packing`
  ADD CONSTRAINT `order_packing_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `buyer_order` (`order_id`) ON DELETE CASCADE;

--
-- Constraints for table `order_received`
--
ALTER TABLE `order_received`
  ADD CONSTRAINT `order_received_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `buyer_order` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_received_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `order_shipping`
--
ALTER TABLE `order_shipping`
  ADD CONSTRAINT `order_shipping_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `buyer_order` (`order_id`) ON DELETE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`product_info_id`) REFERENCES `product_info` (`product_info_id`) ON DELETE CASCADE;

--
-- Constraints for table `product_feedback`
--
ALTER TABLE `product_feedback`
  ADD CONSTRAINT `product_feedback_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`),
  ADD CONSTRAINT `product_feedback_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_feedback_ibfk_3` FOREIGN KEY (`sender_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_info_id`) REFERENCES `product` (`product_info_id`) ON DELETE CASCADE;

--
-- Constraints for table `product_rating`
--
ALTER TABLE `product_rating`
  ADD CONSTRAINT `product_rating_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`),
  ADD CONSTRAINT `product_rating_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_rating_ibfk_3` FOREIGN KEY (`sender_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `product_specs`
--
ALTER TABLE `product_specs`
  ADD CONSTRAINT `product_specs_ibfk_1` FOREIGN KEY (`product_info_id`) REFERENCES `product` (`product_info_id`) ON DELETE CASCADE;

--
-- Constraints for table `product_variant_images`
--
ALTER TABLE `product_variant_images`
  ADD CONSTRAINT `product_variant_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `seller_sales`
--
ALTER TABLE `seller_sales`
  ADD CONSTRAINT `seller_sales_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `buyer_order` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seller_sales_ibfk_2` FOREIGN KEY (`seller_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `seller_vouchers`
--
ALTER TABLE `seller_vouchers`
  ADD CONSTRAINT `seller_vouchers_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `shop`
--
ALTER TABLE `shop`
  ADD CONSTRAINT `shop_ibfk_1` FOREIGN KEY (`shop_info_id`) REFERENCES `shop_info` (`shop_info_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `shop_ibfk_2` FOREIGN KEY (`seller_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `shop_listing`
--
ALTER TABLE `shop_listing`
  ADD CONSTRAINT `shop_listing_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `shop_listing_ibfk_2` FOREIGN KEY (`seller_id`) REFERENCES `user_account` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `shop_listing_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_account`
--
ALTER TABLE `user_account`
  ADD CONSTRAINT `user_account_ibfk_1` FOREIGN KEY (`personal_id`) REFERENCES `account_personal_info` (`personal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_account_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `account_address_info` (`address_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_account_ibfk_3` FOREIGN KEY (`contact_id`) REFERENCES `account_contact_info` (`contact_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_account_ibfk_4` FOREIGN KEY (`valid_id`) REFERENCES `account_valid_info` (`valid_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_account_ibfk_5` FOREIGN KEY (`login_id`) REFERENCES `account_login_info` (`login_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_account_ibfk_6` FOREIGN KEY (`business_id`) REFERENCES `account_business_info` (`business_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
