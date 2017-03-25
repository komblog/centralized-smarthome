-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 25 Mar 2017 pada 10.20
-- Versi Server: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `central_smarthome`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `class`
--

CREATE TABLE `class` (
  `cls_id` int(11) NOT NULL,
  `cls_name` varchar(45) NOT NULL,
  `cls_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `class`
--

INSERT INTO `class` (`cls_id`, `cls_name`, `cls_type`) VALUES
(1, 'lamp', 1),
(2, 'door', 1),
(3, 'air_conditioner', 1),
(4, 'fan', 1),
(5, 'heater', 1),
(6, 'pir', 0),
(7, 'gas_sensor', 0),
(8, 'rain_sensor', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `log`
--

CREATE TABLE `log` (
  `log_id` int(11) NOT NULL,
  `log_obj_id` int(11) NOT NULL,
  `log_time` datetime NOT NULL,
  `log_status` int(11) NOT NULL,
  `log_power` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `max_power`
--

CREATE TABLE `max_power` (
  `cluster` int(11) NOT NULL,
  `max_power` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `max_power`
--

INSERT INTO `max_power` (`cluster`, `max_power`) VALUES
(1, 1000000),
(2, 1000000),
(3, 1000000),
(4, 1000000),
(5, 1000000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `object`
--

CREATE TABLE `object` (
  `obj_id` int(11) NOT NULL,
  `obj_name` varchar(45) NOT NULL,
  `obj_class` int(11) NOT NULL,
  `obj_usr_id` int(11) NOT NULL,
  `obj_status` int(11) NOT NULL,
  `obj_power` int(11) NOT NULL,
  `OBJ_IP` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `object`
--

INSERT INTO `object` (`obj_id`, `obj_name`, `obj_class`, `obj_usr_id`, `obj_status`, `obj_power`, `OBJ_IP`) VALUES
(1, 'lampu_1', 1, 1, 0, 0, '192.168.1.2'),
(2, 'lampu_2', 1, 1, 0, 0, '192.168.1.3'),
(3, 'lampu_3', 1, 1, 0, 0, '192.168.1.4'),
(4, 'lampu_A', 1, 2, 50, 0, '192.168.1.5'),
(5, 'lampu_B', 1, 2, 100, 0, '192.168.1.6'),
(6, 'lampu_C', 1, 2, 100, 0, '192.168.1.7'),
(7, 'lampu_I', 1, 3, 0, 0, '10.10.10.5'),
(8, 'lampu_II', 1, 3, 0, 0, '10.10.10.6'),
(9, 'lampu_III', 1, 3, 0, 0, '10.10.10.7'),
(10, 'PIR_1', 0, 1, 0, 0, '192.168.1.11'),
(11, 'PIR_2', 0, 1, 0, 0, '192.168.1.12'),
(12, 'PIR_3', 0, 1, 0, 0, '192.168.1.13'),
(13, 'PIR_I', 0, 3, 0, 0, '10.10.10.2'),
(14, 'PIR_II', 0, 3, 0, 0, '10.10.10.3'),
(15, 'PIR_III', 0, 3, 0, 0, '10.10.10.4');

-- --------------------------------------------------------

--
-- Struktur dari tabel `packet_log`
--

CREATE TABLE `packet_log` (
  `plg_id` int(11) NOT NULL,
  `plg_data` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `rule`
--

CREATE TABLE `rule` (
  `rule_id` int(11) NOT NULL,
  `rule_obj_in` int(11) NOT NULL,
  `rule_obj_in_ip` varchar(255) NOT NULL,
  `rule_obj_in_status` int(11) NOT NULL,
  `rule_obj_out` int(11) NOT NULL,
  `rule_obj_out_ip` varchar(255) NOT NULL,
  `rule_obj_out_status` int(11) NOT NULL,
  `rule_usr_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `rule`
--

INSERT INTO `rule` (`rule_id`, `rule_obj_in`, `rule_obj_in_ip`, `rule_obj_in_status`, `rule_obj_out`, `rule_obj_out_ip`, `rule_obj_out_status`, `rule_usr_id`) VALUES
(1, 10, '192.168.1.11', 100, 1, '192.168.1.2', 100, 1),
(2, 10, '192.168.1.11', 0, 1, '192.168.1.2', 0, 1),
(3, 13, '10.10.10.2', 100, 7, '10.10.10.5', 100, 3),
(4, 13, '10.10.10.2', 0, 7, '10.10.10.5', 0, 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `schedule`
--

CREATE TABLE `schedule` (
  `scd_id` int(11) NOT NULL,
  `scd_obj_id` int(11) NOT NULL,
  `scd_time` time NOT NULL,
  `scd_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `usr_id` int(11) NOT NULL,
  `usr_name` varchar(45) NOT NULL,
  `usr_password` varchar(45) NOT NULL,
  `usr_level` int(11) NOT NULL,
  `usr_realname` varchar(45) NOT NULL,
  `usr_address` varchar(45) NOT NULL,
  `usr_status` bit(1) NOT NULL,
  `usr_cluster` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`usr_id`, `usr_name`, `usr_password`, `usr_level`, `usr_realname`, `usr_address`, `usr_status`, `usr_cluster`) VALUES
(0, 'admin', 'admin', 0, '', '', b'1111111111111111111111111111111', 0),
(1, 'user1', 'user1', 1, 'Tom', 'New York', b'1111111111111111111111111111111', 1),
(2, 'user2', 'user2', 1, 'Jerry', 'London', b'1111111111111111111111111111111', 1),
(3, 'herijs', 'adaaja', 1, 'Heri', 'Malang', b'1111111111111111111111111111111', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`cls_id`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `max_power`
--
ALTER TABLE `max_power`
  ADD PRIMARY KEY (`cluster`);

--
-- Indexes for table `object`
--
ALTER TABLE `object`
  ADD PRIMARY KEY (`obj_id`);

--
-- Indexes for table `packet_log`
--
ALTER TABLE `packet_log`
  ADD PRIMARY KEY (`plg_id`);

--
-- Indexes for table `rule`
--
ALTER TABLE `rule`
  ADD PRIMARY KEY (`rule_id`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`scd_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`usr_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `cls_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `max_power`
--
ALTER TABLE `max_power`
  MODIFY `cluster` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `object`
--
ALTER TABLE `object`
  MODIFY `obj_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `packet_log`
--
ALTER TABLE `packet_log`
  MODIFY `plg_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rule`
--
ALTER TABLE `rule`
  MODIFY `rule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `scd_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `usr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
