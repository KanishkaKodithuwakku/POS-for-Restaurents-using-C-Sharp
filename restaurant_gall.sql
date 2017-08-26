-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 18, 2017 at 02:18 PM
-- Server version: 10.1.8-MariaDB
-- PHP Version: 5.6.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `restaurant_gall`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Products` ()  BEGIN
SELECT categories.id AS ccode,categories.name AS cname,products.id AS pcode,products.name AS pname,product_sizes.price AS pprice FROM products JOIN categories ON categories.id=products.category_id JOIN product_sizes ON product_sizes.products_id=products.id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SalesReport` ()  BEGIN
SELECT orders.id AS orderid,orders.created AS orderdate,orders.discount AS orderdiscount,order_details.product_id AS pcode,order_details.unit_price,order_details.qty,order_details.subtotal,@todaysale := (SELECT SUM(order_details.subtotal) FROM order_details WHERE date(order_details.added) = CURDATE()) AS todaysale FROM `order_details` JOIN orders ON orders.id=order_details.order_id ORDER BY orders.created DESC;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `image` varchar(50) NOT NULL,
  `online` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image`, `online`) VALUES
(1, 'The Heritage Proprietors ', '0.jpg', 1),
(2, 'Chilled & Bottled Mineral', '0.jpg', 1),
(3, 'Fresh Juices', '0.jpg', 1),
(4, 'Cold Drinks', '0.jpg', 1),
(5, 'Hot Drinks', '0.jpg', 1),
(6, 'Sodas', '0.jpg', 1),
(7, 'Soup Appetizers', '0.jpg', 1),
(8, 'Salads & Sides', '0.jpg', 1),
(9, 'Oven Fired Artisanal Pizz', '0.jpg', 1),
(10, 'Seafood Main', '0.jpg', 1),
(11, 'Heritage Mains', '0.jpg', 1),
(12, 'Kids Menu', '0.jpg', 1),
(13, 'Desserts', '0.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `created` varchar(25) NOT NULL,
  `guest` int(4) DEFAULT '1',
  `tabel` text,
  `priority` varchar(45) DEFAULT NULL,
  `order_type` varchar(1) DEFAULT NULL,
  `paid` double DEFAULT '0',
  `discount` double DEFAULT '0',
  `service_charge` double DEFAULT '0',
  `online` int(11) NOT NULL DEFAULT '1',
  `active` int(1) DEFAULT '0',
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `created`, `guest`, `tabel`, `priority`, `order_type`, `paid`, `discount`, `service_charge`, `online`, `active`, `user_id`) VALUES
(1, '8/10/2017 3:52:15 PM', 0, 'TAKEAWAY', NULL, 'D', 205, 50, 0, 1, 0, 2),
(2, '8/10/2017 3:54:42 PM', 2, 'G1', NULL, 'D', 3707, 0, 10, 1, 0, 2),
(3, '8/10/2017 4:33:47 PM', 5, 'G1', NULL, 'D', 5654, 0, 10, 1, 0, 2),
(4, '8/11/2017 5:47:42 PM', 1, 'G1', NULL, 'D', 0, 0, 10, 1, 1, 2),
(5, '8/11/2017 6:37:04 PM', 3, 'G1', NULL, 'D', 4000, 0, 10, 1, 0, 2),
(6, '8/11/2017 6:40:49 PM', 2, 'G1', NULL, 'D', 5000, 0, 10, 1, 0, 2),
(7, '8/11/2017 6:41:42 PM', 2, 'G1', NULL, 'D', 3000, 0, 10, 1, 0, 2),
(8, '8/11/2017 6:53:07 PM', 4, 'G8', NULL, 'D', 10000, 0, 10, 1, 0, 2),
(9, '8/11/2017 7:40:03 PM', 2, 'G2', NULL, 'D', 1600, 0, 0, 1, 0, 2),
(10, '8/11/2017 8:14:11 PM', -2, 'TAKEAWAY', NULL, 'D', 1000, 0, 0, 1, 0, 2),
(11, '8/14/2017 4:44:57 PM', 4, 'G1', NULL, 'D', 1320, 0, 10, 1, 0, 2),
(12, '2017-08-16 02:03:48pm', 4, 'Think Table', NULL, 'D', 0, 0, 0, 1, 1, 8),
(13, '2017-08-16 02:07:13pm', 3, 'G1', NULL, 'D', 0, 0, 0, 1, 1, 8),
(14, '2017-08-16 02:21:01pm', 2, 'G6', NULL, 'D', 0, 0, 0, 1, 1, 8),
(15, '8/18/2017 10:27:49 AM', 2, 'G1', NULL, 'D', 0, 0, 10, 1, 1, 2),
(16, '8/18/2017 10:31:00 AM', 1, 'G1', NULL, 'D', 0, 0, 10, 1, 1, 2),
(17, '8/18/2017 10:32:09 AM', 8, 'G1', NULL, 'D', 0, 0, 10, 1, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `product_id` varchar(45) NOT NULL,
  `order_id` int(11) NOT NULL,
  `size` varchar(1) DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `qty` int(11) NOT NULL,
  `kot_status` int(11) DEFAULT '0',
  `online` int(11) NOT NULL DEFAULT '1',
  `added` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `subtotal` double DEFAULT NULL,
  `item_type` varchar(2) DEFAULT NULL,
  `print_status` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `product_id`, `order_id`, `size`, `unit_price`, `qty`, `kot_status`, `online`, `added`, `subtotal`, `item_type`, `print_status`) VALUES
(1, '001', 1, 'R', 410, 1, 0, 1, '2017-08-10 10:22:21', 410, '2', 1),
(2, '001', 2, 'R', 410, 2, 0, 1, '2017-08-10 10:24:51', 820, '2', 1),
(3, '002', 2, 'G', 510, 5, 0, 1, '2017-08-10 11:02:47', 1020, '2', 1),
(4, '002', 3, 'G', 510, 4, 0, 1, '2017-08-10 11:03:57', 510, '2', 1),
(5, '003', 3, 'R', 450, 3, 0, 1, '2017-08-10 11:07:57', 450, '2', 1),
(6, '019', 3, '', 400, 4, 0, 1, '2017-08-11 10:54:37', 400, '2', 1),
(7, '015', 3, 'L', 150, 2, 0, 1, '2017-08-11 10:56:07', 150, '2', 1),
(10, '002', 4, 'G', 510, 1, 0, 1, '2017-08-11 12:17:44', 510, '2', 1),
(11, '048', 5, '', 1200, 1, 0, 1, '2017-08-11 13:07:08', 1200, '2', 1),
(12, '047', 5, '', 1050, 2, 0, 1, '2017-08-11 13:07:08', 2100, '2', 1),
(13, '053', 6, '', 500, 1, 0, 1, '2017-08-11 13:10:58', 500, '1', 1),
(14, '047', 6, '', 1050, 1, 0, 1, '2017-08-11 13:10:58', 1050, '2', 1),
(15, '047', 7, '', 1050, 1, 0, 1, '2017-08-11 13:11:49', 1050, '2', 1),
(16, '047', 7, '', 1050, 1, 0, 1, '2017-08-11 13:11:49', 1050, '2', 1),
(17, '090', 8, '', 1000, 1, 0, 1, '2017-08-11 13:23:17', 1000, '1', 1),
(18, '091', 8, '', 700, 0, 0, 1, '2017-08-11 13:23:17', 700, '1', 1),
(19, '092', 8, '', 1000, 1, 0, 1, '2017-08-11 13:23:17', 1000, '1', 1),
(20, '93', 8, '', 1000, 1, 0, 1, '2017-08-11 13:23:17', 1000, '1', 1),
(21, '94', 8, '', 800, 1, 0, 1, '2017-08-11 13:23:17', 800, '1', 1),
(22, '001', 8, 'R', 410, 1, 0, 1, '2017-08-11 13:23:17', 410, '2', 1),
(23, '001', 8, 'R', 410, 1, 0, 1, '2017-08-11 13:23:17', 410, '2', 1),
(24, '101', 8, '', 700, 1, 0, 1, '2017-08-11 13:23:17', 700, '2', 1),
(25, '102', 8, '', 500, 1, 0, 1, '2017-08-11 13:23:17', 500, '2', 1),
(26, '104', 8, '', 950, 1, 0, 1, '2017-08-11 13:23:17', 950, '2', 1),
(27, '105', 8, '', 950, 1, 0, 1, '2017-08-11 13:23:17', 950, '2', 1),
(28, '106', 8, '', 500, 1, 0, 1, '2017-08-11 13:23:17', 500, '2', 1),
(29, '102', 9, '', 500, 1, 0, 1, '2017-08-11 14:10:09', 500, '2', 1),
(30, '104', 9, '', 950, 1, 0, 1, '2017-08-11 14:10:09', 950, '2', 1),
(31, '016', 10, 'M', 130, 1, 0, 1, '2017-08-11 14:44:21', 130, '2', 1),
(32, '015', 10, 'L', 150, 1, 0, 1, '2017-08-11 14:44:21', 150, '2', 1),
(33, '019', 11, '', 400, 1, 0, 1, '2017-08-14 11:15:05', 400, '2', 1),
(34, '017', 11, '', 400, 1, 0, 1, '2017-08-14 11:15:05', 400, '2', 1),
(35, '018', 11, '', 400, 1, 0, 1, '2017-08-14 11:15:05', 400, '2', 1),
(36, '002', 4, 'G', 510, 1, 0, 1, '2017-08-14 11:49:13', 510, '2', 1),
(37, '001', 4, 'R', 410, 2, 0, 1, '2017-08-14 11:49:43', 820, '2', 1),
(38, '002', 12, 'L', 510, 4, 0, 1, '2017-08-16 08:33:51', 2040, '2', 1),
(39, '017', 12, 'L', 400, 3, 0, 1, '2017-08-16 08:33:51', 1200, '2', 1),
(40, '016', 12, 'L', 130, 4, 0, 1, '2017-08-16 08:33:51', 520, '2', 1),
(41, '071', 12, 'L', 1800, 6, 0, 1, '2017-08-16 08:33:51', 10800, '1', 1),
(42, '002', 13, 'L', 510, 3, 0, 1, '2017-08-16 08:37:20', 1530, '2', 1),
(43, '22', 13, 'L', 500, 4, 0, 1, '2017-08-16 08:38:40', 2000, '2', 1),
(44, '026', 13, 'L', 600, 5, 0, 1, '2017-08-16 08:39:31', 3000, '2', 1),
(45, '94', 13, 'L', 800, 4, 0, 1, '2017-08-16 08:40:21', 3200, '1', 1),
(46, '053', 12, 'L', 500, 5, 0, 1, '2017-08-16 08:47:21', 2500, '1', 1),
(47, '016', 14, 'L', 130, 2, 0, 1, '2017-08-16 08:51:11', 260, '2', 1),
(48, '35', 14, 'L', 170, 7, 0, 1, '2017-08-16 08:51:11', 1190, '2', 1),
(49, '042', 14, 'L', 650, 2, 0, 1, '2017-08-16 08:51:41', 1300, '1', 1),
(50, '002', 15, 'G', 510, 1, 0, 1, '2017-08-18 04:57:55', 510, '2', 1),
(51, '002', 16, 'G', 510, 1, 0, 1, '2017-08-18 05:01:06', 510, '2', 1),
(52, '001', 17, 'R', 410, 1, 0, 1, '2017-08-18 05:02:16', 410, '2', 1);

-- --------------------------------------------------------

--
-- Table structure for table `paymentdetails`
--

CREATE TABLE `paymentdetails` (
  `id` int(11) NOT NULL,
  `orders_id` int(11) NOT NULL,
  `cardname` varchar(100) DEFAULT NULL,
  `cardno` varchar(4) DEFAULT NULL,
  `cardtype` varchar(12) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `amount` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paymentdetails`
