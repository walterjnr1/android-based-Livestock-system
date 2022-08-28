-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 22, 2022 at 10:30 AM
-- Server version: 5.7.38-cll-lve
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `leastpa1_livestock_record`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `ID` int(3) NOT NULL,
  `username` varchar(15) NOT NULL,
  `password` varchar(15) NOT NULL,
  `fullname` varchar(40) NOT NULL,
  `status` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`ID`, `username`, `password`, `fullname`, `status`) VALUES
(1, 'admin', 'admin123', 'Administrator', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `livestock`
--

CREATE TABLE `livestock` (
  `ID` int(5) NOT NULL,
  `username` varchar(20) NOT NULL,
  `name` varchar(15) NOT NULL,
  `sex` varchar(6) NOT NULL,
  `livestock_no` varchar(15) NOT NULL,
  `weight` varchar(10) NOT NULL,
  `status` varchar(15) NOT NULL,
  `date_register` varchar(22) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `livestock`
--

INSERT INTO `livestock` (`ID`, `username`, `name`, `sex`, `livestock_no`, `weight`, `status`, `date_register`) VALUES
(39, 'walterjnr1', 'Sheep', 'Female', '330', '90', 'Sick', '2022-08-16'),
(40, 'futurelab', 'Goat', 'Male', '297', '120', 'Healthy', '2022-08-19'),
(41, 'andima', 'Cattle', 'Male', '272', '6000', 'Healthy', '2022-08-19'),
(42, 'walterjnr1', 'Sheep', 'Female', '367', '23', 'Sick', '2022-08-19'),
(43, 'andima', 'Sheep', 'Male', '771', '200', 'Sick', '2022-08-19'),
(44, 'walterjnr1', 'Sheep', 'Female', '322', '21', 'Sick', '2022-08-20'),
(45, 'walterjnr1', 'Goat', 'Male', '253', '77', 'Healthy', '2022-08-22');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int(3) NOT NULL,
  `username` varchar(15) NOT NULL,
  `password` varchar(15) NOT NULL,
  `fullname` varchar(45) NOT NULL,
  `email` varchar(55) NOT NULL,
  `poultry_name` varchar(55) NOT NULL,
  `address` varchar(45) NOT NULL,
  `lga` varchar(35) NOT NULL,
  `phone` varchar(14) NOT NULL,
  `photo` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `username`, `password`, `fullname`, `email`, `poultry_name`, `address`, `lga`, `phone`, `photo`) VALUES
(1, 'walterjnr1', 'escobar2012', 'Ndueso Walter', 'newleastpaysolution@gmail.com', 'Leastpay farms', '1b Ikono rd', 'Ikot Ekpene', '08067361023', 'photo/x343.jpg'),
(2, 'futurelab', '11111111', 'Udim Manasseh', 'futurelab_farms@futurelab.com', 'FutureLab Farms Ltd', '3 Chubb rd', 'Ikot Ekpene', '07032400529', 'photo/udim.jpg'),
(3, 'michael', '11111111', 'Michael michael', 'michael@gmail.com', 'Michael farms Ltd', '23 Alien Avenue', 'Ikeja', '09137595518', 'photo/x343.jpg'),
(4, 'nkem', '11111111', 'Nkem Udo', 'nkemudo@gmail.com', 'Nkems farm Ltd', 'Port Harcout', 'Eket', '07041746751', 'photo/nkem.png'),
(5, 'andima', '11111111', 'Andima Andima', 'andima09@gmail.com', 'Andima farms LTD', 'Ikot Ekpene rd , Uyo', 'Uyo', '07053896436', 'photo/x343.jpg'),
(6, 'utibe', '11111111', 'Utibe Etim', 'uty0009@gmail.com', 'Utibe Farms', 'Ikot Ekpene rd , Uyo', 'Uyo', '08068758613', 'photo/utibe.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `livestock`
--
ALTER TABLE `livestock`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `ID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `livestock`
--
ALTER TABLE `livestock`
  MODIFY `ID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
