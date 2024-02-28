-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 28, 2024 at 08:58 AM
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
  `tahunTerbit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`bukuID`, `judul`, `penulis`, `penerbit`, `tahunTerbit`) VALUES
(1, 'buku paket pelajaran kelas 4', 'novianta', 'erlang', 2013);

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
(1, 'IPA', 1),
(2, 'IPS', 1);

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
(2, 1, 1);

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
  `id_log` int(10) NOT NULL,
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
(27, 'user menghapus data buku', 1, '2024-02-28 14:42:29');

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `peminjamanID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `bukuID` int(11) NOT NULL,
  `tanggalPeminjaman` date NOT NULL DEFAULT current_timestamp(),
  `tanggalPengembalian` date NOT NULL,
  `statusPeminjaman` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ulasanbuku`
--

CREATE TABLE `ulasanbuku` (
  `ulasanID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `bukuID` int(11) NOT NULL,
  `ulasan` text NOT NULL,
  `rating` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(6, 'halo', '57f842286171094855e51fc3a541c1e2', 'peminjam', 'halo@gmail.com', 'halo', 'halo');

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
-- Indexes for table `ulasanbuku`
--
ALTER TABLE `ulasanbuku`
  ADD PRIMARY KEY (`ulasanID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `bukuID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `kategoribuku`
--
ALTER TABLE `kategoribuku`
  MODIFY `kategoriID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `kategoribuku_relasi`
--
ALTER TABLE `kategoribuku_relasi`
  MODIFY `kategoriBukuID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `koleksipribadi`
--
ALTER TABLE `koleksipribadi`
  MODIFY `koleksiID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id_log` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `ulasanbuku`
--
ALTER TABLE `ulasanbuku`
  MODIFY `ulasanID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
