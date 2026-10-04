-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 27 Sep 2026 pada 13.23
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_siperpus_mi`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(191) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(191) NOT NULL,
  `owner` varchar(191) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(191) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_09_10_014546_create_personal_access_tokens_table', 1),
(5, '2026_09_10_020001_create_tbl_siswa_table', 1),
(6, '2026_09_10_020002_create_tbl_guru_table', 1),
(7, '2026_09_10_020003_create_tbl_buku_table', 1),
(8, '2026_09_10_020004_create_tbl_buku_detail_table', 1),
(9, '2026_09_10_020005_create_tbl_kelas_table', 1),
(10, '2026_09_10_020006_create_tbl_tahun_ajaran_table', 1),
(11, '2026_09_10_020007_create_tbl_kelas_detail_table', 1),
(12, '2026_09_10_020008_create_tbl_siswa_kelas_table', 1),
(13, '2026_09_10_020009_create_tbl_pinjam_table', 1),
(14, '2026_09_10_020010_create_tbl_pinjam_detail_table', 1),
(15, '2026_09_10_020011_create_tbl_berita_table', 1),
(16, '2026_09_23_143800_add_kategori_to_tbl_berita_table', 2),
(17, '2026_09_23_074426_alter_gambar_thumbnail_on_tbl_berita_table', 3),
(18, '2026_09_23_000001_create_tbl_kunjungan_table', 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', '4dbde3941667375084818f11e9886be16cb04ef48d8400f7517b16b52949e4bc', '[\"*\"]', NULL, NULL, '2026-09-22 18:19:23', '2026-09-22 18:19:23'),
(5, 'App\\Models\\User', 1, 'auth_token', 'ab236e0c776fe99d56eb23e397aae2bf50a53b30490e8f47979b940850c50ec0', '[\"*\"]', NULL, NULL, '2026-09-23 03:18:24', '2026-09-23 03:18:24'),
(6, 'App\\Models\\User', 1, 'auth_token', '31492ac2f94f71ff50374cbe38c9066569a819da23a82758277d64dfdc8f44ef', '[\"*\"]', NULL, NULL, '2026-09-23 17:46:54', '2026-09-23 17:46:54'),
(9, 'App\\Models\\User', 1, 'auth_token', '7ae7b2b29930432dbc43c7023106034f89f3203c1649e52f45f14564af8b2549', '[\"*\"]', '2026-09-23 23:36:09', NULL, '2026-09-23 21:11:51', '2026-09-23 23:36:09');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(191) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('9AoGEf1ECnxqdOjcdJzdihmZBwpkzwafP5O2VKXd', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSUk0bU1UMmpTNFR1UTZTejc1OVpBRW5BTjRleEdPY2xtRFpoU0d5diI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1790123965),
('9bZqgPBVuLChIxnzjTl7OXrTwpr6oArH9xMX9Svw', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.26100.9444', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieks1QVkxclVwNnI2VGVGNkw3TjJOREFFb3BlaUhnczVMbG04QVBSZyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1790149446),
('hCxCYGSebnS69ug2j1ywBZ7bVA0DKEhDJDC4Thdq', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS0RIMXh2MHZvbTlqUDB3M2VPbm5hS3NxdUVKSHdiQWhQZzcwTXpxbCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1790210770),
('lWso45PVDXmdPxJ1IfLMwWSFTzFvazus2RkZzDhE', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRWtYb09HZHNESW9kT0dBSzhGakE4TnJzcUFvNTM4cjJRNW1oajB3cyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1790234131),
('Rp0OsATXs0wauoCGPLsftqG8yx6s5PljRlE6etD0', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV1ZzeENpNHBMb0dFbThpck9JSFFHM3Bpekd4RHJHNklaUzZiTk5IMSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1789626782);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_berita`
--