--

INSERT INTO `paymentdetails` (`id`, `orders_id`, `cardname`, `cardno`, `cardtype`, `created`, `amount`) VALUES
(1, 1, 'test', '1111', 'VISA', '2017-08-10 10:22:15', 205),
(2, 2, 'test dis', '1111', 'VISA', '2017-08-10 10:36:33', 492),
(3, 2, 'test', '1212', 'VISA', '2017-08-11 09:59:01', 3707),
(4, 3, 'test', '1212', 'VISA', '2017-08-11 10:57:36', 5654),
(5, 10, '', '0', '', '2017-08-11 14:44:11', 280),
(6, 11, 'ddfd', '1111', 'VISA', '2017-08-14 11:46:53', 1320);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` varchar(45) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `size` varchar(45) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `item_type` varchar(5) DEFAULT NULL,
  `online` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `category_id`, `image`, `size`, `price`, `item_type`, `online`) VALUES
('001', 'Cappuccino ', 1, '0.jpg', 'Regular', 410, '2', 1),
('002', 'cappuccino ', 1, '0.jpg', 'Grande ', 510, '2', 1),
('003', 'Cafe Latte', 1, '0.jpg', 'Regular ', 450, '2', 1),
('004', 'Iced Latte', 1, '0.jpg', 'Regular ', 450, '2', 1),
('005', 'Esspresso', 1, '0.jpg', 'Single', 300, '2', 1),
('006', 'Esspresso ', 1, '0.jpg', 'Doppio (Double)', 400, '2', 1),
('007', 'The Heritage Proprietors Cold Brew', 1, '0.jpg', '', 450, '2', 1),
('008', 'Flat White', 1, '0.jpg', '', 420, '2', 1),
('009', 'Cafe Mocha', 1, '0.jpg', 'Regular', 480, '2', 1),
('010', 'Cafe Mocha', 1, '0.jpg', 'Grande', 580, '2', 1),
('011', 'Iced Cafe Mocha', 1, '0.jpg', 'Regular', 480, '2', 1),
('012', 'Americano', 1, '0.jpg', 'Regular', 360, '2', 1),
('013', 'Americano', 1, '0.jpg', 'Grande', 460, '2', 1),
('014', 'Baby Chino', 1, '0.jpg', '', 300, '2', 1),
('015', 'Mineral Water', 2, '0.jpg', 'Large 1000ml (1litre)', 150, '2', 1),
('016', 'Mineral Water ', 2, '0.jpg', 'Medium 750ml', 130, '2', 1),
('017', 'Mango', 3, '0.jpg', '', 400, '2', 1),
('018', 'Papaya', 3, '0.jpg', '', 400, '2', 1),
('019', 'Pineapple ', 3, '0.jpg', '', 400, '2', 1),
('020', 'Water Melon', 3, '0.jpg', '', 400, '2', 1),
('021', 'Lime', 3, '0.jpg', '', 400, '2', 1),
('023', 'Sri Lankan Fresh Lime & Soda', 4, '0.jpg', '', 400, '2', 1),
('024', 'Fresh King Coconut', 4, '0.jpg', '', 150, '2', 1),
('025', 'Chocolate Milkshake', 4, '0.jpg', '', 600, '2', 1),
('026', 'Banana Milkshake', 4, '0.jpg', '', 600, '2', 1),
('027', 'Vanilla Milkshake', 4, '0.jpg', '', 600, '2', 1),
('028', 'Strawberry Milkshake', 1, '0.jpg', '', 600, '2', 1),
('029', 'Heritage Signature Iced Tea', 4, '0.jpg', '', 300, '2', 1),
('030', 'Moms Secret Chai Iced Tea', 4, '0.jpg', '', 550, '2', 1),
('031', 'Hot Ceylon Tea', 5, '0.jpg', '', 300, '2', 1),
('032', 'Hot Chocolate', 5, '0.jpg', '', 550, '2', 1),
('033', 'Coke', 6, '0.jpg', '', 170, '2', 1),
('034', 'Sprite', 1, '0.jpg', '', 170, '2', 1),
('036', 'Diet Coke', 1, '0.jpg', '', 270, '2', 1),
('037', 'Soda Water', 6, '0.jpg', '', 150, '2', 1),
('040', 'Wild Mushroom Soup', 7, '0.jpg', '', 790, '1', 1),
('041', 'Cream of Tomato Soup', 7, '0.jpg', '', 500, '1', 1),
('042', 'Pumpkin Ginger Soup', 7, '0.jpg', '', 650, '1', 1),
('043', 'Vegetable Spring Rolls', 7, '0.jpg', '', 700, '1', 1),
('044', 'Vietnam Summer Rolls', 7, '0.jpg', '', 1400, '2', 1),
('045', 'Avacado Prawn Cocktail', 7, '0.jpg', '', 1200, '2', 1),
('046', 'Hummus & Pita Bread', 7, '0.jpg', '', 850, '1', 1),
('047', 'Avacado Prawn Salad', 8, '0.jpg', '', 1050, '2', 1),
('048', 'The Heritage Widge Salad', 8, '0.jpg', '', 1200, '2', 1),
('049', 'Salad Nicoise', 8, '0.jpg', '', 1100, '2', 1),
('050', 'Tabbouleh Salad', 8, '0.jpg', '', 850, '2', 1),
('051', 'Geeek Salad', 8, '0.jpg', '', 1100, '2', 1),
('052', 'Crispy French Fries', 8, '0.jpg', '', 500, '1', 1),
('053', 'Potato Wedges', 8, '0.jpg', '', 500, '1', 1),
('060', 'Vegetarian Pizza', 9, '0.jpg', '', 1650, '1', 1),
('061', 'Pizza Margherita', 9, '0.jpg', '', 1300, '1', 1),
('062', 'Seafood Pizza', 9, '0.jpg', '', 2500, '1', 1),
('063', 'Chicken Tandoori Pizza', 9, '0.jpg', '', 1500, '1', 1),
('064', 'Spaghetti Seafood Marinara', 9, '0.jpg', '', 1200, '1', 1),
('065', 'Spaghetti Arabiatta', 9, '0.jpg', '', 950, '1', 1),
('066', 'Pesto Linguni', 9, '0.jpg', '', 950, '1', 1),
('067', 'Spaghetti Bolognese', 9, '0.jpg', '', 1100, '1', 1),
('070', 'Ocean Mixed Grilled Seafood Platter', 10, '0.jpg', '', 2350, '1', 1),
('071', 'Classic Rice & Curry', 10, '0.jpg', '', 1800, '1', 1),
('072', 'Classic Fish & Chips', 10, '0.jpg', '', 1600, '1', 1),
('073', 'Grilled Garlic Prawns', 10, '0.jpg', '', 1800, '1', 1),
('074', 'Herb Marinated Grilled Fish', 10, '0.jpg', '', 1400, '1', 1),
('075', 'Seafood Nasi Goreng', 10, '0.jpg', '', 1700, '1', 1),
('076', 'Spicy Prawn & Vegetable Wrap', 10, '0.jpg', '', 1100, '1', 1),
('077', 'Club Sandwich', 11, '0.jpg', '', 1100, '2', 1),
('078', 'The Heritage Classic Beef Burger', 11, '0.jpg', '', 1400, '1', 1),
('079', 'Spiced Chicken & Vegetable Wrap', 11, '0.jpg', '', 800, '1', 1),
('080', 'Strir Fried Vegetables Platter', 11, '0.jpg', '', 700, '1', 1),
('081', 'Southern Fried Crispy Chicken Strips Ser', 11, '0.jpg', '', 1150, '1', 1),
('082', 'Vegetable Fried Rice', 11, '0.jpg', '', 700, '1', 1),
('090', 'Chicken Fingers', 12, '0.jpg', '', 1000, '1', 1),
('091', 'Spaghetti Marinara', 12, '0.jpg', '', 700, '1', 1),
('092', 'Fish Sticks', 12, '0.jpg', '', 1000, '1', 1),
('101', 'Exotic Fruit Platter', 13, '0.jpg', '', 700, '2', 1),
('102', 'Homemade Banana Cake', 13, '0.jpg', '', 500, '2', 1),
('103', 'Classic Banana Split', 1, '0.jpg', '', 650, '2', 1),
('104', 'Warm Chocolate Brownie', 13, '0.jpg', '', 950, '2', 1),
('105', 'Coconut Crème Brulee', 13, '0.jpg', '', 950, '2', 1),
('106', 'Trio of Ice Cream', 13, '0.jpg', '', 500, '2', 1),
('107', 'Ice Cream By The Scoop', 13, '0.jpg', '', 200, '2', 1),
('22', 'Orange Juice ', 3, '0.jpg', '', 500, '2', 1),
('35', 'Ginger Beer', 6, '0.jpg', '', 170, '2', 1),
('93', 'Mini Burger', 12, '0.jpg', '', 1000, '1', 1),
('94', 'Mac & Chees ', 12, '0.jpg', '', 800, '1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `id` int(11) NOT NULL,
  `products_id` varchar(45) NOT NULL,
  `price` varchar(45) DEFAULT NULL,
  `stock_in_date` datetime DEFAULT NULL,
  `stock_out_date` datetime DEFAULT NULL,
  `stock_in` int(11) DEFAULT NULL,
  `stock_out` int(11) DEFAULT NULL,
  `user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tabeldetails`
--

CREATE TABLE `tabeldetails` (
  `id` int(11) NOT NULL,
  `tabel` varchar(100) DEFAULT NULL,
  `orders_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `table_no`
