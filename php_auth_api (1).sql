-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Vært: 127.0.0.1
-- Genereringstid: 20. 05 2022 kl. 08:33:18
-- Serverversion: 10.4.14-MariaDB
-- PHP-version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `php_auth_api`
--

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `list_item`
--

CREATE TABLE `list_item` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `itemList` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `itemCountry` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Data dump for tabellen `list_item`
--

INSERT INTO `list_item` (`id`, `user_id`, `itemList`, `itemCountry`) VALUES
(252, 21, 'Bungee Jump', 'Thailand'),
(253, 21, 'Gokart', 'Dubai'),
(254, 20, 'Go clubbing', 'New York'),
(255, 20, 'Drive a ferrari', 'Dubai'),
(256, 19, 'Help poor kids', 'Africa'),
(257, 19, 'Parachute jump', 'Uganda');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nationality` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Data dump for tabellen `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `nationality`, `age`) VALUES
(19, 'Mostafa Ahmad', 'ma@packshoot.dk', '$2y$10$yjXpBMPsVzaGDPrdxzDQkuACA3b5Auzyw3yapnzVMAruqsolx2KM.', 'Denmark', '21'),
(20, 'Lasse Harmsen', 'lasse@hotmail.com', '$2y$10$c7xh5EkjH2Z8nPBnNB171O8SbnBIxTD940mvC8WqSYyShRavFtGzu', 'Denmark', '24'),
(21, 'Thomas Steffensen', 'thomas@hotmail.com', '$2y$10$phsx1vyORwcdLEHN1jPMO.aQ/rgSt8PQYc9o9oQP5cFMFma/.Sl5a', 'Denmark', '25');

--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `list_item`
--
ALTER TABLE `list_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_relation` (`user_id`);

--
-- Indeks for tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Brug ikke AUTO_INCREMENT for slettede tabeller
--

--
-- Tilføj AUTO_INCREMENT i tabel `list_item`
--
ALTER TABLE `list_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=258;

--
-- Tilføj AUTO_INCREMENT i tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Begrænsninger for tabel `list_item`
--
ALTER TABLE `list_item`
  ADD CONSTRAINT `user_relation` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