CREATE TABLE `tbl_berita` (
  `id_berita` bigint(20) UNSIGNED NOT NULL,
  `judul` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `gambar_thumbnail` text DEFAULT NULL,
  `isi_konten` text NOT NULL,
  `kategori` varchar(50) NOT NULL DEFAULT 'Kegiatan',
  `tgl_publish` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_berita`
--

INSERT INTO `tbl_berita` (`id_berita`, `judul`, `slug`, `gambar_thumbnail`, `isi_konten`, `kategori`, `tgl_publish`, `created_at`, `updated_at`) VALUES
(1, 'Peringatan Maulid Nabi Muhammad SAW di MI Roudotutta\'lim Penuh Khidmat', 'peringatan-maulid-nabi-muhammad-saw-mi-roudotuttalim', 'berita/maulid_nabi_2025.jpg', 'Keluarga besar MI Roudotutta\'lim menyelenggarakan peringatan Maulid Nabi Muhammad SAW 1447 H. Acara diisi dengan penampilan shalawat banjari para siswa, pembacaan qasidah Diba\', santunan kepada anak yatim, serta tausiyah agama oleh Pengasuh Madrasah mengenai keteladanan akhlak Rasulullah.', 'Pengumuman', '2026-08-31 02:10:52', '2026-09-09 19:10:52', '2026-09-23 00:37:42'),
(2, 'Semarak Gerakan Gemar Membaca dan Pojok Baca Digital di Perpustakaan Madrasah', 'semarak-gerakan-gemar-membaca-dan-pojok-baca-digital', 'berita/pojok_baca_digital.jpg', 'Perpustakaan SIPERPUS MI Roudotutta\'lim meresmikan sarana pojok baca interaktif yang dilengkapi tablet literasi digital dan ribuan buku ensiklopedia anak islami. Siswa-siswi sangat antusias mengikuti tantangan membaca 15 menit sebelum masuk kelas.', 'Kegiatan', '2026-09-05 02:10:52', '2026-09-09 19:10:52', '2026-09-23 00:37:42'),
(3, 'Siswa MI Roudotutta\'lim Sabet Medali Emas Lomba Silat dan Kaligrafi Tingkat Kecamatan', 'siswa-mi-roudotuttalim-sabet-medali-emas-lomba-silat-dan-kaligrafi-tingkat-kecamatan', 'uploads/berita/berita_1790148860_CGUewW.jpg', 'Prestasi membanggakan kembali ditorehkan oleh santri MI Roudotutta\'lim dalam ajang Festival Seni & Olahraga Madrasah (AKSIOMA). Muhammad Al-Fatih dan Aisyah Humaira sukses meraih Juara 1 Cabang Silat Bela diri', 'Prestasi', '2026-09-08 00:00:00', '2026-09-09 19:10:52', '2026-09-23 00:37:42'),
(6, 'MEMENANGKAN PORSENI', 'memenangkan-porseni', 'uploads/berita/berita_1790127477_isKB2C.png', 'siswa mi memenangkan porseni', 'Prestasi', '2026-09-23 00:00:00', '2026-09-22 18:31:32', '2026-09-23 00:37:42');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_buku`
--

CREATE TABLE `tbl_buku` (
  `idbuku` bigint(20) UNSIGNED NOT NULL,
  `isbn` varchar(50) NOT NULL,
  `kodebuku` varchar(50) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `penulis` varchar(150) NOT NULL,
  `penerbit` varchar(150) NOT NULL,
  `stok` int(11) NOT NULL DEFAULT 0,
  `stok_tersedia` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_buku`
--

INSERT INTO `tbl_buku` (`idbuku`, `isbn`, `kodebuku`, `judul`, `penulis`, `penerbit`, `stok`, `stok_tersedia`, `created_at`, `updated_at`) VALUES
(1, '978-623-01-0101-1', 'BK-AA1', 'Akidah Akhlak Pendekatan Saintifik Kurikulum Madrasah MI Kelas 1', 'Drs. H. Masrun, M.Pd.I', 'Kementerian Agama RI', 3, 3, '2026-09-09 19:10:52', '2026-09-23 23:31:57'),
(2, '978-623-01-0102-8', 'BK-FQ2', 'Fiqih Ibadah Dasar MI Kelas 2', 'Dr. H. Sulaiman, M.Ag', 'Kementerian Agama RI', 3, 3, '2026-09-09 19:10:52', '2026-09-23 23:31:57'),
(3, '978-623-01-0103-5', 'BK-SKI3', 'Sejarah Kebudayaan Islam: Jejak Kenabian MI Kelas 3', 'Ahmad Syarifuddin, M.A', 'Penerbit Erlangga', 3, 3, '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(4, '978-623-01-0104-2', 'BK-QH4', 'Al-Qur\'an Hadis Pedoman Hidup MI Kelas 4', 'Ustadz Muhammad Zainuri', 'Tiga Serangkai', 2, 2, '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(5, '978-623-01-0105-9', 'BK-BA5', 'Bahasa Arab MI Kelas 5: Belajar Komunikasi Qur\'ani', 'Farhan Mansyur, M.Pd', 'Kementerian Agama RI', 3, 3, '2026-09-09 19:10:52', '2026-09-23 23:40:30'),
(6, '978-623-01-0106-6', 'BK-MTK6', 'Mahir Matematika MI & SD Kelas 6 Kurikulum Merdeka', 'Prof. Dr. Wahyudi, M.Sc', 'Yudhistira Media', 2, 2, '2026-09-09 19:10:52', '2026-09-23 23:40:30'),
(7, '978-623-01-0107-3', 'BK-IPAS4', 'Ilmu Pengetahuan Alam dan Sosial (IPAS) MI Kelas 4', 'Dra. Endang Lestari', 'Grafindo Media Pratama', 3, 3, '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(8, '978-623-01-0108-0', 'BK-ENS01', 'Ensiklopedia Sains Islam untuk Anak Pintar', 'Tim Penulis Mizan Kids', 'Mizan Pustaka', 2, 2, '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(9, '978-623-01-0109-7', 'BK-KS25', 'Kisah Teladan 25 Nabi dan Rasul Bergambar', 'Kak Nurul Ihsan', 'Gema Insani Press', 3, 3, '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(10, '978-623-01-0110-3', 'BK-KMS03', 'Kamus Bergambar 3 Bahasa (Indonesia - Arab - Inggris) Madrasah Cilik', 'Dr. H. M. Bahruddin', 'Kanisius Edukasi', 2, 2, '2026-09-09 19:10:52', '2026-09-09 19:10:52');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_buku_detail`
--

CREATE TABLE `tbl_buku_detail` (
  `idbukudetail` bigint(20) UNSIGNED NOT NULL,
  `idbuku` bigint(20) UNSIGNED NOT NULL,
  `kodebukudetail` varchar(50) NOT NULL,
  `kondisi` enum('baik','rusak','hilang') NOT NULL DEFAULT 'baik',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_buku_detail`
--

INSERT INTO `tbl_buku_detail` (`idbukudetail`, `idbuku`, `kodebukudetail`, `kondisi`, `created_at`, `updated_at`) VALUES
(1, 1, 'BK-AA1-001', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(2, 1, 'BK-AA1-002', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(3, 1, 'BK-AA1-003', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(4, 2, 'BK-FQ2-001', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(5, 2, 'BK-FQ2-002', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(6, 2, 'BK-FQ2-003', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(7, 3, 'BK-SKI3-001', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(8, 3, 'BK-SKI3-002', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(9, 3, 'BK-SKI3-003', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(10, 4, 'BK-QH4-001', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(11, 4, 'BK-QH4-002', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(12, 5, 'BK-BA5-001', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(13, 5, 'BK-BA5-002', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(14, 5, 'BK-BA5-003', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(15, 6, 'BK-MTK6-001', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(16, 6, 'BK-MTK6-002', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(17, 7, 'BK-IPAS4-001', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(18, 7, 'BK-IPAS4-002', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(19, 7, 'BK-IPAS4-003', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(20, 8, 'BK-ENS01-001', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(21, 8, 'BK-ENS01-002', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(22, 9, 'BK-KS25-001', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(23, 9, 'BK-KS25-002', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(24, 9, 'BK-KS25-003', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(25, 10, 'BK-KMS03-001', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(26, 10, 'BK-KMS03-002', 'baik', '2026-09-09 19:10:52', '2026-09-09 19:10:52');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_guru`
--

CREATE TABLE `tbl_guru` (
  `idguru` bigint(20) UNSIGNED NOT NULL,
  `nip` varchar(50) NOT NULL,
  `nama_guru` varchar(150) NOT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_guru`
--

INSERT INTO `tbl_guru` (`idguru`, `nip`, `nama_guru`, `no_hp`, `created_at`, `updated_at`) VALUES
(6, '197005152003122001', 'EULIS JULAEHA S.Pd.I', '082218258310', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(7, '4342754657200023', 'AMIN SHOLIHIN S.Sos.I', '0895346158641', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(8, '9241760662300033', 'CUCU MARFU\'AH', '081320241027', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(9, '1360754654300003', 'NENDEN RENNY SITTI NURAENI', '087822820058', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(10, '197404082007102002', 'NURAENI', '085220903005', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(11, '0020207267185002', 'SINTA LISTIAWATI', '081287223293', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(12, '6937748652200022', 'ATANG SUHENDI', '087822057227', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(13, '197608092007102003', 'JAMILATUL SAFITRI', '087822153530', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(14, '8234764665200033', 'EKO JOKO SUSSANTO', '085294225866', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(15, '4049748650200033', 'AHMAD HAIDAR ILYAS', '081320734102', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(16, '8935757659300032', 'AI MAFTUHAH', '082317098119', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(17, '6047764666210083', 'FARIZ JAMILAH S.Pd.I', '089636058110', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(18, '0020207267183001', 'ENTIN PRIHANTINI', '085220419416', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(19, '5241742643300043', 'TRI HAZARIYANTI', '081573074863', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(20, '197112292007101001', 'NAZARUDIN', '081214183943', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(21, '5945761663320001', 'RIDWAN MUSTOFA SURUR', '085778258221', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(22, '20267335', 'MIRWAN SHOFIA', '083821800038', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(23, '7839760662200012', 'MUKHTAR YUNUS SAEPUL MUKMIN', '083865587273', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(24, '197808232007101001', 'SUGIMAN', '085220209878', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(25, '0020207267196001', 'AI NENDEN MUSTAKIMAH', '081221456520', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(26, '0020207267192004', 'SANDI KURNIAWAN S.Pd', '081311436859', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(27, '3217105006980021', 'ARTI MUNAWAROH', '087764593607', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(28, '3217095105980001', 'MARDIANA RAHAYU', '089682917092', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(29, '0000000000000000', 'ZAINI ARJAB', '089603546055', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(30, '2020726719200600', 'PENI NOVALIA', '0895343569729', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(31, '3217095210990008', 'SYANINDITA NURULIZA', '081224725743', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(32, '3217090603960012', 'FUAD MUBAROK THOLIB', '0895320069887', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(33, '3217131408970009', 'SORAYA ANZALANI SA\'IDAH DAROINI', '0882001178491', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(34, '3217090408790010', 'YOSEP SETIYADI SE', '081222425610', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(35, '3217092004850028', 'KIKI SETIADI', NULL, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(36, '3217097004920009', 'KIKI NURAFRILIYANTI', '085795466720', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(37, '3217160204970006', 'AGUNG GUNAWAN', NULL, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(38, '5663766668200002', 'A. YOGHA PRAMUDYA', '081910304140', '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(39, '3217090210970008', 'ABDUL ROJAK', NULL, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(40, '3217097011000004', 'SALSA MUTIAWATI RAMADHAN', NULL, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(41, '3217094810030007', 'NADILA ROWATUL ROHMAH', NULL, '2026-09-22 19:27:49', '2026-09-22 19:27:49');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_kelas`
--

CREATE TABLE `tbl_kelas` (
  `idkelas` bigint(20) UNSIGNED NOT NULL,
  `kelas` varchar(50) NOT NULL,
  `tingkat` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_kelas`
--

INSERT INTO `tbl_kelas` (`idkelas`, `kelas`, `tingkat`, `created_at`, `updated_at`) VALUES
(1, '1A', 1, '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(2, '2A', 2, '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(3, '3A', 3, '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(4, '4A', 4, '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(5, '5A', 5, '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(6, '6A', 6, '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(7, '1B', 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(8, '1C', 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(9, '2B', 2, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(10, '2C', 2, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(11, '3B', 3, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(12, '3C', 3, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(13, '4B', 4, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(14, '4C', 4, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(15, '5B', 5, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(16, '5C', 5, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(17, '6B', 6, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(18, '6C', 6, '2026-09-22 19:27:49', '2026-09-22 19:27:49');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_kelas_detail`
--

CREATE TABLE `tbl_kelas_detail` (
  `idkelasdetail` bigint(20) UNSIGNED NOT NULL,
  `idkelas` bigint(20) UNSIGNED NOT NULL,
  `idguru` bigint(20) UNSIGNED NOT NULL,
  `idthahunajaran` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_kelas_detail`
--

INSERT INTO `tbl_kelas_detail` (`idkelasdetail`, `idkelas`, `idguru`, `idthahunajaran`, `created_at`, `updated_at`) VALUES
(1, 1, 6, 1, '2026-09-09 19:10:52', '2026-09-22 19:27:49'),
(2, 2, 13, 1, '2026-09-09 19:10:52', '2026-09-22 19:27:49'),
(3, 3, 18, 1, '2026-09-09 19:10:52', '2026-09-22 19:27:49'),
(4, 4, 23, 1, '2026-09-09 19:10:52', '2026-09-22 19:27:49'),
(5, 5, 27, 1, '2026-09-09 19:10:52', '2026-09-22 19:27:49'),
(6, 6, 31, 1, '2026-09-09 19:10:52', '2026-09-22 19:27:49'),
(7, 7, 7, 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(8, 8, 8, 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(9, 9, 16, 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(10, 10, 17, 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(11, 11, 20, 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(12, 12, 22, 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(13, 13, 24, 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(14, 14, 25, 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(15, 15, 29, 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(16, 16, 30, 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(17, 17, 32, 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49'),
(18, 18, 33, 1, '2026-09-22 19:27:49', '2026-09-22 19:27:49');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_kunjungan`
--

CREATE TABLE `tbl_kunjungan` (
  `id_kunjungan` bigint(20) UNSIGNED NOT NULL,
  `idsiswa` bigint(20) UNSIGNED NOT NULL,
  `idpetugas` bigint(20) UNSIGNED DEFAULT NULL,
  `waktu_kunjung` datetime NOT NULL,
  `keperluan` varchar(100) NOT NULL DEFAULT 'Membaca Buku',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pinjam`
--

CREATE TABLE `tbl_pinjam` (
  `idpinjam` bigint(20) UNSIGNED NOT NULL,
  `idsiswa` bigint(20) UNSIGNED NOT NULL,
  `idpetugas` bigint(20) UNSIGNED NOT NULL,
  `waktu` datetime NOT NULL,
  `tgl_batas_kembali` date NOT NULL,
  `tgl_dikembalikan` date DEFAULT NULL,
  `status` enum('dipinjam','dikembalikan','terlambat') NOT NULL DEFAULT 'dipinjam',
  `total_denda` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_pinjam`
--

INSERT INTO `tbl_pinjam` (`idpinjam`, `idsiswa`, `idpetugas`, `waktu`, `tgl_batas_kembali`, `tgl_dikembalikan`, `status`, `total_denda`, `created_at`, `updated_at`) VALUES
(1, 1215, 1, '2026-09-24 06:36:09', '2026-10-01', '2026-09-24', 'dikembalikan', 0.00, '2026-09-23 23:36:09', '2026-09-23 23:40:30');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pinjam_detail`
--

CREATE TABLE `tbl_pinjam_detail` (
  `idpinjamdetail` bigint(20) UNSIGNED NOT NULL,
  `idpinjam` bigint(20) UNSIGNED NOT NULL,
  `idbukudetail` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_pinjam_detail`
--

INSERT INTO `tbl_pinjam_detail` (`idpinjamdetail`, `idpinjam`, `idbukudetail`, `created_at`, `updated_at`) VALUES
(1, 1, 13, '2026-09-23 23:36:09', '2026-09-23 23:36:09'),
(2, 1, 15, '2026-09-23 23:36:09', '2026-09-23 23:36:09');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_siswa`
--

CREATE TABLE `tbl_siswa` (
  `idsiswa` bigint(20) UNSIGNED NOT NULL,
  `nis` varchar(50) NOT NULL,
  `nisn` varchar(50) DEFAULT NULL,
  `nama` varchar(150) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_siswa`
--

INSERT INTO `tbl_siswa` (`idsiswa`, `nis`, `nisn`, `nama`, `created_at`, `updated_at`) VALUES
(621, '2501001', '3203835528', 'DHIAURRAHMA AISH HAIBA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(622, '2501002', NULL, 'MUHAMMAD ABIYA ASH SHIDDIQ', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(623, '2501003', NULL, 'QIANA GEMPITA RAMADHANI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(624, '2501004', NULL, 'GAVIN ARFAN ALHUSAYN', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(625, '2501005', NULL, 'ZAHIRA AQILLA ROBBY', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(626, '2501006', NULL, 'DEVANKA ATHALLA ENDARU', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(627, '2501007', NULL, 'MUHAMMAD ZAKI ABDULLAH', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(628, '2501008', NULL, 'RAIQA SHEZA AQILA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(629, '2501009', '3190564217', 'AZRIL RASHDAN SHAZIYA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(630, '2501010', '3198721913', 'MUHAMMAD RAFFASYA ARFAN', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(631, '2501011', '3195517288', 'MUHAMMAD NAUFAL ABDURRAHMAN', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(632, '2501012', '3195612996', 'ALULA RAMANIA HERDIANA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(633, '2501013', '3190381992', 'HAFIDZAN RASID ABDILLAH', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(634, '2501014', '3197218215', 'SYAFIQ AZ DZIKRI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(635, '2501015', '3191565357', 'ASSYIFA TALITHA AZAHRA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(636, '2501016', '3196035901', 'ZIYAD UWAIS AL QORNI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(637, '2501017', '3199485314', 'NADHIRA AULIA IZZATUNNISA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(638, '2501018', '3207879778', 'RUMAISHA ASAFA MEDINA DAUD', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(639, '2501019', '3207587697', 'Latisya Shaqueena Afshen Romeesa', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(640, '2501020', '3194293595', 'Annisa Zahira', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(641, '2501021', '3193800993', 'GHANIA AFRIN FAHIMA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(642, '2501022', '3191002072', 'FREYA QUEENATHA ALESHA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(643, '2501023', '3202335743', 'Raiqa Ibnatu Munira', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(644, '2501024', '3193805169', 'ASHIMA DINILLAH RUSTANDI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(645, '2501025', '3194657273', 'RATU DESSTIYANTI YULIANA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(646, '2501026', '3196022535', 'ABREAL RAFARDHAN MOKODOMPIT', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(647, '2501027', '3194964494', 'AFRAZ DANEER ASWADI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(648, '2501028', '3198264448', 'DIAZ ILYASA MUHARAM', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(649, '2501029', '3195131107', 'Muhammad Ikram Nurfadhlan', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(650, '2501030', '3204117373', 'Azkie Elmeer Syiami', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(651, '2501031', '3199487405', 'QAIS GHAZI GHAIYYAS RIZKI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(652, '2501032', '3190970950', 'Adhitama Rahman Khair', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(653, '2501033', '3198865410', 'ALMAIRA SHAFA KHADIJAH', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(654, '2501034', '3201791835', 'SENAVIA DZAKIRA TSANI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(655, '2501035', '3194779995', 'MUHAMMAD DZAKIANDRA SYAHPUTRA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(656, '2501036', '3203139738', 'AINUR SHANUM SHALIHAH', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(657, '2501037', '3201618605', 'Akhtar Rafiq Saputra', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(658, '2501038', '3198205188', 'NOURIL NAJWAN', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(659, '2501039', NULL, 'NABILA PUTRI ADZKIYA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(660, '2501040', NULL, 'ABIDZAR GANDHI KUSWANTORO', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(661, '2501041', NULL, 'NADHIRA CHANDRA MAIZA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(662, '2501042', NULL, 'MUHAMMAD SAYYID BILAL', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(663, '2501043', '3192542551', 'SALWA KHUMAIRA RAMADHANI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(664, '2501044', '3193565342', 'MUHAMAD SAEPUL AKBAR', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(665, '2501045', '3199516559', 'MUHAMAD BAYU NUGRAHA SANJAYA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(666, '2501046', '3194922327', 'SAKINA KHAIRA PUTRI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(667, '2501047', '3200953500', 'ELVANO PARVIZ PUTRA NUGROHO', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(668, '2501048', '3197392585', 'BUNGA FEISYA RIZHANI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(669, '2501049', '3195882173', 'SYAFIRA NOOR ASYIFA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(670, '2501050', NULL, 'ASHEEQA FARZANA HUMAIRA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(671, '2501051', '3203329363', 'SRI YULIA ASSYAKIR', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(672, '2501052', '3204075468', 'RIFKI ADI PUTRA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(673, '2501053', '3192901984', 'Nayyara Ayska Almahyra', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(674, '2501054', '3191759049', 'KHALISA NUR MAULIDA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(675, '2501055', '3190105149', 'KEYRA AZZURA VIOLYTA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(676, '2501056', '3209137974', 'Ayesha Azka Azizah', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(677, '2501057', '3200152080', 'Elshanum Dhiya Sabhira', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(678, '2501058', '3192795320', 'NADIA NUR AMIRAH', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(679, '2501059', '3204180580', 'ALIF AL FATHIR AL HAQ', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(680, '2501060', '3196629060', 'ALMEERA AZZAHRA ALFATHUNNISA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(681, '2501061', '3199947060', 'M. Shaqeel Uwais Al Qorny', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(682, '2501062', '3197475850', 'M Farid Atallah', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(683, '2501063', '3199907162', 'ALFATIH YUSUF ANGGARA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(684, '2501064', '3195089698', 'GANINDRA ADELARD MARKOS', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(685, '2501065', '3196130831', 'RAFFASYA ATHAFARIZ SYAKEIL', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(686, '2501066', '3191781091', 'Ahmad Kamil Musyaffa', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(687, '2501067', '3205647233', 'Muhammad Mufassir Al Quran', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(688, '2501068', '3196249737', 'GUNTUR SEPTIAN AKBAR', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(689, '2501069', '3199341829', 'ELFATHAN ALTEZZA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(690, '2501070', '3193674105', 'MUHAMMAD LATIEF AL BARRA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(691, '2501071', '3191202322', 'KANZA AZMIATUL FADZLAH', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(692, '2501072', '3204236463', 'BILAL AZKANDRA HERMAWAN', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(693, '2501073', '3190365734', 'MUHAMMAD ARKHAN AL FATIH', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(694, '2501074', '3194698360', 'MUHAMMAD DENIANSYAH SAPUTRA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(695, '2501075', NULL, 'PUTRA SATRIA WIRAUTAMA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(696, '2501076', NULL, 'DHEA ASYIFA NURZAKYATUNISA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(697, '2501077', NULL, 'M. FAWAZ SHABIR FIRDAUS', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(698, '2501078', '3197030917', 'MUHAMMAD FATIH ARRASYID', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(699, '2501079', NULL, 'SENJA KIRANA KHOIRUNNISA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(700, '2501080', NULL, 'AURELINO OKTARA SANJAYA PUTRA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(701, '2501081', NULL, 'ABID ZAKI MARWAN', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(702, '2501082', NULL, 'MUHAMAD ZIA ABQORI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(703, '2501083', NULL, 'SYAUQI SINAN HAFIZHAN', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(704, '2501084', '3199228136', 'ZIVANI KHANZA SEVAN', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(705, '2501085', '3195505894', 'MUHAMAD ARKAN PAMUNGKAS', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(706, '2501086', '3190483311', 'MULKAH NABILA NURSYIFA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(707, '2501087', '3190225127', 'ALIFA NAHDA AZ ZAHRA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(708, '2501088', '3194936665', 'NAUFAL HANIF AL FATIH', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(709, '2501089', '3192336278', 'MUHAMMAD SHEENAN ZIAMAQIEL', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(710, '2501090', '3202289602', 'ZAIN NURI RATNA FATIMAH', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(711, '2501091', '3195762818', 'KHALISA AMILA SHALIHA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(712, '2501092', '3209810083', 'KIANDRA ZIO ALZETHA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(713, '2501093', '3192489310', 'HAIDAR YUDHA AIRLANGGA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(714, '2501094', '3190908444', 'HUMAIRA GRIZELLE AZKADINA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(715, '2501095', '3194872620', 'KEENAN DEAN ARRIZKY', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(716, '2501096', '3191680283', 'PANJI HILMI KHOIRUDDIN', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(717, '2501097', '3190397521', 'ADZKIA GHINA KHAIRUNNISA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(718, '2501098', '3206953377', 'JASMINE CASTARICA ZEA HASMY', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(719, '2501099', '3209038479', 'Reyhan Alfarizqi', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(720, '2501100', '3194629304', 'Muhammad Rifki Abdus Solihin', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(721, '2501101', '3180532897', 'RAZKA MUHAMMAD FATHURRAHMAN', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(722, '2501102', '3198599297', 'KHAYRA NAUREEN MARLIANTI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(723, '2501103', '3206804138', 'MUHAMMAD EMIRHAN ALFATIH', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(724, '2501104', '3192463604', 'Rahmah Hanin Aqila', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(725, '2501105', '3199274062', 'AZRIL AL HAFIZH HERIYADI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(726, '2501106', '3193202418', 'Syahira Fitri Qirani', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(727, '2501107', '3196955089', 'GHIFARRY ADHITAMA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(728, '2501108', '3196841387', 'Jihan Muthmainnah', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(729, '2501109', '3192585562', 'SYAIDAH NUR ASYIFA', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(730, '2501110', '3190406521', 'CLARISSA SHERYL AULIA PUTRI', '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(731, '2402001', '3192091262', 'RAFIF AFKARI KHELIANTO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(732, '2402002', '3188534199', 'OMAR ALXAIN BUDIMAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(733, '2402003', '3187819864', 'TIARA AISYAH RANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(734, '2402004', '3183116499', 'ASHALINA ZAHRANY SAPUTRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(735, '2402005', '3196197011', 'MUHAMMAD ARFAN MAULANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(736, '2402006', '3183893356', 'AMEENA ZAHRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(737, '2402007', '3197867376', 'NUHA NASYITA SHAFWATUNNISA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(738, '2402008', '3189622781', 'HALIFA SAFA AISYAH HADIWANTO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(739, '2402009', '3198483291', 'ABIL DAFFA MUWAFFAQ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(740, '2402010', '3186944705', 'QEISYA CITRA LESTARI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(741, '2402011', '3186390002', 'RAFANIA AULIA KAMAYEL', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(742, '2402012', '3185694861', 'YASHBI SALAMA MARZIA FAKHIROH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(743, '2402013', '3188698880', 'AROFAH ALZAHRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(744, '2402014', '3193519631', 'RAINA DEWI JELITA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(745, '2402015', '3184475138', 'ZAYN ATHAR ABZARI SIDIK', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(746, '2402016', '3193068549', 'RAFARDHAN ATHALLA NURROHMAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(747, '2402017', '3181213471', 'SYAFINA QOTRUNNADA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(748, '2402018', '3189435513', 'ZHAFIRA MILLA RAFANI KARTOLO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(749, '2402019', '3183084134', 'KYNARA NEVA GALISHA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(750, '2402020', '3181445116', 'AZKAYRA FATHIYATURAHMA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(751, '2402021', '3187137426', 'VANESSA CHESSY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(752, '2402022', '3199245346', 'NADIRA AYU SALZABILLA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(753, '2402023', '3188386219', 'NAFISHA RAZITA RIZKIANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(754, '2402024', '3181602913', 'MUHAMMAD DAFFA ALFARIZI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(755, '2402025', '3189691226', 'GHAITSAA FATHIYYATURAHMA RAINDRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(756, '2402026', '3189569559', 'MOHAMMAD DEVAN AL JABBAR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(757, '2402027', '3180591555', 'ALUNA NIRMALA AYUSITA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(758, '2402028', '3184840158', 'AMANAH RASA KHODIMA ROBBA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(759, '2402029', '3188840664', 'HANA ALZHEA NURSYIFA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(760, '2402030', '3194361464', 'ALI ALFAREZEL DANIYAL BAHRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(761, '2402031', '3197806097', 'ARFADHIA RAFISQY MALIK', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(762, '2402032', '3186758764', 'ADZKIYA KAMILA WANDANA PUTRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(763, '2402033', '3187235433', 'MUHAMMAD ILHAM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(764, '2402034', '3193774889', 'NAYYARA ELSHANUM MAZAYA GIRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(765, '2402035', '3182692268', 'AYSHA NAILA MUHTAR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(766, '2402036', '3194048012', 'RABBANI ABYAN MUSTHAFA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(767, '2402037', '3180896112', 'ARSAN AL AKBAR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(768, '2402038', '3189693297', 'KAHLA ANISA TSABITA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(769, '2402039', '3197461545', 'MUHAMAD YUSUF HAMDANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(770, '2402040', '3181126675', 'FARAH SITI AYUNDA YASMIN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(771, '2402041', '3199715165', 'ARINDRA QONITA HENDRAWAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(772, '2402042', '3180436044', 'SHAQUEENA ARETHA IYOBA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(773, '2402043', '3187337525', 'MUHAMMAD SYABIL PRATAMA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(774, '2402044', '3189029577', 'YUMNAA ZAQIRA ANJANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(775, '2402045', '3195738082', 'AJENG RISKA PEBIYANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(776, '2402046', '3197940352', 'HUMAIRA ASHEEQA INARA PUTRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(777, '2402047', '3198484286', 'MUHAMMAD FAQIH HASANUDIN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(778, '2402048', '3181805449', 'NADIA DAFIRA TRESNA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(779, '2402049', '3183948350', 'NAISYA FITRI YASIRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(780, '2402050', '3193067819', 'ARSYILA SHANUM MEIDINA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(781, '2402051', '3186008020', 'ADRIKNI RATU CLARADHIA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(782, '2402052', '3191856264', 'ALENA SHABIRA RAMADHANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(783, '2402053', '3193933618', 'ANNISA NUR HAFIDZAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(784, '2402054', '3186295220', 'SHOFI NAURA DZAKIYAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(785, '2402055', '3195819571', 'FELISHA RAFANIA BUDIMAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(786, '2402056', '3180775861', 'RAFKA ARYAPUTRA PRATAMA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(787, '2402057', '3187881575', 'GHAITSA ZAHIRA SHOFA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(788, '2402058', '3196164195', 'LATISHA SHAFALUNA NUGRAHA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(789, '2402059', '3188384868', 'AKIO ALTHAF RAFISQY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(790, '2402060', '3192387219', 'LOVA IBTISAM RANIAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(791, '2402061', '3188227899', 'SITI HILYATUSSADIYAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(792, '2402062', '3183753272', 'RAFIF FAEYZA HANDHONO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(793, '2402063', '3188223454', 'ATTHAR ABQORI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(794, '2402064', '3186636590', 'HAFSHAH HANANIA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(795, '2402065', '3185387174', 'ALESHA MUTIARA ZAHIRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(796, '2402066', '3197189726', 'FAIZAR HAFIZ KURNIAWAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(797, '2402067', '3188328600', 'NOVITA NUR HANDAYANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(798, '2402068', '3199965776', 'MIKAILA HASNA WAHYUDI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(799, '2402069', '3191136208', 'AGATHA DYLHA PUTRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(800, '2402070', '3193003894', 'KHANZA AZKADINA AZZAHRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(801, '2402071', '3180174344', 'NABILA AZKAYRA HASMY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(802, '2402072', '3182492658', 'AYYASH MUHAMMAD HASSAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(803, '2402073', '3192273137', 'MUHAMMAD ARFAN JUNIARKA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(804, '2402074', '3180511644', 'JHIOSIN MEGAMI NUGRAHA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(805, '2402075', '3187781783', 'MUHAMMAD AZAM PUTRA SYARROFA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(806, '2402076', '3182951182', 'RIFAN MAULANA ARIANTO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(807, '2303001', '3185144014', 'MUHAMMAD NAZBI AL FARIZI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(808, '2303002', '3171807739', 'MUHAMAD HAFIZH AL PAJRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(809, '2303003', '3186943244', 'QIANZI ADEEVA PUTRI FADILLAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(810, '2303004', '3174827643', 'DEFINA APRIANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(811, '2303005', '3176872065', 'YAFI ALIFUDDIN AFWU', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(812, '2303006', '3174647367', 'INARA KHAMANIA ALFIYAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(813, '2303007', '3172766902', 'SHAKIRA SYIFA AULIYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(814, '2303008', '3183076534', 'AZLAN FAHREZA RAHMAN AL HAFIZ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(815, '2303009', '3171345375', 'HAMIZAN MANAF RAYYAN KURNIAWAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(816, '2303010', '3171011863', 'ABIMANYU ANGKA WIJAYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(817, '2303011', '3186795082', 'MUHAMMAD ZAYD ASADULLAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(818, '2303012', '3181757638', 'NANDRA GIANLUCA AZZAMY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(819, '2303013', '3171972091', 'GENNA BENADEIR ALMUTAIRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(820, '2303014', '3175060869', 'MUHAMMAD LATAMA ADIA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(821, '2303015', '3182874895', 'ALENDRA KEVIN SUNANDAR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(822, '2303016', '3189415769', 'MALIKA RIHADATUL AISY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(823, '2303017', '3177955851', 'WAFA ADZKIYA SOBANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(824, '2303018', '3179889324', 'HIZAM PUTERA ANUGRAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(825, '2303019', '3179880890', 'FELISHA KHANSA RAFANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(826, '2303020', '3173378054', 'SALWAA ALIIFAH WINDIANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(827, '2303021', '3171682241', 'MALIK HAKIM ALHABI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(828, '2303022', '3188866226', 'ALFARIZA RAFARDHAN ATHALLA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(829, '2303023', '3177060748', 'ZANKHA ALENDRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(830, '2303024', '3179046172', 'MUHAMMAD RIZIEQ AR RAYYAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(831, '2303025', '3172727410', 'MYSHA JEHAN ARASELY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(832, '2303026', '3170387315', 'FARIZA PUTRI ASWADI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(833, '2303027', '3173418570', 'AFIF MUHAMMAD TARIM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(834, '2303028', '3172460395', 'ARSHAD TAUFIK MUGHNIANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(835, '2303029', '3178929688', 'ILHAM ZAYN ATHARRAYHAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(836, '2303030', '3189060186', 'SRI NUR SAKILA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(837, '2303031', '3174768092', 'AISHA YAQINA SHANUM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(838, '2303032', '3175879584', 'HAIDAR FATIH MUHAMMAD', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(839, '2303033', '3178693538', 'NADA FITRIYA RAMADHANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(840, '2303034', '3177809078', 'FEBRI ARFAN HASHIF', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(841, '2303035', '3176655031', 'MALIQ FELIYAN ABRISAM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(842, '2303036', '3186913592', 'KAISYHA PUTRI RAMADHANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(843, '2303037', '3173140945', 'NAYLA AGHISNA IBNATY SAKHI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(844, '2303038', '3182527039', 'MUHAMMAD NAUFAL RIZKI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(845, '2303039', '3172793258', 'ADHAM WASIM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(846, '2303040', '3174166525', 'ABIZAR FAUNDRA ALGHIFARI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(847, '2303041', '3170110116', 'NAYYARA KHANZA RAMADANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(848, '2303042', '3172820516', 'RAISYA AMANDA PUTRI RAMADANSYAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(849, '2303043', '3179479944', 'FATHIYYAH YUMNA SHIDQI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(850, '2303044', '3184432834', 'MUHAMMAD IHSAN SYAMIL RAMDANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(851, '2303045', '3183304182', 'MUHAMMAD HANIF AISY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(852, '2303046', '3186349425', 'ALMEERA ALEESHA AHZA INARA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(853, '2303047', '3172622405', 'NAIFA ZIA ALMAHYRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(854, '2303048', '3172756113', 'MUHAMMAD SYABILL AKBARIEQ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(855, '2303049', '3182695988', 'FANY AZHAR AZIZA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(856, '2303050', '3179385212', 'CALYA ISMA RAFFANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(857, '2303051', '3175927594', 'PUTRI ASYHA DHIANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(858, '2303052', '3172747218', 'MUHAMMAD ZAYN HAMZAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(859, '2303053', '3179430606', 'MUHAMMAD AHSAN AL HASANIE', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(860, '2303054', '3185580046', 'MUHAMMAD ZAID KURNIA ZIAULHAQ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(861, '2303055', '3175731450', 'RUZAIN ZOLA FIRDAUS', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(862, '2303056', '3180881914', 'MUHAMMAD FATHAN ZAKARIA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(863, '2303057', '3172687909', 'AMELIA ZIA SAIDAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(864, '2303058', '3179574700', 'ALGHANY FAQIHUL MALIK', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(865, '2303059', '3184872643', 'AISYAH JENNAIRA SIDIQ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(866, '2303060', '3175369710', 'GANES ALDIFA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(867, '2303061', '3174073554', 'ALVINO KEENAN JUNIARTA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(868, '2303062', '3179886191', 'ASYIFA NUR FITRIA LESMANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(869, '2303063', '3176127466', 'RANFI MUHAMMAD AL FATIH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(870, '2303064', '3171110099', 'KEYSHA NURUL AZHAR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(871, '2303065', '3183627014', 'AZKA RAFA RABBANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(872, '2303066', '3176995717', 'ABDULLAH KHOIRUL AZZAM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(873, '2303067', '3172063359', 'MUHAMMAD ARFADHIA MALIK IBRAHIM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(874, '2303068', '3180124865', 'YUSUF AL HOERUDIN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(875, '2303069', '3188000561', 'NIDA AYU RAMADHANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(876, '2303070', '3180347075', 'ANDRE HANAN ADYATAMA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(877, '2303071', '3175724545', 'AZRINA LAVENIA QOTRUNNADA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(878, '2303072', '3180233461', 'FAHRA HUMAIRA AQMARINA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(879, '2303073', '3171977051', 'ADRIAN PRADIPTA AMZARI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(880, '2303074', '3170143922', 'MUHAMMAD NAUFAL JAMIL', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(881, '2303075', '3171413624', 'ALENA ZEA ALMAIRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(882, '2303076', '3179304431', 'AZZAM KHALIF ANANDA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(883, '2303077', '3172015183', 'MUHAMMAD SONJAYA AL BANTANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(884, '2303078', '3172598460', 'MUHAMMAD ZALFA AL MUTTAQIN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(885, '2303079', '3173567464', 'ALESHA KHALILUNA NASREEN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(886, '2303080', '3173635312', 'NAFISAH DWI SYIFA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(887, '2303081', '3165752480', 'ALFIAN NIZAM ABQARI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(888, '2303082', '3187479934', 'ILHAM BAGUS SUGIARTO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(889, '2303083', '3171334571', 'WENI ZAHIRAH FADHILAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(890, '2303084', '3175650781', 'CYNTIARA ALFATHUNNISA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(891, '2303085', '3173635327', 'REYNAND MALIK ATHARIANDI DAUD', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(892, '2303086', '3186941263', 'AYANA SIMRA SAUQIA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(893, '2303087', '3181365948', 'MUHAMMAD AFNAN ALGHOZALI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(894, '2303088', '3174768087', 'DZAKI ALMERZADA ALYKHANSA SOFYAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(895, '2303089', '3172489599', 'MUHAMAD SAHALUDIN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(896, '2303090', '3189332320', 'LAVINA EMBUN HAFIZHAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(897, '2303091', '3172425114', 'ELEANOR SCARLET NATANIA MANONGKO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(898, '2303092', '3189292446', 'KEISHA ANINDYA PUTRY ARDANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(899, '2303093', '3177812001', 'ARJUNA GANEENDRA NUSANTARA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(900, '2303094', '3189130720', 'RAFISQY AIMAR AL RASYID', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(901, '2303095', '3176474718', 'PUTRI RIFANA RINDIANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(902, '2303096', '3171729544', 'MOHAMMAD ARGA PRATAMA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(903, '2303097', '3178359655', 'AL BARA BIN MALIK ABDULLAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(904, '2303098', '3175420620', 'NAZZA VIQA ROMAHESA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(905, '2303099', '3170116520', 'KHAIRA HAZEL PITALOKA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(906, '2303100', '3182744038', 'M ABDUL QODIR AS-SHIDDIQ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(907, '2303101', '3176615786', 'NIZAAR RUSMAWAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(908, '2303102', '3177487562', 'SYAIKHAN JUMHUR ULUM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(909, '2303103', '3178827996', 'ARSY SINARA KAULA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(910, '2303104', '3177054920', 'NOVAL ARDIANSYAH WANDANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(911, '2303105', '3179979816', 'GHAIDA NAJLA MASYURAH RIZKI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(912, '2204001', '3168007557', 'MUTIARA RAMADANI NUR ALIPAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(913, '2204002', '3162004817', 'MUHAMMAD DEXSA GUMILAR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(914, '2204003', '3171832909', 'AQILLA ZIDNA ILMA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(915, '2204004', '3171878474', 'ALLURA SEVANIA PANGESTU', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(916, '2204005', '3177277453', 'ARSILA MUFIA NATHANIA PUTRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(917, '2204006', '3162424589', 'QUDWAH NAILUL FADLILAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(918, '2204007', '3161592351', 'ALVINO ZAFRAN MUKHLIS PUTRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(919, '2204008', '3162964145', 'MUHAMMAD ILHAM NURAHMAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(920, '2204009', '3166919170', 'AZKIA SYIFA KHOERUNISA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(921, '2204010', '3161422120', 'MUHAMMAD DZIKRI HAMDILLAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(922, '2204011', '3160904572', 'FAWWAZ MAULANA AGNI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(923, '2204012', '3166617040', 'MUHAMMAD YAZDANIAR ASSIROJI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(924, '2204013', '3178916554', 'HAISHA NUR LATIFAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(925, '2204014', '3165167991', 'MUHAMAD ADZKA ALKHAFARIZI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(926, '2204015', '3168342815', 'DEDE SOFIYAN SOLEHUDIN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(927, '2204016', '3167350483', 'NAUFAL RIFQI HAMIZAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(928, '2204017', '3177794363', 'JIHAN PUTRI YUWONO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(929, '2204018', '3172960600', 'MUYASSARO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(930, '2204019', '3168245281', 'NADHIFAH SALSABILA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(931, '2204020', '3176056712', 'ADREENA RUMAISHA ARDIANTI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(932, '2204021', '3166526409', 'MOCH RAFIKI FAJAR PRATAMA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(933, '2204022', '3173035480', 'RASHAFA IRSYAD PERMANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(934, '2204023', '3167761688', 'ANNASYA ADREENA SAILA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(935, '2204024', '3166982475', 'MUHAMMAD AZAM AKBAR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(936, '2204025', '3166380785', 'MUHAMAD EL ARSYAD RAMADANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(937, '2204026', '3165673427', 'KANZIA ANNASYA SHAZFA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(938, '2204027', '3161286939', 'AGHNIYA HAUNA SOFYAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(939, '2204028', '3164869307', 'MUHAMMAD TUBAGUS FAZA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(940, '2204029', '3175686538', 'MUHAMMAD ZAIN ABDUL AZIZ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(941, '2204030', '3161904200', 'RAFFASYA SAKHA RAJENDRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(942, '2204031', '3160638967', 'MAZAYA NAZIA AKMAL', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(943, '2204032', '3178461691', 'AZMYA AZKADINA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(944, '2204033', '3160941027', 'MUHAMMAD FAHRI SYAHPUTRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(945, '2204034', '3178260525', 'KEIZHA MAILIANI PUTRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(946, '2204035', '3161734592', 'SUCI HERLINA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(947, '2204036', '3173717937', 'MUHAMMAD SAEBAN ALI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(948, '2204037', '3167214833', 'MUHAMAD RASYID SYAZANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(949, '2204038', '3175981132', 'RICHI KAILI MUHAMMAD', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(950, '2204039', '3166063344', 'RAFFI FADILLAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(951, '2204040', '3169003972', 'RAJENDRA ARSENIO FADHIL', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(952, '2204041', '3169296254', 'RAJA GHANI AL ZAYYAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(953, '2204042', '3167688480', 'KYLA SABIA ARAFIAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(954, '2204043', '3175912581', 'ALANA KAHILA RAY FIRMANSYAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(955, '2204044', '3167869394', 'KINANTI SYAUQI HUNNA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(956, '2204045', '3172468693', 'RANIA HILYAH NAFISAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(957, '2204046', '3163897163', 'BIRU PRATAMA SABIAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(958, '2204047', '3164485311', 'ANISA PUTRI NUR ADELIA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(959, '2204048', '3174972030', 'MUHAMMAD ZAIN ARSYIL ZAIDAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(960, '2204049', '3162841473', 'YUDHA FATHAN MUHAMMAD RIDWAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(961, '2204050', '3170324609', 'ALIFA AZKADINA SIMANJUNTAK', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(962, '2204051', '3162765261', 'BERLIAN RATU ALZAHIRRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(963, '2204052', '3169616736', 'NAYRA MYESHA ENDISAPUTRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(964, '2204053', '3163948385', 'MIZANNUL KHOIRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(965, '2204054', '3168434443', 'FAREZA MUHAMMAD ZHAFRAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(966, '2204055', '3169417337', 'MALIHA DHIYA NUGRAHA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(967, '2204056', '3163881935', 'FAYZA ALYA AZIZA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(968, '2204057', '3175352303', 'MUHAMMAD RIZAL MARTADINATA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(969, '2204058', '3172210773', 'ALYA AZIZAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(970, '2204059', '3166758583', 'ZAHIRAN TALITA SAKHI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(971, '2204060', '3170623173', 'HANUM QURROTA A\'YUN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(972, '2204061', '3163555416', 'ARKAN ALFATIH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(973, '2204062', '3167908315', 'RAFA DZAKIANDRA AZHAR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(974, '2204063', '3162171249', 'ELZIRA LABIBA NURGANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(975, '2204064', '3167797289', 'DHEA ANANDA IRAWAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(976, '2204065', '3172588426', 'RAFANDRA ATHALLA GUMILAR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(977, '2204066', '3165848705', 'MUHAMMAD KEANU AR SHAKA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(978, '2204067', '3168489916', 'GAFAR ARIFAI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(979, '2204068', '3154404202', 'SHAKILLA RAHMA KURNIA PUTRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(980, '2204069', '3164544990', 'AFIFA NAHDA RAFANDA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(981, '2204070', '3171059941', 'DZAKIRA TALITA ZAHRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(982, '2204071', '0161956024', 'ZISKIND FAIRUL HAFIDZAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(983, '2204072', '3161020833', 'DEVANO JULIAN ABRAR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(984, '2204073', '3165998873', 'MUHAMAD RIVALDI NURDIANSAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(985, '2204074', '3178604230', 'ATIKAH BALQIS HUMAIRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(986, '2204075', '3176218187', 'MOCHAMMAD FACHRI RASDHAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(987, '2204076', '3164701932', 'NAUREEN ADREENA ALFATHUNISSA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(988, '2204077', '3179226277', 'SALSABILA NADHIFA AZZAHRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(989, '2204078', '3163192154', 'AZKA ADHYATSA PRADIPTA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(990, '2204079', '3173530892', 'FATHAN RAFISQY AFKARI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(991, '2204080', '3171797098', 'ADITYA WIGUNA HAMZAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(992, '2204081', '3165095120', 'MOZA RAFANIA AYSHA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(993, '2204082', '3163881686', 'FARREL AHMAD GIBRAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(994, '2204083', '3173259338', 'ARSYAL NAZHIRUL ASROFI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(995, '2204084', '3177906792', 'ZEA ADENIA ATTAYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(996, '2204085', '3179531596', 'NADA ZIALOVA LUQYANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(997, '2204086', '3167889274', 'AQEELA BILQIS MAMANGKEY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(998, '2204087', '3164384606', 'ALGIFARI KHOIRUL INSAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(999, '2204088', '3167632647', 'HANIN NUR LATHIFAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1000, '2204089', '3154005815', 'FARIS KHOIRUL GIBRAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1001, '2204090', '3160214862', 'FADHLAN ARKHAN FATURRAHMAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1002, '2204091', '3160992166', 'KHAYLA VARISHA SYAFIQHA PERMANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1003, '2204092', '3164137440', 'NIA MUFLIHATUS SAADAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1004, '2204093', '3164322212', 'NAUFAL ARGA ADHYASTA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1005, '2204094', '3173854680', 'MUHAMMAD AKMA AL HAZMI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1006, '2204095', '3164492354', 'ARISSA NAFISHA SHAREEN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1007, '2204096', '3165231436', 'YAFI GHANIM MA\'RUF', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1008, '2204097', '3168737674', 'RIFQI MUHAMAD SYARIF', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1009, '2204098', '3162504436', 'ZAINA RAMADHAN ALFATHUNISA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1010, '2204099', '3167572256', 'NATHANIA AYESHA MUMTAZAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1011, '2204100', '3168397692', 'SHAYLA ATQIYA FADILLAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1012, '2204101', '3160563428', 'NASREEN AZBAH SHOFIYYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1013, '2204102', '3164039982', 'MUHAMMAD ZAIDAN ALGHIFARI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1014, '2204103', '3178125879', 'AZMI MAULIDA RUBI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1015, '2204104', '3176739433', 'ALFAR REZAL', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1016, '2204105', '3169939339', 'MUHAMAD RIYAD JINAN FAYI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1017, '2204106', '3178602111', 'ALLESYA SHAQUEENA ALMAHIRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1018, '2204107', '3166103950', 'ZIDAN ARSENIO RAFIF', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1019, '2204108', '3170313934', 'DHEFITA NIZZA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1020, '2204109', '3173119596', 'MASHEL AZHAR ALRESCHA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1021, '2204110', '3172345711', 'ARFAN ALFARIZI WIDADI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1022, '2204111', '3166337153', 'SHEIRA MAULIDA AHMAD', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1023, '2204112', '3156859470', 'DIKI MAULANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1024, '2105001', '3161394420', 'ABDI MUHAMMAD ADZAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1025, '2105002', '3158631284', 'AQIFA DZAKIYA ENDISAPUTRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1026, '2105003', '3152006143', 'GHINA SYAKIRA NOVIANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1027, '2105004', '3166586045', 'NAVISA NURLIANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1028, '2105005', '3158615351', 'JUNNA NOVANDANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1029, '2105006', '3157836399', 'IBNU ARAZKA FATURRAHMAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1030, '2105007', '3156199831', 'FAIZ NAUFAL RABBANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1031, '2105008', '3146681002', 'M. SHAKEEL PERTALA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1032, '2105009', '3158216819', 'HASNA FAIZA RAHMILAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1033, '2105010', '3165170912', 'REAGAN ATTHARIZ GHAITSAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1034, '2105011', '3167067468', 'ZHAFIRA DZAQUEENA KHAIRANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1035, '2105012', '3174417315', 'NAHDA HAFIDZAH RAMADHINA R', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1036, '2105013', '3153917415', 'RAKHA ADITYA RAMADHAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1037, '2105014', '3159613314', 'KENJI ALWAAN NURROHIM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1038, '2105015', '3151768301', 'HASBY NAZRUL ASYROF', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1039, '2105016', '3152703033', 'NADYA AZKIA PUTRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1040, '2105017', '3154606979', 'CLARISA FATHIYYATURAHMA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1041, '2105018', '3153940854', 'HAIDAR AL MAIRI MUHAMAD JAELANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1042, '2105019', '3150341029', 'DANIS ALIF FAUZHAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1043, '2105020', '3151019537', 'ADIBA AZZAHRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1044, '2105021', '3169614951', 'ZALFHA KHAIRRA SOFWHA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1045, '2105022', '0159914453', 'SHAFIRA NUR HASANAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1046, '2105023', '3154742191', 'NAURA SHAKILA HASNA ANNIDA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1047, '2105024', '3153490673', 'BILQIS FA\'IHA RIFDA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1048, '2105025', '3150460152', 'MIKHAILA RAFANDA NUGRAHA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1049, '2105026', '3153275660', 'GAIZKA AKMAL KAELAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1050, '2105027', '3163849838', 'ALIFA NAZMIA MARIA ULFA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1051, '2105028', '3150396110', 'NADINE KHAIRA PUTRI SURYADI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1052, '2105029', '3160289172', 'M FAIZ ABDUL RASYID', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1053, '2105030', '3151306490', 'RIZQI LANGIT RAMADHAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1054, '2105031', '3168085755', 'AYASHA LATISHA AQUINA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1055, '2105032', '3151877721', 'NIZAM KHAIRY AL-GHIFARI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1056, '2105033', '3150386448', 'AINAYYA IZZATUNNISA MAULANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1057, '2105034', '3150050462', 'CANTIKA ANJANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1058, '2105035', '3158781449', 'KANIA LISMA APRIYANTI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1059, '2105036', '3154607208', 'HADI WASLI AKMAL', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1060, '2105037', '3160525564', 'FAWWAZA AGNIA KHOERUNNISWA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1061, '2105038', '3157922525', 'MUHAMMAD DAFFA SUPRIADI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1062, '2105039', '3160984598', 'ALTAN IRFANI AZIZ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1063, '2105040', '3155714678', 'HABIBI MIKAIL AL GHANI GUNARAHARJA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1064, '2105041', '3152213910', 'HAFSA ALIQA KHUMAIRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1065, '2105042', '3168625544', 'PUTRI MIKEYLA SETIAWAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1066, '2105043', '3156740298', 'ZAHIRA SHAFA ASSYABIYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1067, '2105044', '3154828249', 'SAYYID AHMAD YUSUF FARHAAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1068, '2105045', '3154266456', 'ANINDYA NUR FAUZIAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1069, '2105046', '3160877530', 'GHANIA RAZKA ZEINA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1070, '2105047', '3160525312', 'MUHAMMAD ADNAN AL HAFIDZ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1071, '2105048', '3163592144', 'KENZIE ARSYANA SYIFA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1072, '2105049', '3166710952', 'ALEA ZAINA NUR MEDINA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1073, '2105050', '3164495487', 'AINNAYA FATHIYYA TURAHMA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1074, '2105051', '3166856807', 'NAUFAL ADHYASTHA ARYASATYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1075, '2105052', '3155530611', 'MUHAMMAD RAFA RASENDRYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1076, '2105053', '3161301192', 'REIKHANZA DEANISHSYAM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1077, '2105054', '3169077664', 'KHOIRUNNISSA NUR SOPIAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1078, '2105055', '0151772543', 'GEULISHA NUR WULAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1079, '2105056', '3153089323', 'NISA NUR KAMILAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1080, '2105057', '3159124594', 'ARUSHI SAFIYA RAMADITHA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1081, '2105058', '3159538846', 'MUHAMMAD RASYA ARIF ATHAYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1082, '2105059', '3158395806', 'MUHAMMAD ZIYYAD ALQORNI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1083, '2105060', '3146323150', 'ATHIFAH YASMIN BAHRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1084, '2105061', '3152500586', 'MUHAMMAD ABYAN NABIL WIBOWO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1085, '2105062', '3150053094', 'ALESHA CORDELIA RAFANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1086, '2105063', '3158659951', 'CALLISTA PUTRI AZZAHRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1087, '2105064', '3152823891', 'MIRZA PRADANA HERYADI PUTRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1088, '2105065', '3165851837', 'ALEXSHIO PUTRA PRATOMO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1089, '2105066', '3169905482', 'NAFEEZA NUR SYAKIRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1090, '2105067', '3151356255', 'REGIANA SYABILLA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1091, '2105068', '3155961554', 'ALULA HANUN AYUNNINDYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1092, '2105069', '3151271987', 'ALMAIRA QISYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1093, '2105070', '3158938292', 'MUHAMMAD ARSYAD ALFATIH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1094, '2105071', '3151895737', 'DAFNI APRILYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1095, '2105072', '3152615250', 'MUHAMAD RYUKI FIRMANSYAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1096, '2105073', '3156431933', 'GIANT ADITYA ARDANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1097, '2105074', '3158914693', 'ZAMZAM ALINURDIN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1098, '2105075', '3164164206', 'LEMBAYUNG SENJA INDAH RIYANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1099, '2105076', '3158925329', 'NAFISAH PUTRI SOLEH HASANAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1100, '2105077', '3151324439', 'KHIRANI PUTRI MARYAM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1101, '2105078', '3150804027', 'MUHAMMAD NAFISUL ISLAM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1102, '2105079', '3159534042', 'AINUN SYALWA KUSWANTORO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1103, '2105080', '0153535229', 'NAYLA MUAZARA ULFA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1104, '2105081', '0156836726', 'ADITYA NAUFAL DARY ABIYYU', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1105, '2105082', '3159545404', 'MUHAMMAD IKHSAN RAMDHANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1106, '2105083', '3166068974', 'MUHAMMAD FAUZI NURZAMAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1107, '2105084', '3169775984', 'MIKHAYLA BEYZA KIANDRA AKBAR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1108, '2105085', '3152006096', 'QUTHBIE HADZIQ EL SAKHI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1109, '2105086', '3157224646', 'SHOFWAN NURSHOBAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1110, '2105087', '0152969124', 'SABINA NABILIA AL ZAHSY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1111, '2105088', '3163258739', 'SABIYA ANDRIYANA YASMIN', '2026-09-22 19:28:11', '2026-09-22 19:28:11');
INSERT INTO `tbl_siswa` (`idsiswa`, `nis`, `nisn`, `nama`, `created_at`, `updated_at`) VALUES
(1112, '2105089', '3151852118', 'ADISTIA PUTRI AFRIN NURHASANAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1113, '2105090', '3169019904', 'NIDA KHOIRYAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1114, '2105091', '3156418478', 'AISY TSABITHA AFSHEEN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1115, '2105092', '3156884724', 'SITI ZAHIRA RAMADHANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1116, '2105093', '3155241679', 'FIKRI AISAR ARROZAQ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1117, '2105094', '3152294157', 'AZKA IFTIKHAR HAWARI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1118, '2105095', '3160249927', 'NAISYLA NAZWA DOLONSEDING', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1119, '2105096', '3160015237', 'SHAQUEENA MEYZZA HAFLASEA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1120, '2105097', '3152733205', 'MUHAMMAD SATRIA ARDHANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1121, '2105098', '3162463904', 'IQBAL KHOIRUDIN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1122, '2105099', '3151432760', 'NADHIRA RINJANI MAULANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1123, '2105100', '3157805766', 'FATHAN RIZKY BUDIMAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1124, '2105101', '3155598216', 'HAVIKA YUMNA WIDAYANTI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1125, '2105102', '3166738195', 'DIFA FATIHAH PUTRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1126, '2105103', '3159625878', 'HAMIZAN RAMADHAN FIRMANSYAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1127, '2105104', '3151583040', 'ZAIDLI MALIK FAUZI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1128, '2105105', '3156973791', 'SALMA HANUM AZIZAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1129, '2105106', '3156484225', 'MUHAMMAD ALRAJ ALGHANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1130, '2105107', '3151945549', 'BERLIAN NADA ZHAFIRAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1131, '2105108', '3158522672', 'SITI MULYAMAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1132, '2105109', '3159212674', 'MUHAMMAD  GHAZY GHALIBIE', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1133, '2006001', '0141183953', 'ALIFAH KHAIRUNNISA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1134, '2006002', '3153833423', 'ATQIYA MAULIDA MUTHMAINNAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1135, '2006003', '3146132336', 'ALGIS AL GHIFARY MAULANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1136, '2006004', '3152907711', 'FATWA ADAM MALIK', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1137, '2006005', '0147759973', 'SYAFIK KHAIRY NASYWAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1138, '2006006', '0133250720', 'MUHAMMAD ALWI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1139, '2006007', '3146197568', 'AZKYA MEYDINA SUKMA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1140, '2006008', '3149418686', 'AZIZAH GALUH AL KHANSA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1141, '2006009', '3145609020', 'KESTIARA NURSIDQIYA GUNAWAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1142, '2006010', '3144345525', 'LATISYA EPI AZALIA KARTIWI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1143, '2006011', '3148779134', 'KIARA ANINDYA FAUZIAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1144, '2006012', '0142022126', 'FAQIH AZZAM PRAMUDYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1145, '2006013', '3147481720', 'KEENAN ARKANA MU\'AFFA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1146, '2006014', '3152049420', 'NABILA HASNA FADILAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1147, '2006015', '3150389131', 'GAZHAN DZAKY AUMAE', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1148, '2006016', '3148742647', 'ALFARO HISYAM ATHAYAFI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1149, '2006017', '3149644081', 'AUFABIYYA QIANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1150, '2006018', '0142673297', 'ALFIRA BELLVANIA AZZALEA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1151, '2006019', '0142800281', 'MUHAMMAD ZAFRAN AL QAWIY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1152, '2006020', '3143257991', 'TSUROYA MUNA MUNIFAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1153, '2006021', '3155039433', 'RANIA FATWAH EPRILIA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1154, '2006022', '3145082292', 'DANESWARA FAYYADHI ZHAFAR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1155, '2006023', '3147565727', 'KHANZA USWATUN HASANAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1156, '2006024', '3148743470', 'AZHAR HUSNA ALIFAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1157, '2006025', '3147729965', 'NUGIE AL FARIDZI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1158, '2006026', '3142574126', 'ALVIAN MIFZAN SIDDIQ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1159, '2006027', '3152353573', 'MUHAMMAD KEVIN ANANDIKA AL FARISI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1160, '2006028', '3153791976', 'UNAISAH SYAKIRA HUSNA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1161, '2006029', '0146731502', 'AULIA AGUSTINI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1162, '2006030', '0147622467', 'ZALDI ALIYUDIN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1163, '2006031', '0147761284', 'AIRA SYAHRAINI WIEDAN PUTRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1164, '2006032', '0149074495', 'NAUFAL SYAMIL ADZ DZAKI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1165, '2006033', '3157982128', 'NINDY  MIKAYLA SAFA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1166, '2006034', '0141942067', 'RIDWAN NUR ANGGARA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1167, '2006035', '3158943568', 'ASHAFA RUMAISHA DHIBA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1168, '2006036', '3140360139', 'RUMMI NUR RIYANTI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1169, '2006037', '3153978916', 'MUHAMMAD HAMZY SYARIF JAMALY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1170, '2006038', '0142106235', 'MEIKA ARTHA MEVIANA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1171, '2006039', '0144992514', 'WAFA AURA CANTIKA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1172, '2006040', '3145282680', 'HANAFI RASYID THALIB HADIWANTO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1173, '2006041', '3149170441', 'SYAKIRA KHANZA AZZAHRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1174, '2006042', '3141205522', 'RAFIDAN ATHARI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1175, '2006043', '0145264434', 'MUHAMAD NIZZAR KURNIAWAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1176, '2006044', '3142052476', 'RATNA HASANATUL MARYAM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1177, '2006045', '3145365358', 'ABDUL AZIZ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1178, '2006046', '3155394688', 'AZHNIE MAULIDA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1179, '2006047', '3146219934', 'YOHANNA VANIA AZZAHRA DAELI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1180, '2006048', '3157354442', 'MUHAMAD DAFHIN AL FAKHRY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1181, '2006049', '3142318643', 'ADZKIA SAMHA SAUFA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1182, '2006050', '3148698100', 'AULIYA AGUSTIN ZANATI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1183, '2006051', '0159806758', 'PUTRI AUDYNA SARAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1184, '2006052', '0145710006', 'SANY SEFTIYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1185, '2006053', '3157534771', 'ARSYA ADNAN AL AZZAM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1186, '2006054', '3141118197', 'ADITYA HIDAYAT', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1187, '2006055', '3140219270', 'AHMAD HABIBI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1188, '2006056', '3140571135', 'NAJMAH ELVY ANJANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1189, '2006057', '0146971434', 'DAIFA AFNAN AR RAZIQ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1190, '2006058', '3142914366', 'SHELLA AGNI SALMA KHUMAIRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1191, '2006059', '0148390219', 'MUHAMAD SUPYAN ASSAURY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1192, '2006060', '3146834066', 'QIANDRA ZAHRA ANDARI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1193, '2006061', '3141416260', 'MUHAMAD WILDAN ARYATAMA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1194, '2006062', '0145115371', 'SHAKILA QAIREEN KHANSAIRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1195, '2006063', '3140407930', 'KHANSA MECCA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1196, '2006064', '0142496879', 'RAFFA FARHAN PRADIPTA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1197, '2006065', '0142758032', 'MUHAMMAD FHAREL AL REEZQY', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1198, '2006066', '3144054022', 'MUHAMMAD RAIHAN SURYAKUSUMA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1199, '2006067', '3155683414', 'ZAHWA NUR AZIZAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1200, '2006068', '0147331647', 'KIANA ALMAIRA AZARINE', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1201, '2006069', '0146175871', 'SYAKEELA AZZALEA QAIREEN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1202, '2006070', '3140159855', 'MUHAMMAD SULTHAN NAZHIRUL ASROFI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1203, '2006071', '0149129410', 'MUHAMMAD FAHRIL RAMADHAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1204, '2006072', '0142127546', 'PRANAJA ADELARD MURIZ DZIKRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1205, '2006073', '3140292870', 'FAHRI ALZAM ARRASYID', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1206, '2006074', '3159029831', 'SYAFA DWI CAHYANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1207, '2006075', '3141122725', 'RAIHAN AZKA ARRASYID', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1208, '2006076', '0141833736', 'SHAFIRA SALSABILLA SYAKILA SHALEHAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1209, '2006077', '0146081112', 'SABRINA SAKHI RAMADHANI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1210, '2006078', '3148154434', 'ZAIN ZIDAN IBRAHIM', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1211, '2006079', '3152536267', 'SYAFIQ KAFI HARISUL HAQ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1212, '2006080', '3158589747', 'VIKRI MAULANA ARIANTO', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1213, '2006081', '0142563613', 'SIENNA ADZKIA QUEENAIRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1214, '2006082', '3155874575', 'AMIRA NADHMI ADDIN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1215, '2006083', '3154831247', 'ALYA RAFA RAMDAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1216, '2006084', '3144392179', 'KHAIRAATUN HISAAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1217, '2006085', '3144768523', 'M FIQRI HAMIZAN ALI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1218, '2006086', '3148000233', 'MUHAMMAD ZUL FAZZAR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1219, '2006087', '0146644492', 'AHMAD HANAFIAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1220, '2006088', '3151365276', 'MAHIRA DELISHA NUGRAHA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1221, '2006089', '3145068145', 'MUHAMMAD LUTHFI SAPUTRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1222, '2006090', '3152809878', 'MEYSHA AMANDA RATU SAKIRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1223, '2006091', '0146995513', 'GHAISAN AHMAD ATHARIZZ', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1224, '2006092', '3144808503', 'SARAH AZNIA NOVIYANTI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1225, '2006093', '0144226044', 'AYVA NURKAMILA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1226, '2006094', '3145893610', 'MUHAMMAD REIHAN ARDIANSYAH RAMADHAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1227, '2006095', '3151605205', 'RAFIQI JAMIL HAMLAN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1228, '2006096', '0146386185', 'ZHAFIR TRYSTAN MUDZAKIR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1229, '2006097', '3146057857', 'MUHAMAD KHAERUL ABADI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1230, '2006098', '3140840776', 'SHAKIRA PUTRI NUGRAHA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1231, '2006099', '3148482964', 'ARYA MUHAMMAD ZAHRONI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1232, '2006100', '3141826901', 'ELGYA HENDRIK PUTRA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1233, '2006101', '3145947174', 'MUHAMMAD REZKY ADITYA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1234, '2006102', '3150190211', 'ZAINA ALMAHYRA KARTOLO PUTRI', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1235, '2006103', '3147204736', 'RAFFA MUHAMMAD ABDILLAH', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1236, '2006104', '3145638978', 'FAIDHAN IRHAB NABIL', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1237, '2006105', '3149078333', 'AQILLA MAURA NAJWA', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1238, '2006106', '0154247265', 'MUHAMMAD HANIF ALMUNDZIR', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1239, '2006107', '3151457095', 'AKIFA NAILA FALAHUDIN', '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1240, '2006108', '3141211286', 'MUTIARA ALMIRA SALSABILA', '2026-09-22 19:28:11', '2026-09-22 19:28:11');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_siswa_kelas`
--

CREATE TABLE `tbl_siswa_kelas` (
  `idsiswakelas` bigint(20) UNSIGNED NOT NULL,
  `idsiswa` bigint(20) UNSIGNED NOT NULL,
  `idkelasdetail` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_siswa_kelas`
--

INSERT INTO `tbl_siswa_kelas` (`idsiswakelas`, `idsiswa`, `idkelasdetail`, `created_at`, `updated_at`) VALUES
(621, 621, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(622, 622, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(623, 623, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(624, 624, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(625, 625, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(626, 626, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(627, 627, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(628, 628, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(629, 629, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(630, 630, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(631, 631, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(632, 632, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(633, 633, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(634, 634, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(635, 635, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(636, 636, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(637, 637, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(638, 638, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(639, 639, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(640, 640, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(641, 641, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(642, 642, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(643, 643, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(644, 644, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(645, 645, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(646, 646, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(647, 647, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(648, 648, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(649, 649, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(650, 650, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(651, 651, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(652, 652, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(653, 653, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(654, 654, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(655, 655, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(656, 656, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(657, 657, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(658, 658, 1, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(659, 659, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(660, 660, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(661, 661, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(662, 662, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(663, 663, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(664, 664, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(665, 665, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(666, 666, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(667, 667, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(668, 668, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(669, 669, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(670, 670, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(671, 671, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(672, 672, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(673, 673, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(674, 674, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(675, 675, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(676, 676, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(677, 677, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(678, 678, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(679, 679, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(680, 680, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(681, 681, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(682, 682, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(683, 683, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(684, 684, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(685, 685, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(686, 686, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(687, 687, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(688, 688, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(689, 689, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(690, 690, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(691, 691, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(692, 692, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(693, 693, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(694, 694, 7, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(695, 695, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(696, 696, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(697, 697, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(698, 698, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(699, 699, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(700, 700, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(701, 701, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(702, 702, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(703, 703, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(704, 704, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(705, 705, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(706, 706, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(707, 707, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(708, 708, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(709, 709, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(710, 710, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(711, 711, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(712, 712, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(713, 713, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(714, 714, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(715, 715, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(716, 716, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(717, 717, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(718, 718, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(719, 719, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(720, 720, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(721, 721, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(722, 722, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(723, 723, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(724, 724, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(725, 725, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(726, 726, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(727, 727, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(728, 728, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(729, 729, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(730, 730, 8, '2026-09-22 19:28:10', '2026-09-22 19:28:10'),
(731, 731, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(732, 732, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(733, 733, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(734, 734, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(735, 735, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(736, 736, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(737, 737, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(738, 738, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(739, 739, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(740, 740, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(741, 741, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(742, 742, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(743, 743, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(744, 744, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(745, 745, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(746, 746, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(747, 747, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(748, 748, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(749, 749, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(750, 750, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(751, 751, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(752, 752, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(753, 753, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(754, 754, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(755, 755, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(756, 756, 2, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(757, 757, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(758, 758, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(759, 759, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(760, 760, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(761, 761, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(762, 762, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(763, 763, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(764, 764, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(765, 765, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(766, 766, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(767, 767, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(768, 768, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(769, 769, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(770, 770, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(771, 771, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(772, 772, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(773, 773, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(774, 774, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(775, 775, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(776, 776, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(777, 777, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(778, 778, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(779, 779, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(780, 780, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(781, 781, 9, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(782, 782, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(783, 783, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(784, 784, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(785, 785, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(786, 786, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(787, 787, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(788, 788, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(789, 789, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(790, 790, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(791, 791, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(792, 792, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(793, 793, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(794, 794, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(795, 795, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(796, 796, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(797, 797, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(798, 798, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(799, 799, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(800, 800, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(801, 801, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(802, 802, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(803, 803, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(804, 804, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(805, 805, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(806, 806, 10, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(807, 807, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(808, 808, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(809, 809, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(810, 810, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(811, 811, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(812, 812, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(813, 813, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(814, 814, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(815, 815, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(816, 816, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(817, 817, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(818, 818, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(819, 819, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(820, 820, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(821, 821, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(822, 822, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(823, 823, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(824, 824, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(825, 825, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(826, 826, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(827, 827, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(828, 828, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(829, 829, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(830, 830, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(831, 831, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(832, 832, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(833, 833, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(834, 834, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(835, 835, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(836, 836, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(837, 837, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(838, 838, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(839, 839, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(840, 840, 3, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(841, 841, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(842, 842, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(843, 843, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(844, 844, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(845, 845, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(846, 846, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(847, 847, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(848, 848, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(849, 849, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(850, 850, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(851, 851, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(852, 852, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(853, 853, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(854, 854, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(855, 855, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(856, 856, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(857, 857, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(858, 858, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(859, 859, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(860, 860, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(861, 861, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(862, 862, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(863, 863, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(864, 864, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(865, 865, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(866, 866, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(867, 867, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(868, 868, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(869, 869, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(870, 870, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(871, 871, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(872, 872, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(873, 873, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(874, 874, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(875, 875, 11, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(876, 876, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(877, 877, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(878, 878, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(879, 879, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(880, 880, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(881, 881, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(882, 882, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(883, 883, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(884, 884, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(885, 885, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(886, 886, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(887, 887, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(888, 888, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(889, 889, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(890, 890, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(891, 891, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(892, 892, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(893, 893, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(894, 894, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(895, 895, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(896, 896, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(897, 897, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(898, 898, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(899, 899, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(900, 900, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(901, 901, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(902, 902, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(903, 903, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(904, 904, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(905, 905, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(906, 906, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(907, 907, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(908, 908, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(909, 909, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(910, 910, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(911, 911, 12, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(912, 912, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(913, 913, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(914, 914, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(915, 915, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(916, 916, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(917, 917, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(918, 918, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(919, 919, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(920, 920, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(921, 921, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(922, 922, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(923, 923, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(924, 924, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(925, 925, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(926, 926, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(927, 927, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(928, 928, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(929, 929, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(930, 930, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(931, 931, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(932, 932, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(933, 933, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(934, 934, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(935, 935, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(936, 936, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(937, 937, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(938, 938, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(939, 939, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(940, 940, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(941, 941, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(942, 942, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(943, 943, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(944, 944, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(945, 945, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(946, 946, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(947, 947, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(948, 948, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(949, 949, 4, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(950, 950, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(951, 951, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(952, 952, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(953, 953, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(954, 954, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(955, 955, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(956, 956, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(957, 957, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(958, 958, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(959, 959, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(960, 960, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(961, 961, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(962, 962, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(963, 963, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(964, 964, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(965, 965, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(966, 966, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(967, 967, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(968, 968, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(969, 969, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(970, 970, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(971, 971, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(972, 972, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(973, 973, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(974, 974, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(975, 975, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(976, 976, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(977, 977, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(978, 978, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(979, 979, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(980, 980, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(981, 981, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(982, 982, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(983, 983, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(984, 984, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(985, 985, 13, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(986, 986, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(987, 987, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(988, 988, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(989, 989, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(990, 990, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(991, 991, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(992, 992, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(993, 993, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(994, 994, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(995, 995, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(996, 996, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(997, 997, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(998, 998, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(999, 999, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1000, 1000, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1001, 1001, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1002, 1002, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1003, 1003, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1004, 1004, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1005, 1005, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1006, 1006, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1007, 1007, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1008, 1008, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1009, 1009, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1010, 1010, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1011, 1011, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1012, 1012, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1013, 1013, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1014, 1014, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1015, 1015, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1016, 1016, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1017, 1017, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1018, 1018, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1019, 1019, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1020, 1020, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1021, 1021, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1022, 1022, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1023, 1023, 14, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1024, 1024, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1025, 1025, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1026, 1026, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1027, 1027, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1028, 1028, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1029, 1029, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1030, 1030, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1031, 1031, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1032, 1032, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1033, 1033, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1034, 1034, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1035, 1035, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1036, 1036, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1037, 1037, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1038, 1038, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1039, 1039, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1040, 1040, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1041, 1041, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1042, 1042, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1043, 1043, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1044, 1044, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1045, 1045, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1046, 1046, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1047, 1047, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1048, 1048, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1049, 1049, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1050, 1050, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1051, 1051, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1052, 1052, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1053, 1053, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1054, 1054, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1055, 1055, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1056, 1056, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1057, 1057, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1058, 1058, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1059, 1059, 5, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1060, 1060, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1061, 1061, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1062, 1062, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1063, 1063, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1064, 1064, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1065, 1065, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1066, 1066, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1067, 1067, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1068, 1068, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1069, 1069, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1070, 1070, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1071, 1071, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1072, 1072, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1073, 1073, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1074, 1074, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1075, 1075, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1076, 1076, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1077, 1077, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1078, 1078, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1079, 1079, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1080, 1080, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1081, 1081, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1082, 1082, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1083, 1083, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1084, 1084, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1085, 1085, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1086, 1086, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1087, 1087, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1088, 1088, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1089, 1089, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1090, 1090, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1091, 1091, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1092, 1092, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1093, 1093, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1094, 1094, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1095, 1095, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1096, 1096, 15, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1097, 1097, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1098, 1098, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1099, 1099, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1100, 1100, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1101, 1101, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1102, 1102, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1103, 1103, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1104, 1104, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1105, 1105, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1106, 1106, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1107, 1107, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1108, 1108, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1109, 1109, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1110, 1110, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1111, 1111, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1112, 1112, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1113, 1113, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1114, 1114, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1115, 1115, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1116, 1116, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1117, 1117, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1118, 1118, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1119, 1119, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1120, 1120, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1121, 1121, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1122, 1122, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1123, 1123, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1124, 1124, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1125, 1125, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1126, 1126, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1127, 1127, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1128, 1128, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1129, 1129, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1130, 1130, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1131, 1131, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1132, 1132, 16, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1133, 1133, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1134, 1134, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1135, 1135, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1136, 1136, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1137, 1137, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1138, 1138, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1139, 1139, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1140, 1140, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1141, 1141, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1142, 1142, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1143, 1143, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1144, 1144, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1145, 1145, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1146, 1146, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1147, 1147, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1148, 1148, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1149, 1149, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1150, 1150, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1151, 1151, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1152, 1152, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1153, 1153, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1154, 1154, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1155, 1155, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1156, 1156, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1157, 1157, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1158, 1158, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1159, 1159, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1160, 1160, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1161, 1161, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1162, 1162, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1163, 1163, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1164, 1164, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1165, 1165, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1166, 1166, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1167, 1167, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1168, 1168, 6, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1169, 1169, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1170, 1170, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1171, 1171, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1172, 1172, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1173, 1173, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1174, 1174, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1175, 1175, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1176, 1176, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1177, 1177, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1178, 1178, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1179, 1179, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1180, 1180, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1181, 1181, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1182, 1182, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1183, 1183, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1184, 1184, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1185, 1185, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1186, 1186, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1187, 1187, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1188, 1188, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1189, 1189, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1190, 1190, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1191, 1191, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1192, 1192, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1193, 1193, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1194, 1194, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1195, 1195, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1196, 1196, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1197, 1197, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1198, 1198, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1199, 1199, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1200, 1200, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1201, 1201, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1202, 1202, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1203, 1203, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1204, 1204, 17, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1205, 1205, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1206, 1206, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1207, 1207, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1208, 1208, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1209, 1209, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1210, 1210, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1211, 1211, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1212, 1212, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1213, 1213, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1214, 1214, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1216, 1216, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1217, 1217, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1218, 1218, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1219, 1219, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1220, 1220, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1221, 1221, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1222, 1222, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1223, 1223, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1224, 1224, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1225, 1225, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1226, 1226, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1227, 1227, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1228, 1228, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1229, 1229, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1230, 1230, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1231, 1231, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1232, 1232, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1233, 1233, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1234, 1234, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1235, 1235, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1236, 1236, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1237, 1237, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1238, 1238, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1239, 1239, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1240, 1240, 18, '2026-09-22 19:28:11', '2026-09-22 19:28:11'),
(1241, 1215, 18, '2026-09-23 01:12:32', '2026-09-23 01:12:32');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_tahun_ajaran`
--

CREATE TABLE `tbl_tahun_ajaran` (
  `idthnajaran` bigint(20) UNSIGNED NOT NULL,
  `thnajaran` varchar(50) NOT NULL,
  `tglmulai` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_tahun_ajaran`
--

INSERT INTO `tbl_tahun_ajaran` (`idthnajaran`, `thnajaran`, `tglmulai`, `created_at`, `updated_at`) VALUES
(1, '2025/2026', '2025-07-14', '2026-09-09 19:10:52', '2026-09-09 19:10:52');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id_user` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(191) NOT NULL,
  `nama_user` varchar(150) NOT NULL,
  `role` enum('admin_web','pustakawan') NOT NULL DEFAULT 'pustakawan',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tbl_users`
--

INSERT INTO `tbl_users` (`id_user`, `username`, `password`, `nama_user`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2y$12$z8.h6GowPK47ltU828pDgOQNzCLpQXBA9K1ehv9tYzu/T4XgwqylW', 'Administrator SIPERPUS', 'admin_web', NULL, '2026-09-09 19:10:52', '2026-09-09 19:10:52'),
(2, 'pustakawan', '$2y$12$stqCZDa8Ns7Pygg3PeyeXuk4BkjHEabxRXpu1Lm0AYHv.cv/Hc9uO', 'Hj. Siti Aminah, S.Pd.I', 'pustakawan', NULL, '2026-09-09 19:10:52', '2026-09-09 19:10:52');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `tbl_berita`
--
ALTER TABLE `tbl_berita`
  ADD PRIMARY KEY (`id_berita`),
  ADD UNIQUE KEY `tbl_berita_slug_unique` (`slug`);

--
-- Indeks untuk tabel `tbl_buku`
--
ALTER TABLE `tbl_buku`
  ADD PRIMARY KEY (`idbuku`),
  ADD UNIQUE KEY `tbl_buku_isbn_unique` (`isbn`);

--
-- Indeks untuk tabel `tbl_buku_detail`
--
ALTER TABLE `tbl_buku_detail`
  ADD PRIMARY KEY (`idbukudetail`),
  ADD UNIQUE KEY `tbl_buku_detail_kodebukudetail_unique` (`kodebukudetail`),
  ADD KEY `tbl_buku_detail_idbuku_foreign` (`idbuku`);

--
-- Indeks untuk tabel `tbl_guru`
--
ALTER TABLE `tbl_guru`
  ADD PRIMARY KEY (`idguru`),
  ADD UNIQUE KEY `tbl_guru_nip_unique` (`nip`);

--
-- Indeks untuk tabel `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  ADD PRIMARY KEY (`idkelas`);

--
-- Indeks untuk tabel `tbl_kelas_detail`
--
ALTER TABLE `tbl_kelas_detail`
  ADD PRIMARY KEY (`idkelasdetail`),
  ADD KEY `tbl_kelas_detail_idkelas_foreign` (`idkelas`),
  ADD KEY `tbl_kelas_detail_idguru_foreign` (`idguru`),
  ADD KEY `tbl_kelas_detail_idthahunajaran_foreign` (`idthahunajaran`);

--
-- Indeks untuk tabel `tbl_kunjungan`
--
ALTER TABLE `tbl_kunjungan`
  ADD PRIMARY KEY (`id_kunjungan`),
  ADD KEY `tbl_kunjungan_idsiswa_foreign` (`idsiswa`),
  ADD KEY `tbl_kunjungan_idpetugas_foreign` (`idpetugas`),
  ADD KEY `tbl_kunjungan_waktu_kunjung_index` (`waktu_kunjung`);

--
-- Indeks untuk tabel `tbl_pinjam`
--
ALTER TABLE `tbl_pinjam`
  ADD PRIMARY KEY (`idpinjam`),
  ADD KEY `tbl_pinjam_idsiswa_foreign` (`idsiswa`),
  ADD KEY `tbl_pinjam_idpetugas_foreign` (`idpetugas`);

--
-- Indeks untuk tabel `tbl_pinjam_detail`
--
ALTER TABLE `tbl_pinjam_detail`
  ADD PRIMARY KEY (`idpinjamdetail`),
  ADD KEY `tbl_pinjam_detail_idpinjam_foreign` (`idpinjam`),
  ADD KEY `tbl_pinjam_detail_idbukudetail_foreign` (`idbukudetail`);

--
-- Indeks untuk tabel `tbl_siswa`
--
ALTER TABLE `tbl_siswa`
  ADD PRIMARY KEY (`idsiswa`),
  ADD UNIQUE KEY `tbl_siswa_nis_unique` (`nis`);

--
-- Indeks untuk tabel `tbl_siswa_kelas`
--
ALTER TABLE `tbl_siswa_kelas`
  ADD PRIMARY KEY (`idsiswakelas`),
  ADD KEY `tbl_siswa_kelas_idsiswa_foreign` (`idsiswa`),
  ADD KEY `tbl_siswa_kelas_idkelasdetail_foreign` (`idkelasdetail`);

--
-- Indeks untuk tabel `tbl_tahun_ajaran`
--
ALTER TABLE `tbl_tahun_ajaran`
  ADD PRIMARY KEY (`idthnajaran`);

--
-- Indeks untuk tabel `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `tbl_users_username_unique` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `tbl_berita`
--
ALTER TABLE `tbl_berita`
  MODIFY `id_berita` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `tbl_buku`
--
ALTER TABLE `tbl_buku`
  MODIFY `idbuku` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `tbl_buku_detail`
--
ALTER TABLE `tbl_buku_detail`
  MODIFY `idbukudetail` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT untuk tabel `tbl_guru`
--
ALTER TABLE `tbl_guru`
  MODIFY `idguru` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT untuk tabel `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  MODIFY `idkelas` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `tbl_kelas_detail`
--
ALTER TABLE `tbl_kelas_detail`
  MODIFY `idkelasdetail` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT untuk tabel `tbl_kunjungan`
--
ALTER TABLE `tbl_kunjungan`
  MODIFY `id_kunjungan` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_pinjam`
--
ALTER TABLE `tbl_pinjam`
  MODIFY `idpinjam` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tbl_pinjam_detail`
--
ALTER TABLE `tbl_pinjam_detail`
  MODIFY `idpinjamdetail` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_siswa`
--
ALTER TABLE `tbl_siswa`
  MODIFY `idsiswa` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1241;

--
-- AUTO_INCREMENT untuk tabel `tbl_siswa_kelas`
--
ALTER TABLE `tbl_siswa_kelas`
  MODIFY `idsiswakelas` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1242;

--
-- AUTO_INCREMENT untuk tabel `tbl_tahun_ajaran`
--
ALTER TABLE `tbl_tahun_ajaran`
  MODIFY `idthnajaran` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `id_user` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tbl_buku_detail`
--
ALTER TABLE `tbl_buku_detail`
  ADD CONSTRAINT `tbl_buku_detail_idbuku_foreign` FOREIGN KEY (`idbuku`) REFERENCES `tbl_buku` (`idbuku`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_kelas_detail`
--
ALTER TABLE `tbl_kelas_detail`
  ADD CONSTRAINT `tbl_kelas_detail_idguru_foreign` FOREIGN KEY (`idguru`) REFERENCES `tbl_guru` (`idguru`) ON DELETE CASCADE,
  ADD CONSTRAINT `tbl_kelas_detail_idkelas_foreign` FOREIGN KEY (`idkelas`) REFERENCES `tbl_kelas` (`idkelas`) ON DELETE CASCADE,
  ADD CONSTRAINT `tbl_kelas_detail_idthahunajaran_foreign` FOREIGN KEY (`idthahunajaran`) REFERENCES `tbl_tahun_ajaran` (`idthnajaran`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_kunjungan`
--
ALTER TABLE `tbl_kunjungan`
  ADD CONSTRAINT `tbl_kunjungan_idpetugas_foreign` FOREIGN KEY (`idpetugas`) REFERENCES `tbl_users` (`id_user`) ON DELETE SET NULL,
  ADD CONSTRAINT `tbl_kunjungan_idsiswa_foreign` FOREIGN KEY (`idsiswa`) REFERENCES `tbl_siswa` (`idsiswa`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_pinjam`
--
ALTER TABLE `tbl_pinjam`
  ADD CONSTRAINT `tbl_pinjam_idpetugas_foreign` FOREIGN KEY (`idpetugas`) REFERENCES `tbl_users` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `tbl_pinjam_idsiswa_foreign` FOREIGN KEY (`idsiswa`) REFERENCES `tbl_siswa` (`idsiswa`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_pinjam_detail`
--
ALTER TABLE `tbl_pinjam_detail`
  ADD CONSTRAINT `tbl_pinjam_detail_idbukudetail_foreign` FOREIGN KEY (`idbukudetail`) REFERENCES `tbl_buku_detail` (`idbukudetail`) ON DELETE CASCADE,
  ADD CONSTRAINT `tbl_pinjam_detail_idpinjam_foreign` FOREIGN KEY (`idpinjam`) REFERENCES `tbl_pinjam` (`idpinjam`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_siswa_kelas`
--
ALTER TABLE `tbl_siswa_kelas`
  ADD CONSTRAINT `tbl_siswa_kelas_idkelasdetail_foreign` FOREIGN KEY (`idkelasdetail`) REFERENCES `tbl_kelas_detail` (`idkelasdetail`) ON DELETE CASCADE,
  ADD CONSTRAINT `tbl_siswa_kelas_idsiswa_foreign` FOREIGN KEY (`idsiswa`) REFERENCES `tbl_siswa` (`idsiswa`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
