-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 17, 2025 at 03:23 PM
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
-- Database: `dev_kalasan_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `admin_name` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_name`, `username`, `email`, `profile_picture`, `password_hash`, `status`, `created_at`) VALUES
(3, 'Andree Javier', 'Andree', 'andreejavier45@gmail.com', NULL, '$2y$10$xN/EPxoX/ypFw7kcgyhkXe3jd54zNHfPnkAb.NgAfWu2c6JGbzhm2', 'active', '2024-11-07 15:09:45'),
(4, 'James Ian Pande', 'James', 'jamesianpande@gmail.com', NULL, '$2y$10$1nlM8aczLgobzI4HBv1SZ.zuNcnA5UtiyYj4e9TODB8QHsqBFOWG6', 'active', '2024-11-08 07:31:47'),
(5, 'Christopher Dajao', 'ChrisGIS', 'language_23@yahoo.com', NULL, '$2y$10$/II1c.9/9qAbhEjk5pkibedYa7lPxWBC3Q3GsU2n0YmMv9GvHPYC.', 'active', '2024-11-08 07:49:36'),
(6, 'andreejavier', 'andreejavier', 'andreejavier@gmail.com', NULL, '$2y$10$JXQDgxeUQhSRJULYn9.b4Ocy2GVNN1fJWx.SMNOLbaYjaV9n.B21O', 'active', '2024-11-21 02:33:57'),
(7, 'andree', '123', 'andreejav@gmail.com', NULL, '$2y$10$fl4N/.LwTt.Q66esbsgQUuEeOJpqwj/0EUHZ9vwULzZVqiKdxuaD2', 'active', '2025-03-13 13:35:13');

-- --------------------------------------------------------

--
-- Table structure for table `analytics`
--

