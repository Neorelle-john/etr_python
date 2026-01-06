-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 06, 2026 at 04:01 PM
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
-- Database: `etr_ecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `full_address` text NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `customer_id`, `full_address`, `city`, `state`, `zip_code`, `country`, `is_default`, `created_at`) VALUES
(1, 1, 'San vicente, Urdaneta City', 'Urdaneta city', '', '2428', 'Philippines', 1, '2026-01-06 14:02:12'),
(2, 1, '#288, ZONE 4, Poblacion East, Burgos Pangasinan', 'Burgos', '', '2428', 'Philippines', 0, '2026-01-06 14:09:29');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `username` varchar(80) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `profile_picture_url` varchar(255) DEFAULT NULL,
  `email_notifications` tinyint(1) DEFAULT NULL,
  `order_updates` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Customer table - Contains both customers and admin users. Check is_admin column (1=Admin, 0=Customer)';

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `username`, `email`, `password_hash`, `first_name`, `last_name`, `phone`, `address`, `city`, `state`, `zip_code`, `country`, `gender`, `date_of_birth`, `profile_picture_url`, `email_notifications`, `order_updates`, `created_at`, `is_active`, `middle_name`, `is_admin`) VALUES
(1, 'JohnLloyd', 'lloyd@gmail.com', 'scrypt:32768:8:1$MGuY2Qaow4jed6Hp$bc588bd97ddc75bb05dcbb98bc170049b2b2d4a22799713297b21462af873b1ad728ea19a1616bed2529a830518db43f9c6b635d6a0d49609191c91af4415131', 'Lloyd', 'Cruz', '09918890811', 'San vicente, Urdaneta City', '', 'Urdaneta city', '2428', 'Philippines', NULL, NULL, NULL, 1, 1, '2026-01-06 14:02:12', 1, 'Magellan', 0),
(2, 'admin', 'admin@gmail.com', 'scrypt:32768:8:1$1BvJCsODs61ColAn$5cf6bd7e7f6fb6ec35fccf33bbb8ef6280b594dac6ddfb4063cf541600f8cb4b0e08689832125c97cbc9e9866f714378ccb2548532596c83eea16dc42961d9c7', 'Admin', 'User', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, '2026-01-06 14:34:44', 1, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(50) NOT NULL,
  `is_read` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`id`, `customer_id`, `order_id`, `title`, `message`, `type`, `is_read`, `created_at`) VALUES
(1, 1, 1, 'Order Placed', 'Your order #ORD-20260106-1-1 has been placed successfully. Total: ₱35007.99', 'order_created', 0, '2026-01-06 14:23:14'),
(6, 1, 4, 'Order Placed', 'Your order #ORD-20260106-1-2 has been placed successfully. Total: ₱507.99', 'order_created', 0, '2026-01-06 14:32:46');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_status` varchar(20) DEFAULT NULL,
  `shipping_address` text NOT NULL,
  `shipping_city` varchar(100) NOT NULL,
  `shipping_state` varchar(100) DEFAULT NULL,
  `shipping_zip` varchar(20) DEFAULT NULL,
  `shipping_country` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `decline_reason` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`id`, `order_number`, `customer_id`, `total_amount`, `status`, `payment_method`, `payment_status`, `shipping_address`, `shipping_city`, `shipping_state`, `shipping_zip`, `shipping_country`, `created_at`, `updated_at`, `decline_reason`) VALUES
