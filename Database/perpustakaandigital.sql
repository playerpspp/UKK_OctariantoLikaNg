-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 29, 2024 at 05:28 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `perpustakaandigital`
--

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `bukuID` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `penulis` varchar(255) NOT NULL,
  `penerbit` varchar(255) NOT NULL,
  `tahunTerbit` int(11) NOT NULL,
  `stok` int(10) NOT NULL DEFAULT 1,
  `tanggal` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`bukuID`, `judul`, `penulis`, `penerbit`, `tahunTerbit`, `stok`, `tanggal`) VALUES
(1, 'buku paket pelajaran kelas 4', 'novianta', 'erlang', 2013, 1, '2024-02-29'),
(3, 'Buku IPS Kelas 5 SD', 'edy', 'erlangga', 2013, 1, '2024-02-29'),
(4, 'Buku IPA kelas 5', 'prof', 'erlangga', 2013, 1, '2024-02-29'),
(5, 'buku iPA kelas 1', 'prof', 'erlangga', 2013, 1, '2024-02-29'),
(6, 'Buku IPA Kelas 2', 'prof', 'erlangga', 2013, 1, '2024-02-29'),
(7, 'Buku IPA Kelas 6', 'prof', 'erlangga', 2013, 1, '2024-02-29'),
(8, 'Buku IPA Kelas 7', 'prof', 'Perm', 2013, 1, '2024-02-29'),
(9, 'buku paket pelajaran kelas 5', 'novianta', 'erlangga', 2013, 0, '2024-02-29');

-- --------------------------------------------------------

--
-- Table structure for table `kategoribuku`
--