--

CREATE TABLE `table_no` (
  `id` int(10) UNSIGNED NOT NULL,
  `table_name` varchar(45) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `table_no`
--

INSERT INTO `table_no` (`id`, `table_name`) VALUES
(1, 'G1'),
(2, 'G2'),
(3, 'G3'),
(4, 'G4'),
(5, 'G5'),
(6, 'G6'),
(7, 'G7'),
(8, 'G8'),
(9, 'G9'),
(10, 'G10'),
(11, 'R1'),
(12, 'R2'),
(13, 'R3'),
(14, 'R4'),
(15, 'R5'),
(16, 'R6'),
(17, 'R7'),
(18, 'R8'),
(19, 'R9'),
(20, 'R10'),
(21, 'Balcony 1'),
(22, 'Balcony 2'),
(23, 'Balcony 3'),
(24, 'Think Table'),
(25, 'Sofa 1'),
(26, 'Sofa 2'),
(27, 'Patio 1'),
(28, 'Patio 2'),
(29, 'Patio 3'),
(30, 'Lounge');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(200) NOT NULL,
  `online` int(11) NOT NULL DEFAULT '1',
  `user_type` varchar(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `online`, `user_type`) VALUES
(2, 'lawrence', '71af2da6b34525c317dff4c3044ce973', 1, 'A'),
(3, 'mayuranga', '8df3e10964372d61d6104b39ba0c5ec2', 1, 'W'),
(4, 'chamath', '5c4761dc4a331cf95af8e0cde5c04aa0', 1, 'C'),
(5, 'lakmal', '2d75af3485ae73b6623f9303008df1d4', 1, 'W'),
(6, 'sathiyajith', '76267bef27b1e90daa5729eaa0b6bd11', 1, 'W'),
(7, 'kingsly', '694dc2012c8cc6ab065c76b2c2ba78ed', 1, 'W'),
(8, 'amila', 'a', 1, 'W'),
(9, 'lasith', 'aaa29165536c91854c719f81b6371166', 1, 'W'),
(11, 'admin', '4cabb465e03c5c7db621a5fdc1395900', 1, 'A');

-- --------------------------------------------------------

--
-- Table structure for table `user_log`
--

CREATE TABLE `user_log` (
  `id` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(45) DEFAULT NULL,
  `event` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_log`
--

INSERT INTO `user_log` (`id`, `created`, `user_id`, `event`) VALUES
(1, '2017-08-04 09:50:11', '2', 'login'),
(2, '2017-08-04 09:50:42', '2', 'logout'),
(3, '2017-08-04 09:50:47', '2', 'login'),
(4, '2017-08-04 09:50:52', '2', 'logout'),
(5, '2017-08-04 09:55:10', '2', 'login'),
(6, '2017-08-04 10:12:24', '2', 'login'),
(7, '2017-08-04 10:14:18', '2', 'login'),
(8, '2017-08-04 10:15:00', '2', 'logout'),
(9, '2017-08-04 10:25:34', '2', 'login'),
(10, '2017-08-04 10:25:50', '2', 'logout'),
(11, '2017-08-04 10:45:10', '2', 'login'),
(12, '2017-08-04 10:45:24', '2', 'logout'),
(13, '2017-08-04 11:03:58', '2', 'login'),
(14, '2017-08-04 11:04:05', '2', 'logout'),
(15, '2017-08-10 10:11:30', '2', 'login'),
(16, '2017-08-10 10:21:21', '2', 'login'),
(17, '2017-08-10 10:29:24', '2', 'login'),
(18, '2017-08-10 10:35:16', '2', 'login'),
(19, '2017-08-10 10:47:34', '2', 'login'),
(20, '2017-08-10 10:50:09', '2', 'login'),
(21, '2017-08-10 10:52:22', '2', 'login'),
(22, '2017-08-10 10:53:17', '2', 'login'),
(23, '2017-08-10 10:56:33', '2', 'login'),
(24, '2017-08-10 10:57:49', '2', 'login'),
(25, '2017-08-10 10:59:16', '2', 'login'),
(26, '2017-08-10 10:59:35', '2', 'logout'),
(27, '2017-08-10 11:02:36', '2', 'login'),
(28, '2017-08-11 04:36:54', '2', 'login'),
(29, '2017-08-11 04:43:57', '2', 'login'),
(30, '2017-08-11 04:45:14', '2', 'login'),
(31, '2017-08-11 04:57:25', '2', 'login'),
(32, '2017-08-11 05:00:20', '2', 'login'),
(33, '2017-08-11 05:01:19', '2', 'login'),
(34, '2017-08-11 05:03:16', '2', 'login'),
(35, '2017-08-11 05:06:35', '2', 'login'),
(36, '2017-08-11 08:27:04', '2', 'login'),
(37, '2017-08-11 08:28:54', '2', 'login'),
(38, '2017-08-11 08:34:53', '2', 'login'),
(39, '2017-08-11 08:50:28', '2', 'login'),
(40, '2017-08-11 08:51:56', '2', 'login'),
(41, '2017-08-11 08:53:40', '2', 'login'),
(42, '2017-08-11 09:46:36', '2', 'login'),
(43, '2017-08-11 09:47:28', '2', 'login'),
(44, '2017-08-11 09:57:08', '2', 'login'),
(45, '2017-08-11 10:28:30', '2', 'login'),
(46, '2017-08-11 10:31:46', '2', 'login'),
(47, '2017-08-11 10:32:29', '2', 'logout'),
(48, '2017-08-11 10:37:51', '2', 'login'),
(49, '2017-08-11 10:40:33', '2', 'login'),
(50, '2017-08-11 10:45:12', '2', 'login'),
(51, '2017-08-11 10:47:54', '2', 'login'),
(52, '2017-08-11 10:53:56', '2', 'login'),
(53, '2017-08-11 10:55:37', '2', 'login'),
(54, '2017-08-11 12:13:13', '2', 'login'),
(55, '2017-08-11 12:16:16', '2', 'login'),
(56, '2017-08-11 12:17:24', '2', 'login'),
(57, '2017-08-11 12:26:03', '2', 'login'),
(58, '2017-08-11 12:28:27', '2', 'login'),
(59, '2017-08-11 12:29:51', '2', 'login'),
(60, '2017-08-11 12:34:13', '2', 'login'),
(61, '2017-08-11 13:04:08', '2', 'login'),
(62, '2017-08-11 13:15:18', '2', 'logout'),
(63, '2017-08-11 13:15:56', '2', 'login'),
(64, '2017-08-11 14:47:34', '2', 'logout'),
(65, '2017-08-14 05:37:43', '2', 'login'),
(66, '2017-08-14 05:41:15', '2', 'login'),
(67, '2017-08-14 11:13:25', '2', 'login'),
(68, '2017-08-14 11:41:39', '2', 'login'),
(69, '2017-08-14 11:41:53', '2', 'logout'),
(70, '2017-08-14 11:42:32', '2', 'login'),
(71, '2017-08-14 11:55:04', '2', 'login'),
(72, '2017-08-14 11:55:39', '2', 'login'),
(73, '2017-08-15 05:50:16', '11', 'login'),
(74, '2017-08-15 05:56:20', '2', 'login'),
(75, '2017-08-15 06:14:35', '2', 'login'),
(76, '2017-08-15 06:30:26', '11', 'login'),
(77, '2017-08-15 06:47:20', '11', 'login'),
(78, '2017-08-15 09:57:06', '11', 'login'),
(79, '2017-08-15 09:57:52', '11', 'logout'),
(80, '2017-08-16 08:29:20', '2', 'login'),
(81, '2017-08-16 09:00:47', '2', 'logout'),
(82, '2017-08-17 08:35:29', '2', 'login'),
(83, '2017-08-17 08:40:48', '2', 'logout'),
(84, '2017-08-18 04:55:52', '2', 'login'),
(85, '2017-08-18 04:56:47', '2', 'logout'),
(86, '2017-08-18 04:57:35', '2', 'login'),
(87, '2017-08-18 04:58:26', '2', 'logout'),
(88, '2017-08-18 05:00:36', '2', 'login'),
(89, '2017-08-18 05:16:24', '2', 'logout');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order_details_products1_idx` (`product_id`),
  ADD KEY `fk_order_details_orders1_idx` (`order_id`);

--
-- Indexes for table `paymentdetails`
--
ALTER TABLE `paymentdetails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_paymentdetails_orders1_idx` (`orders_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_products_categories_idx` (`category_id`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_stock_products1_idx` (`products_id`);

--
-- Indexes for table `tabeldetails`
--
ALTER TABLE `tabeldetails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tabelDetails_orders1_idx` (`orders_id`);

--
-- Indexes for table `table_no`
--
ALTER TABLE `table_no`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_log`
--
ALTER TABLE `user_log`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;
--
-- AUTO_INCREMENT for table `paymentdetails`
--
ALTER TABLE `paymentdetails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tabeldetails`
--
ALTER TABLE `tabeldetails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `table_no`
--
ALTER TABLE `table_no`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `user_log`
--
ALTER TABLE `user_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `fk_order_details_orders1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_order_details_products1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `paymentdetails`
--
ALTER TABLE `paymentdetails`
  ADD CONSTRAINT `fk_paymentdetails_orders1` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `fk_stock_products1` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