(1, 'ORD-20260106-1-1', 1, 35007.99, 'To Ship', 'gcash_payment', 'Paid', 'San vicente, Urdaneta City', 'Urdaneta city', '', '2428', 'Philippines', '2026-01-06 14:23:14', '2026-01-06 14:23:14', NULL),
(4, 'ORD-20260106-1-2', 1, 507.99, 'Pending', 'cash_on_delivery', 'Pending', 'San vicente, Urdaneta City', 'Urdaneta city', '', '2428', 'Philippines', '2026-01-06 14:32:46', '2026-01-06 14:32:46', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_item`
--

INSERT INTO `order_item` (`id`, `order_id`, `product_id`, `quantity`, `price`, `subtotal`) VALUES
(1, 1, 6, 1, 34999.99, 34999.99),
(4, 4, 53, 1, 499.99, 499.99);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_token`
--

CREATE TABLE `password_reset_token` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `expires_at` datetime NOT NULL,
  `used` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `proof_image` varchar(500) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`id`, `order_id`, `payment_method`, `amount`, `proof_image`, `status`, `created_at`) VALUES
(1, 1, 'gcash_payment', 35007.99, NULL, 'Verified', '2026-01-06 14:23:14'),
(4, 4, 'cash_on_delivery', 507.99, NULL, 'Pending', '2026-01-06 14:32:46');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(100) NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `description`, `price`, `category`, `stock`, `image_url`, `brand`, `sku`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Wireless Bluetooth Headphones', 'High-quality wireless headphones with noise cancellation and 30-hour battery life. Perfect for music lovers and professionals.', 2999.99, 'Electronics', 50, 'images/products/Wirelessbluetoothheadphones.jpg', 'AudioTech', 'ATH-WB-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:33:25'),
(2, 'Smartphone 128GB', 'Latest smartphone with 128GB storage, triple camera system, and fast charging. Available in multiple colors.', 24999.99, 'Electronics', 25, 'images/products/smartP.jpg', 'Samsung', 'TP-SM-128', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(3, 'Wireless Mouse', 'Ergonomic wireless mouse with long battery life and precise tracking. Compatible with all operating systems.', 599.99, 'Electronics', 80, 'images/products/wmouse.jpg', 'LogiTech', 'TM-WM-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(4, 'Gaming Keyboard', 'Mechanical gaming keyboard with RGB backlighting and programmable keys. Perfect for gamers.', 4499.99, 'Electronics', 35, 'images/products/keyb.jpg', 'LogiTech', 'GT-GK-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(5, 'Smart Watch Pro', 'Feature-rich smartwatch with fitness tracking, heart rate monitor, GPS, and 7-day battery life. Water-resistant design.', 8999.99, 'Electronics', 30, 'images/products/smartW.jpg', 'AppleStore', 'TW-SW-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(6, '4K Ultra HD TV 55\"', '55-inch 4K Ultra HD Smart TV with HDR support, built-in streaming apps, and voice control. Perfect for home entertainment.', 34999.99, 'Electronics', 14, 'images/products/tv.jpg', 'Life Good', 'VT-TV-55', 1, '2026-01-05 16:49:32', '2026-01-06 14:23:14'),
(7, 'Cotton T-Shirt', 'Comfortable 100% cotton t-shirt. Available in various sizes and colors. Perfect for everyday wear.', 499.99, 'Clothing', 100, 'images/products/tshirt.jpg', 'MNL-Clothing', 'FW-TS-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(8, 'Denim Jeans', 'Classic fit denim jeans made from premium cotton. Available in various sizes and washes.', 1299.99, 'Clothing', 55, 'images/products/jeans.jpg', 'MNL-Clothing', 'FW-DJ-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(9, 'Hooded Sweatshirt', 'Warm and comfortable hooded sweatshirt with front pocket. Perfect for casual wear and outdoor activities.', 1499.99, 'Clothing', 65, 'images/products/hood.jpg', 'ComfortWear', 'CW-HS-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(10, 'Polo Shirt', 'Classic polo shirt made from breathable cotton blend. Perfect for business casual or weekend wear.', 799.99, 'Clothing', 70, 'images/products/poloS.jpg', 'HUILISHI', 'SW-PS-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(11, 'Summer Dress', 'Lightweight and elegant summer dress with floral pattern. Perfect for warm weather and special occasions.', 1899.99, 'Clothing', 40, 'images/products/summerD.jpg', 'Elegance', 'EL-SD-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(12, 'Leather Jacket', 'Genuine leather jacket with classic design. Durable and stylish, perfect for all seasons.', 5999.99, 'Clothing', 20, 'images/products/letherJack.jpg', 'MNL-Clothing', 'LC-LJ-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(13, 'Running Shoes', 'Lightweight running shoes with cushioned sole and breathable mesh upper. Ideal for jogging and sports.', 3499.99, 'Footwear', 40, 'images/products/nikeS.jpg', 'SportCenter', 'SM-RS-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(14, 'Casual Sneakers', 'Comfortable casual sneakers with modern design. Perfect for everyday wear and walking.', 2499.99, 'Footwear', 50, 'images/products/Sneak.jpg', 'SportCenter', 'CS-CS-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(15, 'Leather Shoes', 'Elegant leather dress shoes with classic design. Perfect for formal occasions and business wear.', 2799.99, 'Footwear', 30, 'images/products/lshoes.jpg', 'Bragais', 'FS-LDS-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(16, 'Hiking Boots', 'Durable hiking boots with waterproof membrane and superior grip. Perfect for outdoor adventures.', 1999.00, 'Footwear', 25, 'images/products/hikingSh.jpg', 'AdventureFoot', 'AF-HB-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(17, 'Sandals', 'Comfortable sandals with adjustable straps and cushioned footbed. Perfect for summer and beach.', 899.00, 'Footwear', 60, 'images/products/sandal.jpg', 'SummerStep', 'SS-SD-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(18, 'Basketball Shoes', 'High-performance basketball shoes with excellent ankle support and superior traction. Designed for athletes.', 5499.99, 'Footwear', 35, 'images/products/lebronS.jpg', 'SportCenter', 'SM-BS-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(19, 'Laptop Backpack', 'Durable laptop backpack with padded compartment for laptops up to 15.6 inches. Multiple pockets for organization.', 1299.99, 'Accessories', 60, 'images/products/laptopB.jpg', 'TravelGear', 'TG-LB-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(20, 'Leather Wallet', 'Genuine leather wallet with multiple card slots and cash compartment. Classic design.', 799.00, 'Accessories', 45, 'images/products/walletL.jpg', 'LeatherCraft', 'LC-WL-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(21, 'Stainless Steel Water Bottle', 'Insulated stainless steel water bottle keeps drinks cold for 24 hours or hot for 12 hours. BPA-free.', 699.00, 'Accessories', 90, 'images/products/tumbler.jpg', 'EcoBottle', 'EB-WB-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(22, 'Sunglasses', 'Stylish sunglasses with UV400 protection and polarized lenses. Available in multiple frame colors.', 1299.99, 'Accessories', 55, 'images/products/Iglases.jpg', 'Dior', 'SS-SG-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(23, 'Leather Belt', 'Genuine leather belt with classic buckle design. Adjustable size to fit various waist sizes.', 299.00, 'Accessories', 50, 'images/products/belts.jpg', 'LeatherCraft', 'LC-LB-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(24, 'Smartphone Case', 'Protective smartphone case with shock-absorbing design. Available for various phone models.', 399.00, 'Accessories', 120, 'images/products/case.jpg', 'ProtectTech', 'PT-SC-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(25, 'Coffee Maker', 'Programmable coffee maker with 12-cup capacity. Auto shut-off and brew strength control.', 14999.99, 'Home & Kitchen', 30, 'images/products/CM.jpg', 'BrewMaster', 'BM-CM-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(26, 'Air Fryer', 'Digital air fryer with large capacity. Cook healthier meals with less oil. Easy to clean and use.', 4999.99, 'Home & Kitchen', 25, 'images/products/airf.jpg', 'KitchenPro', 'KP-AF-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(27, 'Blender', 'High-speed blender with multiple settings. Perfect for smoothies, soups, and sauces. Easy to clean.', 1499.99, 'Home & Kitchen', 35, 'images/products/blender.jpg', 'BlendTech', 'BT-BL-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(28, 'Dinnerware Set', 'Complete dinnerware set for 6 people. Includes plates, bowls, and mugs. Dishwasher safe and durable.', 1499.99, 'Home & Kitchen', 40, 'images/products/dinnerSet.jpg', 'HomeStyle', 'HS-DS-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(29, 'Cookware Set', 'Non-stick cookware set with 10 pieces. Includes various pots and pans. Oven safe up to 400°F.', 5999.99, 'Home & Kitchen', 20, 'images/products/cookset.jpg', 'ChefPro', 'CP-CS-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(30, 'Stand Mixer', 'Powerful stand mixer with multiple attachments. Perfect for baking and mixing. Includes dough hook and whisk.', 6999.99, 'Home & Kitchen', 15, 'images/products/KT.jpg', 'BakeMaster', 'BM-SM-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(31, 'Yoga Mat', 'Non-slip yoga mat with extra cushioning. Perfect for yoga, pilates, and exercise routines.', 199.99, 'Sports & Fitness', 75, 'images/products/yogaM.jpg', 'FitLife', 'FL-YM-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(32, 'Dumbbell Set', 'Adjustable dumbbell set with weights from 5kg to 25kg. Perfect for home workouts and strength training.', 1099.99, 'Sports & Fitness', 20, 'images/products/dumpbell.jpg', 'PowerFit', 'PF-DS-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(33, 'Resistance Bands Set', 'Complete resistance bands set with 5 different resistance levels. Includes door anchor and exercise guide.', 299.99, 'Sports & Fitness', 50, 'images/products/resistance.jpg', 'FlexBand', 'FB-RS-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(34, 'Jump Rope', 'Professional speed jump rope with adjustable length. Perfect for cardio workouts and weight loss.', 199.99, 'Sports & Fitness', 80, 'images/products/jumprope.jpg', 'SpeedJump', 'SJ-JR-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(35, 'Foam Roller', 'High-density foam roller for muscle recovery and massage. Helps reduce muscle soreness and improve flexibility.', 299.99, 'Sports & Fitness', 45, 'images/products/roler.jpg', 'RecoveryPro', 'RP-FR-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(36, 'Exercise Bike', 'Indoor exercise bike with adjustable resistance and digital display. Perfect for home cardio workouts.', 12999.99, 'Sports & Fitness', 10, 'images/products/bike.jpg', 'CardioFit', 'CF-EB-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(37, 'Laptop 15.6\"', 'High-performance laptop with 15.6-inch display, 16GB RAM, and 512GB SSD. Perfect for work and gaming.', 49999.99, 'Electronics', 20, 'images/products/laptop.jpg', 'TechPro', 'TP-LP-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(38, 'Wireless Earbuds', 'True wireless earbuds with noise cancellation and 8-hour battery life. Perfect for music and calls.', 1999.99, 'Electronics', 60, 'images/products/wirelessearbdus.jpg', 'AudioTech', 'ATH-WE-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:33:25'),
(39, 'Tablet 10.1\"', '10.1-inch tablet with high-resolution display and long battery life. Perfect for reading and entertainment.', 14999.99, 'Electronics', 30, 'images/products/tablet.jpg', 'TechPro', 'TP-TB-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(40, 'Portable Speaker', 'Bluetooth portable speaker with 360-degree sound and waterproof design. Perfect for outdoor activities.', 2499.99, 'Electronics', 45, 'images/products/speaker.jpg', 'SoundMax', 'SM-PS-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(41, 'Action Camera', '4K action camera with waterproof case and image stabilization. Perfect for sports and adventures.', 8999.99, 'Electronics', 25, 'images/products/actioncam.jpg', 'ActionCam', 'AC-CM-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:33:25'),
(42, 'Winter Jacket', 'Warm winter jacket with water-resistant outer shell and insulated lining. Perfect for cold weather.', 3999.99, 'Clothing', 35, 'images/products/winterjacket.jpg', 'WarmWear', 'WW-WJ-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(43, 'Formal Shirt', 'Classic formal dress shirt made from premium cotton. Perfect for business and formal occasions.', 1299.99, 'Clothing', 50, 'images/products/formalshirt.jpg', 'FormalWear', 'FW-FS-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(44, 'Athletic Shorts', 'Comfortable athletic shorts with moisture-wicking fabric. Perfect for sports and workouts.', 599.99, 'Clothing', 80, 'images/products/athleticshorts.jpg', 'SportWear', 'SW-AS-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:30:19'),
(45, 'Cardigan Sweater', 'Soft cardigan sweater with button front. Perfect for layering in cool weather.', 1799.99, 'Clothing', 40, 'images/products/cardigansweater.jpg', 'ComfortWear', 'CW-CS-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:30:19'),
(46, 'Tank Top', 'Comfortable tank top made from breathable cotton. Perfect for summer and casual wear.', 399.99, 'Clothing', 90, 'images/products/tank.jpg', 'MNL-Clothing', 'FW-TT-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:30:19'),
(51, 'Wristwatch', 'Classic analog wristwatch with leather strap. Water-resistant and elegant design.', 1999.99, 'Accessories', 40, 'images/products/Wristwatch.jpg', 'TimeCraft', 'TC-WW-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:24:43'),
(52, 'Necklace', 'Elegant silver necklace with pendant. Perfect gift for special occasions.', 1499.99, 'Accessories', 35, 'images/products/Necklace.jpg', 'JewelCraft', 'JC-NK-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:24:43'),
(53, 'Baseball Cap', 'Classic baseball cap with adjustable strap. Perfect for sun protection and casual style.', 499.99, 'Accessories', 69, 'images/products/bccs.jpg', 'CapStyle', 'CS-BC-001', 1, '2026-01-05 16:49:32', '2026-01-06 14:32:46'),
(54, 'Travel Bag', 'Durable travel bag with multiple compartments and wheels. Perfect for trips and vacations.', 3499.99, 'Accessories', 30, 'images/products/Travel Bag.jpg', 'TravelGear', 'TG-TB-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:24:43'),
(55, 'Scarf', 'Soft and warm scarf made from premium materials. Perfect for winter fashion.', 699.99, 'Accessories', 55, 'images/products/scarf.jpg', 'WarmStyle', 'WS-SC-001', 1, '2026-01-05 16:49:32', '2026-01-05 16:49:32'),
(56, 'Microwave Oven', 'Compact microwave oven with multiple cooking modes and defrost function. Perfect for quick meals.', 3999.99, 'Home & Kitchen', 25, 'images/products/moo.jpg', 'KitchenPro', 'KP-MO-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:21:54'),
(57, 'Toaster', '4-slice toaster with multiple browning settings and bagel mode. Perfect for breakfast.', 1499.99, 'Home & Kitchen', 40, 'images/products/Toaster.jpg', 'KitchenPro', 'KP-TO-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:21:54'),
(58, 'Cutlery Set', 'Stainless steel cutlery set for 8 people. Includes knives, forks, and spoons. Dishwasher safe.', 999.99, 'Home & Kitchen', 50, 'images/products/css.jpg', 'HomeStyle', 'HS-CS-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:21:54'),
(59, 'Bedding Set', 'Complete bedding set including sheets, pillowcases, and comforter. Soft and comfortable materials.', 2499.99, 'Home & Kitchen', 30, 'images/products/bss.jpg', 'ComfortHome', 'CH-BS-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:21:54'),
(60, 'Vacuum Cleaner', 'Powerful vacuum cleaner with HEPA filter and multiple attachments. Perfect for home cleaning.', 5999.99, 'Home & Kitchen', 20, 'images/products/vc.jpg', 'CleanPro', 'CP-VC-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:21:54'),
(61, 'Rice Cooker', 'Automatic rice cooker with keep-warm function and multiple cooking modes. Perfect for daily meals.', 1999.99, 'Home & Kitchen', 35, 'images/products/rcc.jpg', 'KitchenPro', 'KP-RC-001', 1, '2026-01-05 16:49:32', '2026-01-06 13:21:54'),
(62, 'Treadmill', 'NordicTrack treadmill with digital console, adjustable speed and incline. Features handlebars, multiple workout programs, and folding design for home fitness.', 21999.99, 'Sports & Fitness', 6, 'images/products/treadmill.jpg', 'NordicTrack', 'CF-TM-001', 1, '2026-01-05 16:49:32', '2026-01-06 12:55:43'),
(63, 'Pull-up Bar', 'Wall-mounted pull-up bar with multiple grip positions. Features padded handles, neutral grips, and wide grip options. Perfect for upper body strength training.', 1299.99, 'Sports & Fitness', 30, 'images/products/pullupbar.jpg', 'PowerFit', 'PF-PB-001', 1, '2026-01-05 16:49:32', '2026-01-06 12:55:43'),
(64, 'Kettlebell Set', 'Complete kettlebell set with two-tier rack. Includes 20 kettlebells ranging from 4KG to 42KG with color-coded bands. Perfect for comprehensive strength training.', 4999.99, 'Sports & Fitness', 12, 'images/products/kettlebell.jpg', 'PowerFit', 'PF-KS-001', 1, '2026-01-05 16:49:32', '2026-01-06 12:55:43'),
(65, 'Fitness Tracker', 'Whoop fitness tracker with 24/7 wear capability and wireless charging. Features 99% accurate heart rate tracking, HRV monitoring, and personalized coaching insights.', 2999.99, 'Sports & Fitness', 45, 'images/products/fitnesstracker.jpg', 'Whoop', 'FL-FT-001', 1, '2026-01-05 16:49:32', '2026-01-06 12:55:43'),
(66, 'Medicine Ball', 'Set of three black medicine balls with dimpled texture for better grip. Available in 4KG, 7KG, and 10KG weights. Perfect for strength training and core workouts.', 1499.99, 'Sports & Fitness', 25, 'images/products/medicineball.jpg', 'PowerFit', 'PF-MB-001', 1, '2026-01-05 16:49:32', '2026-01-06 12:55:43');

-- --------------------------------------------------------

--
-- Stand-in structure for view `user_roles_view`
-- (See below for the actual view)
--
CREATE TABLE `user_roles_view` (
`id` int(11)
,`username` varchar(80)
,`email` varchar(120)
,`first_name` varchar(100)
,`last_name` varchar(100)
,`user_role` varchar(8)
,`is_admin` tinyint(1)
,`is_active` tinyint(1)
,`created_at` datetime
);

-- --------------------------------------------------------

--
-- Structure for view `user_roles_view`
--
DROP TABLE IF EXISTS `user_roles_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `user_roles_view`  AS SELECT `customer`.`id` AS `id`, `customer`.`username` AS `username`, `customer`.`email` AS `email`, `customer`.`first_name` AS `first_name`, `customer`.`last_name` AS `last_name`, CASE WHEN `customer`.`is_admin` = 1 THEN 'Admin' ELSE 'Customer' END AS `user_role`, `customer`.`is_admin` AS `is_admin`, `customer`.`is_active` AS `is_active`, `customer`.`created_at` AS `created_at` FROM `customer` ORDER BY `customer`.`is_admin` DESC, `customer`.`created_at` DESC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `password_reset_token`
--
ALTER TABLE `password_reset_token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `order_item`
--
ALTER TABLE `order_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `password_reset_token`
--
ALTER TABLE `password_reset_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  ADD CONSTRAINT `notification_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`);

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

--
-- Constraints for table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `password_reset_token`
--
ALTER TABLE `password_reset_token`
  ADD CONSTRAINT `password_reset_token_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
