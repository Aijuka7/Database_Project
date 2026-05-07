-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 07, 2026 at 01:34 AM
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
-- Database: `hotel_reservation_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `guest`
--

CREATE TABLE `guest` (
  `guest_id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guest`
--

INSERT INTO `guest` (`guest_id`, `name`, `phone`, `email`, `created_at`) VALUES
(1, 'John Kamya', '0701000001', 'john.kamya@gmail.com', '2026-05-05 09:49:30'),
(2, 'Sarah Nankya', '0701000002', 'sarah.n@gmail.com', '2026-05-05 09:49:30'),
(3, 'David Ouma', '0701000003', 'david.ouma@gmail.com', '2026-05-05 09:49:30'),
(4, 'Grace Amony', '0701000004', 'grace.amony@gmail.com', '2026-05-05 09:49:30'),
(5, 'Brian Ssemwanga', '0701000005', 'brian.s@gmail.com', '2026-05-05 09:49:30'),
(6, 'Linda Atim', '0701000006', 'linda.atim@gmail.com', '2026-05-05 09:49:30'),
(7, 'Michael Lutaaya', '0701000007', 'michael.l@gmail.com', '2026-05-05 09:49:30');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `reservation_id` int(11) DEFAULT NULL,
  `amount` bigint(20) NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `method` enum('cash','card','mm') NOT NULL,
  `status` enum('paid','confirmed','pending') DEFAULT 'paid',
  `reference_no` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `reservation_id`, `amount`, `payment_date`, `method`, `status`, `reference_no`) VALUES
(1, 1, 100000, '2026-05-05 09:52:22', 'cash', 'paid', 'REF001'),
(2, 2, 80000, '2026-05-05 09:52:22', 'card', 'paid', 'REF002'),
(3, 3, 120000, '2026-05-05 09:52:22', 'mm', 'confirmed', 'REF003'),
(4, 4, 0, '2026-05-05 09:52:22', 'cash', 'pending', 'REF004'),
(5, 5, 0, '2026-05-05 09:52:22', 'card', 'pending', 'REF005'),
(6, 6, 150000, '2026-05-05 09:52:22', 'mm', 'paid', 'REF006'),
(7, 7, 80000, '2026-05-05 09:52:22', 'cash', 'paid', 'REF007');

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `reservation_id` int(11) NOT NULL,
  `guest_id` int(11) DEFAULT NULL,
  `check_in_date` date NOT NULL,
  `CHECK_OUT_DATE` date NOT NULL,
  `STATUS` enum('pending','confirmed','checked in','checked out','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`reservation_id`, `guest_id`, `check_in_date`, `CHECK_OUT_DATE`, `STATUS`, `created_at`, `notes`) VALUES
(1, 1, '2026-05-01', '2026-05-03', 'checked out', '2026-05-05 09:51:07', 'No issues'),
(2, 2, '2026-05-02', '2026-05-04', 'checked in', '2026-05-05 09:51:07', 'Late arrival'),
(3, 3, '2026-05-03', '2026-05-05', 'confirmed', '2026-05-05 09:51:07', 'VIP guest'),
(4, 4, '2026-05-04', '2026-05-06', 'pending', '2026-05-05 09:51:07', 'Waiting payment'),
(5, 5, '2026-05-05', '2026-05-07', 'cancelled', '2026-05-05 09:51:07', 'Changed plans'),
(6, 6, '2026-05-06', '2026-05-08', 'confirmed', '2026-05-05 09:51:07', 'Family stay'),
(7, 7, '2026-05-07', '2026-05-09', 'checked in', '2026-05-05 09:51:07', 'Business trip');

-- --------------------------------------------------------

--
-- Table structure for table `reservation_room`
--

CREATE TABLE `reservation_room` (
  `reservation_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `room_rate` bigint(20) NOT NULL,
  `special_request` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservation_room`
--

INSERT INTO `reservation_room` (`reservation_id`, `room_id`, `room_rate`, `special_request`) VALUES
(1, 1, 50000, 'Near reception'),
(2, 2, 80000, 'Quiet room'),
(3, 4, 120000, 'VIP setup'),
(4, 3, 85000, 'Extra towels'),
(5, 5, 200000, 'Late checkout'),
(6, 7, 150000, 'Family setup'),
(7, 2, 80000, 'Business desk');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `room_id` int(11) NOT NULL,
  `room_number` varchar(10) NOT NULL,
  `room_type_id` int(11) DEFAULT NULL,
  `floor` int(11) DEFAULT NULL,
  `price_per_night` bigint(20) NOT NULL,
  `status` enum('available','occupied','maintenace','out_of_service') DEFAULT 'available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`room_id`, `room_number`, `room_type_id`, `floor`, `price_per_night`, `status`) VALUES
(1, '101', 1, 1, 50000, 'available'),
(2, '102', 2, 1, 80000, 'occupied'),
(3, '103', 3, 1, 85000, 'available'),
(4, '201', 4, 2, 120000, 'occupied'),
(5, '202', 5, 2, 200000, 'available'),
(6, '301', 6, 3, 180000, ''),
(7, '302', 7, 3, 150000, 'available');

-- --------------------------------------------------------

--
-- Table structure for table `room_type`
--

CREATE TABLE `room_type` (
  `room_type_id` int(11) NOT NULL,
  `type_name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `base_price` bigint(20) NOT NULL,
  `max_occupancy` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_type`
--

INSERT INTO `room_type` (`room_type_id`, `type_name`, `description`, `base_price`, `max_occupancy`) VALUES
(1, 'Single', 'Basic single room', 50000, 1),
(2, 'Double', 'Double bed room', 80000, 2),
(3, 'Twin', 'Two single beds', 85000, 2),
(4, 'Deluxe', 'Spacious deluxe room', 120000, 3),
(5, 'Suite', 'Luxury suite room', 200000, 4),
(6, 'Executive', 'Business executive room', 180000, 2),
(7, 'Family', 'Large family room', 150000, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `guest`
--
ALTER TABLE `guest`
  ADD PRIMARY KEY (`guest_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_reservation_payment` (`reservation_id`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `fk_guest` (`guest_id`);

--
-- Indexes for table `reservation_room`
--
ALTER TABLE `reservation_room`
  ADD PRIMARY KEY (`reservation_id`,`room_id`),
  ADD KEY `fk_room_link` (`room_id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`room_id`),
  ADD UNIQUE KEY `room_number` (`room_number`),
  ADD KEY `fk_room_type` (`room_type_id`);

--
-- Indexes for table `room_type`
--
ALTER TABLE `room_type`
  ADD PRIMARY KEY (`room_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `guest`
--
ALTER TABLE `guest`
  MODIFY `guest_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `room_type`
--
ALTER TABLE `room_type`
  MODIFY `room_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_reservation_payment` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`);

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `fk_guest` FOREIGN KEY (`guest_id`) REFERENCES `guest` (`guest_id`);

--
-- Constraints for table `reservation_room`
--
ALTER TABLE `reservation_room`
  ADD CONSTRAINT `fk_res_link` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`),
  ADD CONSTRAINT `fk_room_link` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`);

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `fk_room_type` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