CREATE TABLE `kategoribuku` (
  `kategoriID` int(11) NOT NULL,
  `namaKategori` varchar(255) NOT NULL,
  `jumlah_buku` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategoribuku`
--

INSERT INTO `kategoribuku` (`kategoriID`, `namaKategori`, `jumlah_buku`) VALUES
(1, 'IPA', 7),
(2, 'IPS', 3);

-- --------------------------------------------------------

--
-- Table structure for table `kategoribuku_relasi`
--

CREATE TABLE `kategoribuku_relasi` (
  `kategoriBukuID` int(11) NOT NULL,
  `bukuID` int(11) NOT NULL,
  `kategoriID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategoribuku_relasi`
--

INSERT INTO `kategoribuku_relasi` (`kategoriBukuID`, `bukuID`, `kategoriID`) VALUES
(1, 1, 2),
(2, 1, 1),
(5, 3, 2),
(6, 4, 1),
(7, 5, 1),
(8, 6, 1),
(9, 7, 1),
(10, 8, 1),
(11, 9, 2),
(12, 9, 1);

--
-- Triggers `kategoribuku_relasi`
--
DELIMITER $$
CREATE TRIGGER `after delete` AFTER DELETE ON `kategoribuku_relasi` FOR EACH ROW BEGIN
 UPDATE kategoribuku
    SET jumlah_buku = jumlah_buku - 1
    WHERE kategoriID = OLD.kategoriID;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after insert` AFTER INSERT ON `kategoribuku_relasi` FOR EACH ROW BEGIN
 UPDATE kategoribuku
    SET jumlah_buku = jumlah_buku + 1
    WHERE kategoriID = NEW.kategoriID;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `koleksipribadi`
--

CREATE TABLE `koleksipribadi` (
  `koleksiID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `bukuID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `id_log` int(11) NOT NULL,
  `isi_log` text NOT NULL,
  `log_idUser` int(10) NOT NULL,
  `tanggal_log` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`id_log`, `isi_log`, `log_idUser`, `tanggal_log`) VALUES
(1, 'user menambahkan data pengawai', 1, '2024-02-28 10:39:06'),
(2, 'user mengubah data pengawai', 1, '2024-02-28 10:48:15'),
(3, 'user menambahkan data pengawai', 1, '2024-02-28 10:51:12'),
(4, 'user menambahkan data peminjam', 1, '2024-02-28 11:00:03'),
(5, 'user mengubah data peminjam', 1, '2024-02-28 11:00:56'),
(6, 'user menambahkan data peminjam', 1, '2024-02-28 11:01:07'),
(7, 'user melakukan Log Out', 1, '2024-02-28 11:14:02'),
(8, 'user melakukan registrasi dan login', 6, '2024-02-28 11:14:28'),
(9, 'user melakukan Log Out', 6, '2024-02-28 11:14:32'),
(10, 'user melakukan Login', 6, '2024-02-28 11:14:39'),
(11, 'user melakukan Log Out', 6, '2024-02-28 11:14:41'),
(12, 'user melakukan Login', 1, '2024-02-28 11:15:03'),
(13, 'user mengubah data diri', 1, '2024-02-28 11:28:17'),
(14, 'user mengubah data diri', 1, '2024-02-28 11:28:49'),
(15, 'user mengubah data diri', 1, '2024-02-28 11:28:52'),
(16, 'user menambahkan data kategori', 1, '2024-02-28 11:55:58'),
(17, 'user menambahkan data kategori', 1, '2024-02-28 13:27:39'),
(18, 'user menambahkan data kategori', 1, '2024-02-28 13:29:43'),
(19, 'user menambahkan data kategori', 1, '2024-02-28 13:30:20'),
(20, 'user menambahkan data kategori', 1, '2024-02-28 13:37:37'),
(21, 'user mengubah data pengawai', 1, '2024-02-28 13:38:13'),
(22, 'user mengubah data kategori', 1, '2024-02-28 13:40:33'),
(23, 'user mengubah data kategori', 1, '2024-02-28 13:40:42'),
(24, 'user menambahkan data buku', 1, '2024-02-28 14:12:26'),
(25, 'user menambahkan data buku', 1, '2024-02-28 14:40:43'),
(26, 'user menambahkan data buku', 1, '2024-02-28 14:41:07'),
(27, 'user menghapus data buku', 1, '2024-02-28 14:42:29'),
(28, 'user melakukan Login', 1, '2024-02-29 00:04:47'),
(29, 'user melakukan Login', 6, '2024-02-29 01:25:41'),
(30, 'user menghapus Koleksi', 1, '2024-02-29 02:13:52'),
(31, 'user melakukan Login', 1, '2024-02-29 07:56:22'),
(32, 'user menambahkan data buku', 1, '2024-02-29 08:10:51'),
(33, 'user menambahkan data buku', 1, '2024-02-29 08:11:39'),
(34, 'user menambahkan data peminjaman', 1, '2024-02-29 08:48:30'),
(35, 'user menambahkan data peminjaman', 1, '2024-02-29 08:49:04'),
(36, 'user menambahkan data peminjaman', 1, '2024-02-29 08:49:22'),
(37, 'user menambahkan data peminjaman', 1, '2024-02-29 08:51:04'),
(38, 'user menghapus data peminjaman', 1, '2024-02-29 08:54:31'),
(39, 'user mengubah status peminjaman buku', 1, '2024-02-29 08:54:36'),
(40, 'user menambahkan data peminjaman', 1, '2024-02-29 09:02:00'),
(41, 'user menghapus data peminjaman', 1, '2024-02-29 09:02:04'),
(42, 'user menambahkan data peminjaman', 1, '2024-02-29 09:06:49'),
(43, 'user melakukan Log Out', 1, '2024-02-29 09:16:05'),
(44, 'user melakukan Login', 6, '2024-02-29 09:16:48'),
(45, 'user menambahkan Koleksi', 6, '2024-02-29 09:18:30'),
(46, 'user menambahkan Koleksi', 6, '2024-02-29 09:19:07'),
(47, 'user menambahkan Koleksi', 6, '2024-02-29 09:19:50'),
(48, 'user menghapus Koleksi', 6, '2024-02-29 09:19:55'),
(49, 'user melakukan Log Out', 6, '2024-02-29 09:43:34'),
(50, 'user melakukan Login', 1, '2024-02-29 10:01:12'),
(51, 'user menambahkan data buku', 1, '2024-02-29 10:21:05'),
(52, 'user menambahkan data buku', 1, '2024-02-29 10:21:17'),
(53, 'user menambahkan data buku', 1, '2024-02-29 10:21:33'),
(54, 'user menambahkan data buku', 1, '2024-02-29 10:21:54'),
(55, 'user menambahkan data peminjaman', 1, '2024-02-29 11:03:22'),
(56, 'user mengubah status peminjaman buku', 1, '2024-02-29 11:03:30'),
(57, 'user menambahkan data buku', 1, '2024-02-29 11:12:46'),
(58, 'user menambahkan data peminjaman', 1, '2024-02-29 11:24:02'),
(59, 'user menambahkan data peminjaman', 1, '2024-02-29 11:24:09'),
(60, 'user menambahkan data peminjaman', 1, '2024-02-29 11:24:19'),
(61, 'user melakukan Log Out', 1, '2024-02-29 11:25:34'),
(62, 'user melakukan Login', 6, '2024-02-29 11:25:41'),
(63, 'user melakukan Log Out', 6, '2024-02-29 11:25:57'),
(64, 'user melakukan Login', 1, '2024-02-29 11:26:02'),
(65, 'user menambahkan data peminjam', 1, '2024-02-29 11:26:32'),
(66, 'user melakukan Log Out', 1, '2024-02-29 11:26:37'),
(67, 'user melakukan Login', 7, '2024-02-29 11:26:46');

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `peminjamanID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `bukuID_peminjaman` int(11) NOT NULL,
  `tanggalPeminjaman` date NOT NULL DEFAULT current_timestamp(),
  `tanggalPengembalian` date NOT NULL,
  `statusPeminjaman` varchar(50) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`peminjamanID`, `userID`, `bukuID_peminjaman`, `tanggalPeminjaman`, `tanggalPengembalian`, `statusPeminjaman`) VALUES
(1, 1, 1, '2024-02-29', '2024-03-02', '2'),
(4, 6, 1, '2024-02-29', '2024-03-01', '2'),
(5, 6, 9, '2024-02-29', '2024-03-01', '1'),
(6, 6, 9, '2024-02-29', '2024-03-01', '1'),
(7, 6, 9, '2024-02-29', '2024-03-01', '1');

--
-- Triggers `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `after delete peminjaman` AFTER DELETE ON `peminjaman` FOR EACH ROW BEGIN
    IF OLD.statusPeminjaman = 1 THEN
        UPDATE buku
        SET stok = stok + 1
        WHERE bukuID = OLD.bukuID_peminjaman;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after insert peminjaman` AFTER INSERT ON `peminjaman` FOR EACH ROW BEGIN
    UPDATE buku
    SET stok = stok - 1
    WHERE bukuID = NEW.bukuID_peminjaman;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after update peminjaman` AFTER UPDATE ON `peminjaman` FOR EACH ROW BEGIN
    IF NEW.statusPeminjaman = 2 THEN
        UPDATE buku
        SET stok = stok + 1
        WHERE bukuID = NEW.bukuID_peminjaman;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ulasanbuku`
--

CREATE TABLE `ulasanbuku` (
  `ulasanID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `bukuID` int(11) NOT NULL,
  `ulasan` text DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `tanggal` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ulasanbuku`
--

INSERT INTO `ulasanbuku` (`ulasanID`, `userID`, `bukuID`, `ulasan`, `rating`, `tanggal`) VALUES
(1, 1, 1, 'tes2', 3, '2024-02-29');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(10) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` enum('admin','petugas','peminjam') NOT NULL,
  `email` varchar(255) NOT NULL,
  `namaLengkap` text NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `level`, `email`, `namaLengkap`, `alamat`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', 'admin@gmail.com', 'Naruto', 'Konoha'),
(3, 'rere', '095e3a1cb5cbb579195f0a6eacc84483', 'petugas', 're@gmail.com', 'rere', 'rere'),
(4, 'tes', '095e3a1cb5cbb579195f0a6eacc84483', 'peminjam', 'tes@gmail.com', 'te', 'tes'),
(6, 'halo', '57f842286171094855e51fc3a541c1e2', 'peminjam', 'halo@gmail.com', 'halo', 'halo'),
(7, 'esa', '095e3a1cb5cbb579195f0a6eacc84483', 'peminjam', 'es@gmail.com', 'esa', 'es');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`bukuID`);

--
-- Indexes for table `kategoribuku`
--
ALTER TABLE `kategoribuku`
  ADD PRIMARY KEY (`kategoriID`);

--
-- Indexes for table `kategoribuku_relasi`
--
ALTER TABLE `kategoribuku_relasi`
  ADD PRIMARY KEY (`kategoriBukuID`);

--
-- Indexes for table `koleksipribadi`
--
ALTER TABLE `koleksipribadi`
  ADD PRIMARY KEY (`koleksiID`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`peminjamanID`);

--
-- Indexes for table `ulasanbuku`
--
ALTER TABLE `ulasanbuku`
  ADD PRIMARY KEY (`ulasanID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `nama unik` (`namaLengkap`) USING HASH;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `bukuID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `kategoribuku`
--
ALTER TABLE `kategoribuku`
  MODIFY `kategoriID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `kategoribuku_relasi`
--
ALTER TABLE `kategoribuku_relasi`
  MODIFY `kategoriBukuID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `koleksipribadi`
--
ALTER TABLE `koleksipribadi`
  MODIFY `koleksiID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `peminjamanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `ulasanbuku`
--
ALTER TABLE `ulasanbuku`
  MODIFY `ulasanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