CREATE TABLE `analytics` (
  `id` int(11) NOT NULL,
  `tree_planted_id` int(11) DEFAULT NULL,
  `total_count` int(11) DEFAULT 0,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `tree_planted_id` int(11) DEFAULT NULL,
  `review_by` int(11) DEFAULT NULL,
  `review_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','agree','disagree') DEFAULT 'pending',
  `comments` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tree_images`
--

CREATE TABLE `tree_images` (
  `id` int(11) NOT NULL,
  `tree_planted_id` int(11) NOT NULL,
  `image_path` longblob NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tree_images`
--

INSERT INTO `tree_images` (`id`, `tree_planted_id`, `image_path`, `uploaded_at`) VALUES
(6, 30, 0x75706c6f6164732f74726565732f313733313435353537335f494d475f32303234313130375f3039303232302e6a7067, '2024-11-12 23:52:53'),
(7, 30, 0x75706c6f6164732f74726565732f313733313435353833375f494d475f32303234313130375f3039303232302e6a7067, '2024-11-12 23:57:17'),
(8, 30, 0x75706c6f6164732f74726565732f313733313435363432385f494d475f32303234313130375f3039303232302e6a7067, '2024-11-13 00:07:08'),
(9, 30, 0x75706c6f6164732f74726565732f313733313435363731345f494d475f32303234313130375f3039303232302e6a7067, '2024-11-13 00:11:54'),
(10, 30, 0x75706c6f6164732f74726565732f313733313435363839395f494d475f32303234313130375f3039303232302e6a7067, '2024-11-13 00:14:59'),
(11, 30, 0x75706c6f6164732f74726565732f313733313435373135325f494d475f32303234313130375f3039303232302e6a7067, '2024-11-13 00:19:12'),
(12, 30, 0x75706c6f6164732f74726565732f313733313435373138345f494d475f32303234313130375f3039303232302e6a7067, '2024-11-13 00:19:44'),
(13, 30, 0x75706c6f6164732f74726565732f313733313435373533345f494d475f32303234313130375f3039303131372e6a7067, '2024-11-13 00:25:34'),
(14, 30, 0x75706c6f6164732f74726565732f313733313435373738355f494d475f32303234313130375f3039303131372e6a7067, '2024-11-13 00:29:45'),
(15, 30, 0x75706c6f6164732f74726565732f313733313435373831325f494d475f32303234313130375f3039303131372e6a7067, '2024-11-13 00:30:12'),
(16, 30, 0x75706c6f6164732f74726565732f313733313435373833385f494d475f32303234313130375f3039303131372e6a7067, '2024-11-13 00:30:38'),
(19, 12, 0x75706c6f6164732f74726565732f313733313435393836335f47656f63616d5f33302d31302d323032345f3131313531315f646174612e6a7067, '2024-11-13 01:04:23'),
(20, 12, 0x75706c6f6164732f74726565732f313733313436303532335f47656f63616d5f33302d31302d323032345f3131313531315f646174612e6a7067, '2024-11-13 01:15:23'),
(21, 12, 0x75706c6f6164732f74726565732f313733313436303539345f47656f63616d5f33302d31302d323032345f3131313531315f646174612e6a7067, '2024-11-13 01:16:34'),
(22, 12, 0x75706c6f6164732f74726565732f313733313436303633395f47656f63616d5f33302d31302d323032345f3131313531315f646174612e6a7067, '2024-11-13 01:17:19'),
(23, 36, 0x75706c6f6164732f74726565732f313733313939353933365f47656f63616d5f32342d31302d323032345f3039353333395f646174612e6a7067, '2024-11-19 05:58:56');

-- --------------------------------------------------------

--
-- Table structure for table `tree_planted`
--

CREATE TABLE `tree_planted` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `exif_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`exif_data`)),
  `validated` tinyint(1) DEFAULT 0,
  `species_name` varchar(100) NOT NULL,
  `scientific_name` varchar(150) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` enum('Endemic','Indigenous') NOT NULL DEFAULT 'Endemic',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `admin_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tree_planted`
--

INSERT INTO `tree_planted` (`id`, `user_id`, `latitude`, `longitude`, `date_time`, `address`, `image_path`, `exif_data`, `validated`, `species_name`, `scientific_name`, `description`, `category`, `created_at`, `admin_id`) VALUES
(12, 8, 8.32146667, 124.80703056, NULL, 'Manolo Fortich-Libona Road, Camp Phillips, Agusan Canyon, Manolo Fortich, Bukidnon, Northern Mindanao, 8703, Philippines', 'uploads/672dc7f19f5e1-Geocam_30-10-2024_111511_data.jpg', '{\"latitude\":\"8.321466666666666\",\"longitude\":\"124.80703055555556\",\"date_time\":\"2024:11:08 16:05:10\",\"address\":\"Manolo Fortich-Libona Road, Camp Phillips, Agusan Canyon, Manolo Fortich, Bukidnon, Northern Mindanao, 8703, Philippines\"}', 0, 'Coconut', 'Cocos nucifera', 'Giant Coconut', 'Indigenous', '2024-11-08 08:12:33', 0),
(30, 8, 8.36269500, 124.87506700, NULL, 'Tankulan (Pob.), Manolo Fortich, Bukidnon, Northern Mindanao, 8703, Philippines', 'uploads/67336af148e7a-IMG_20241107_090050.jpg', NULL, 0, 'Alingatong', 'Urtica dioica L', 'Alingatong is a Filipino term that refers to Laportea brunnea, which is also known as nettle1. Nettle root is an herbal supplement taken from the roots of the nettle plant, which is scientifically known as Urtica dioica L2.', 'Endemic', '2024-11-12 14:49:21', 0),
(31, 8, 8.36271000, 124.87422700, '2024-11-09 14:53:43', 'Tankulan (Pob.), Manolo Fortich, Bukidnon, 8000, Philippines', 'uploads/6733f92d29495-IMG_20241109_145342.jpg', NULL, 0, '', NULL, NULL, 'Endemic', '2024-11-13 00:56:13', 0),
(32, 8, 8.35802000, 124.87322000, NULL, 'Tankulan (Pob), Manolo Fortich, Bukidnon', 'uploads/673418cd1045b-IMG_20241109_161815.jpg', NULL, 0, 'Narra', 'Pterocarpus indicus', ' Narra (Pterocarpus indicus) is a large deciduous reddish hardwood tree', 'Endemic', '2024-11-13 03:11:09', 0),
(33, 8, 8.36134700, 124.87349900, '2024-11-09 16:33:17', 'Tankulan (Pob.), Manolo Fortich, Bukidnon, Northern Mindanao, Philippines', 'uploads/67341a388f31b-IMG_20241109_163317.jpg', NULL, 0, '', NULL, NULL, 'Endemic', '2024-11-13 03:17:12', 0),
(36, 8, 8.41305000, 124.98522778, '0000-00-00 00:00:00', 'Impakibel, Santiago, Manolo Fortich, Bukidnon, Northern Mindanao, Philippines', 'uploads/plant_673c28c7d28705.69139662.jpg', NULL, 0, '', NULL, NULL, 'Endemic', '2024-11-19 05:57:27', 0),
(37, 8, 8.41333056, 124.98502778, '0000-00-00 00:00:00', 'Impakibel, Santiago, Manolo Fortich, Bukidnon, Northern Mindanao, Philippines', 'uploads/plant_673c2fb8c064b3.24700430.jpg', NULL, 0, '', NULL, NULL, 'Endemic', '2024-11-19 06:27:04', 0),
(38, 8, 8.41343611, 124.98503889, '0000-00-00 00:00:00', 'Impakibel, Santiago, Manolo Fortich, Bukidnon, Northern Mindanao, Philippines', 'uploads/plant_673c3012678807.24720621.jpg', NULL, 0, '', NULL, NULL, 'Endemic', '2024-11-19 06:28:34', 0),
(39, 8, 8.25251944, 124.99793611, NULL, 'Cawayan, Impasugong, Bukidnon, Northern Mindanao, 8702, Philippines', 'uploads/plant_673c30a5cb28e4.18946095.jpg', NULL, 0, 'Bamboo', 'Need ID', 'Need ID', 'Endemic', '2024-11-19 06:31:01', 0),
(40, 8, 8.41298889, 124.98521944, '0000-00-00 00:00:00', 'Impakibel, Santiago, Manolo Fortich, Bukidnon, Northern Mindanao, Philippines', 'uploads/plant_673c3148e08f51.77709534.jpg', NULL, 0, '', NULL, NULL, 'Endemic', '2024-11-19 06:33:44', 0),
(41, 8, 8.41330556, 124.98492778, '0000-00-00 00:00:00', 'Impakibel, Santiago, Manolo Fortich, Bukidnon, Northern Mindanao, Philippines', 'uploads/plant_673c318f60c912.01776617.jpg', NULL, 0, '', NULL, NULL, 'Endemic', '2024-11-19 06:34:55', 0),
(42, 8, 8.41343611, 124.98503889, '0000-00-00 00:00:00', 'Impakibel, Santiago, Manolo Fortich, Bukidnon, Northern Mindanao, Philippines', 'uploads/plant_673c344d0e00f6.48699840.jpg', NULL, 0, '', NULL, NULL, 'Endemic', '2024-11-19 06:46:37', 0),
(43, 8, 8.25255278, 124.99803056, NULL, 'Cawayan, Impasugong, Bukidnon, Northern Mindanao, 8702, Philippines', 'uploads/plant_6756e4027e8639.57650436.jpg', NULL, 0, 'Bamboo', 'Need ID', 'Need ID', 'Endemic', '2024-12-09 12:35:14', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `profile_picture` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password_hash`, `email`, `role`, `profile_picture`, `created_at`) VALUES
(5, 'Andree', '$2y$10$4Ks2Ophr80QHweaLOKuS9u.LLYio7UgErzDOUmUsBchHImCjQ2cdG', 'Andree@gmail.com', 'user', NULL, '2024-11-06 13:18:18'),
(6, 'AndreeJavier', '$2y$10$iVyWc4XUrZy9DEH5XblOLeJFLu9it/88om1SSJGqWGl1h3gkndaVO', 'andreejavier45@gmail.com', 'user', NULL, '2024-11-08 00:08:39'),
(7, 'Andree P Javier', '$2y$10$PvA2rR0IGaRyYJ5RamlgFuyY7bhhSaj6Jv4zvtVWu4xpY.dpdCNUu', 'AndreePJavier@gmail.com', 'user', NULL, '2024-11-08 00:21:39'),
(8, 'Andree Javier', '$2y$10$..HYYV9cVb9.hXTtUDtPHeaoAkZQbIVCJ1o.BmSTpQFsMskTVNJs2', 'javierandree45@gmail.com', 'user', '474065298_2480316655646309_4988904181392295149_n (1).jpg', '2024-11-07 20:44:25'),
(9, 'samantha', '$2y$10$/NbXlgvHo0V40JzXDOuv6.rQmDuKsBDxzS567IssBwfnB81kHESia', 'samanthasolijon@gamil.com', 'user', NULL, '2024-11-11 05:26:49');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `analytics`
--
ALTER TABLE `analytics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tree_planted_id` (`tree_planted_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tree_planted_id` (`tree_planted_id`),
  ADD KEY `review_by` (`review_by`);

--
-- Indexes for table `tree_images`
--
ALTER TABLE `tree_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tree_planted_id` (`tree_planted_id`);

--
-- Indexes for table `tree_planted`
--
ALTER TABLE `tree_planted`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tree_planted_user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `analytics`
--
ALTER TABLE `analytics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tree_images`
--
ALTER TABLE `tree_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `tree_planted`
--
ALTER TABLE `tree_planted`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `analytics`
--
ALTER TABLE `analytics`
  ADD CONSTRAINT `analytics_ibfk_1` FOREIGN KEY (`tree_planted_id`) REFERENCES `tree_planted` (`id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_review_by_admin` FOREIGN KEY (`review_by`) REFERENCES `admin` (`admin_id`),
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`tree_planted_id`) REFERENCES `tree_planted` (`id`);

--
-- Constraints for table `tree_images`
--
ALTER TABLE `tree_images`
  ADD CONSTRAINT `tree_images_ibfk_1` FOREIGN KEY (`tree_planted_id`) REFERENCES `tree_planted` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tree_planted`
--
ALTER TABLE `tree_planted`
  ADD CONSTRAINT `fk_tree_planted_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
