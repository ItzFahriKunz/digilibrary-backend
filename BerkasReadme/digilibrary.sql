-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: digilibrary
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL,
  `uploaded_by` bigint(20) unsigned DEFAULT NULL,
  `judul` varchar(255) NOT NULL,
  `slug` varchar(280) NOT NULL,
  `penulis` varchar(150) NOT NULL,
  `penerbit` varchar(150) NOT NULL DEFAULT 'Pusat Perbukuan Kemendikdasmen',
  `jenjang` varchar(100) NOT NULL,
  `tingkat_kelas` tinyint(3) unsigned DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `cover_path` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `total_halaman` smallint(5) unsigned NOT NULL DEFAULT 0,
  `rating` decimal(2,1) NOT NULL DEFAULT 5.0,
  `total_dibaca` int(10) unsigned NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `books_slug_unique` (`slug`),
  KEY `books_category_id_tingkat_kelas_index` (`category_id`,`tingkat_kelas`),
  KEY `books_is_active_index` (`is_active`),
  KEY `books_uploaded_by_foreign` (`uploaded_by`),
  CONSTRAINT `books_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `books_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `slug` varchar(120) NOT NULL,
  `tipe` enum('pelajaran','bacaan') NOT NULL DEFAULT 'pelajaran',
  `icon` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'IPAS (Ilmu Pengetahuan Alam dan Sosial)','ipas','pelajaran','globe','2026-09-26 22:56:24','2026-09-26 22:56:24'),(2,'Bahasa Indonesia','bahasa-indonesia','pelajaran','book','2026-09-26 22:56:24','2026-09-26 22:56:24'),(3,'Matematika','matematika','pelajaran','calculator','2026-09-26 22:56:24','2026-09-26 22:56:24'),(4,'Pendidikan Pancasila','pendidikan-pancasila','pelajaran','flag','2026-09-26 22:56:24','2026-09-26 22:56:24'),(5,'Bahasa Inggris (My Next Words)','bahasa-inggris','pelajaran','globe','2026-09-26 22:56:24','2026-09-26 22:56:24'),(6,'Seni Rupa & Prakarya','seni-rupa','pelajaran','palette','2026-09-26 22:56:24','2026-09-26 22:56:24'),(7,'PJOK (Penjasorkes)','pjok','pelajaran','activity','2026-09-26 22:56:24','2026-09-26 22:56:24'),(8,'Cerita & Fabel Bergambar','cerita-fabel-bergambar','bacaan','smile','2026-09-26 22:56:24','2026-09-26 22:56:24'),(9,'Penguatan Karakter Anak','penguatan-karakter-anak','bacaan','heart','2026-09-26 22:56:24','2026-09-26 22:56:24'),(10,'Literasi Budaya & Cerita Rakyat','literasi-budaya-cerita-rakyat','bacaan','bookmark','2026-09-26 22:56:24','2026-09-26 22:56:24'),(11,'Literasi Sains & Lingkungan','literasi-sains-lingkungan','bacaan','sun','2026-09-26 22:56:24','2026-09-26 22:56:24');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kelas`
--

DROP TABLE IF EXISTS `kelas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kelas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tingkat` tinyint(3) unsigned NOT NULL,
  `nama_rombel` varchar(20) NOT NULL,
  `tahun_ajaran_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kelas_tingkat_nama_rombel_tahun_ajaran_id_unique` (`tingkat`,`nama_rombel`,`tahun_ajaran_id`),
  KEY `kelas_tahun_ajaran_id_foreign` (`tahun_ajaran_id`),
  CONSTRAINT `kelas_tahun_ajaran_id_foreign` FOREIGN KEY (`tahun_ajaran_id`) REFERENCES `tahun_ajaran` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kelas`
--

LOCK TABLES `kelas` WRITE;
/*!40000 ALTER TABLE `kelas` DISABLE KEYS */;
INSERT INTO `kelas` VALUES (1,1,'1A',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(2,1,'1B',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(3,1,'1C',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(4,1,'1D',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(5,2,'2A',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(6,2,'2B',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(7,2,'2C',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(8,2,'2D',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(9,3,'3A',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(10,3,'3B',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(11,3,'3C',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(12,3,'3D',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(13,4,'4A',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(14,4,'4B',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(15,4,'4C',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(16,4,'4D',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(17,5,'5A',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(18,5,'5B',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(19,5,'5C',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(20,5,'5D',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(21,6,'6A',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(22,6,'6B',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(23,6,'6C',1,'2026-09-26 22:54:46','2026-09-26 22:54:46'),(24,6,'6D',1,'2026-09-26 22:54:46','2026-09-26 22:54:46');
/*!40000 ALTER TABLE `kelas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_08_20_060722_create_personal_access_tokens_table',1),(5,'2026_08_27_000001_add_firebase_fields_to_users_table',1),(6,'2026_09_01_000001_add_role_to_users_table',1),(7,'2026_09_01_000002_create_categories_table',1),(8,'2026_09_01_000003_create_books_table',1),(9,'2026_09_01_000004_create_reading_logs_table',1),(10,'2026_09_01_000005_add_kelas_to_users_table',1),(11,'2026_09_27_055208_create_academic_structure_tables',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',6,'auth-token','53404ecdbc14b7d555a11d4e0ca454df90ea701eab1e672093648f214018cf8f','[\"*\"]','2026-09-26 23:06:23',NULL,'2026-09-26 23:06:11','2026-09-26 23:06:23');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reading_logs`
--

DROP TABLE IF EXISTS `reading_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reading_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `book_id` bigint(20) unsigned NOT NULL,
  `platform` enum('web','mobile') NOT NULL DEFAULT 'web',
  `halaman_terakhir` smallint(5) unsigned NOT NULL DEFAULT 1,
  `durasi_detik` int(10) unsigned NOT NULL DEFAULT 0,
  `read_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reading_logs_book_id_read_at_index` (`book_id`,`read_at`),
  KEY `reading_logs_user_id_read_at_index` (`user_id`,`read_at`),
  CONSTRAINT `reading_logs_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reading_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reading_logs`
--

LOCK TABLES `reading_logs` WRITE;
/*!40000 ALTER TABLE `reading_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `reading_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `siswa_kelas`
--

DROP TABLE IF EXISTS `siswa_kelas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `siswa_kelas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `kelas_id` bigint(20) unsigned NOT NULL,
  `tahun_ajaran_id` bigint(20) unsigned NOT NULL,
  `status` enum('aktif','naik_kelas','lulus','pindah') NOT NULL DEFAULT 'aktif',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `siswa_kelas_user_id_tahun_ajaran_id_unique` (`user_id`,`tahun_ajaran_id`),
  KEY `siswa_kelas_kelas_id_foreign` (`kelas_id`),
  KEY `siswa_kelas_tahun_ajaran_id_foreign` (`tahun_ajaran_id`),
  CONSTRAINT `siswa_kelas_kelas_id_foreign` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `siswa_kelas_tahun_ajaran_id_foreign` FOREIGN KEY (`tahun_ajaran_id`) REFERENCES `tahun_ajaran` (`id`) ON DELETE CASCADE,
  CONSTRAINT `siswa_kelas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `siswa_kelas`
--

LOCK TABLES `siswa_kelas` WRITE;
/*!40000 ALTER TABLE `siswa_kelas` DISABLE KEYS */;
INSERT INTO `siswa_kelas` VALUES (1,3,14,1,'aktif','2026-09-26 22:56:25','2026-09-26 22:56:25'),(2,4,14,1,'aktif','2026-09-26 22:56:25','2026-09-26 22:56:25'),(3,5,14,1,'aktif','2026-09-26 22:56:25','2026-09-26 22:56:25');
/*!40000 ALTER TABLE `siswa_kelas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tahun_ajaran`
--

DROP TABLE IF EXISTS `tahun_ajaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tahun_ajaran` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(50) NOT NULL,
  `tanggal_mulai` date DEFAULT NULL,
  `tanggal_selesai` date DEFAULT NULL,
  `status` enum('aktif','selesai') NOT NULL DEFAULT 'aktif',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tahun_ajaran`
--

LOCK TABLES `tahun_ajaran` WRITE;
/*!40000 ALTER TABLE `tahun_ajaran` DISABLE KEYS */;
INSERT INTO `tahun_ajaran` VALUES (1,'2025/2026','2025-07-15','2026-06-25','aktif','2026-09-26 22:54:46','2026-09-26 22:54:46');
/*!40000 ALTER TABLE `tahun_ajaran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firebase_uid` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `role` enum('admin','siswa','guru') NOT NULL DEFAULT 'siswa',
  `nis` varchar(30) DEFAULT NULL,
  `nip` varchar(30) DEFAULT NULL,
  `kelas` varchar(50) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_firebase_uid_unique` (`firebase_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,'Admin Perpustakaan','admin@digilibrary.sch.id',NULL,'admin',NULL,'198001012005011001',NULL,NULL,'$2y$12$kq61M5j7yGg5gepVND7/aepfJwT9XCuQ0qowd0GFZaEPEAJRw6pli',NULL,'2026-09-26 22:56:23','2026-09-26 22:56:23'),(2,NULL,'Ibu Sari, S.Pd.','guru@digilibrary.sch.id',NULL,'guru',NULL,'198505122010012003','Kelas 4B',NULL,'$2y$12$yYEWClMNAl4mTHwBFhfj6.4PtokCM93M7xGl7BxjMd2qBzh1xGjKS',NULL,'2026-09-26 22:56:24','2026-09-26 22:56:24'),(3,NULL,'Budi Santoso','siswa@digilibrary.sch.id',NULL,'siswa','20250001',NULL,'Kelas 4B',NULL,'$2y$12$0dk3j/ez35VPFY2KmSNRyeIV/hzn256BjIvkqOoUKTUZtOfEit0EK',NULL,'2026-09-26 22:56:24','2026-09-26 22:56:24'),(4,NULL,'Siti Rahma','siti@digilibrary.sch.id',NULL,'siswa','20250002',NULL,'Kelas 4B',NULL,'$2y$12$J46NQHunpLXLOo/T1UQz.OCtxAYzV1zaqozKWelMtlXYq3YvbmpIG',NULL,'2026-09-26 22:56:24','2026-09-26 22:56:24'),(5,NULL,'Edo Pratama','edo@digilibrary.sch.id',NULL,'siswa','20250003',NULL,'Kelas 4B',NULL,'$2y$12$THBYVhjVVL82u5vMSrsQievObS4jAc7dotO1IpRaz6MpFBYmtMSgW',NULL,'2026-09-26 22:56:24','2026-09-26 22:56:24'),(6,'6cyzKdzxGrd14HpInYJ22I5I0eS2','Fieangaming','fieangamingtetew@gmail.com','https://lh3.googleusercontent.com/a/ACg8ocLyDiyuvCO1HxcZ9QqEnTn_w8fMtxCtnsuGtiQuoq-pABxRNz5wpw=s96-c','siswa',NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-26 23:06:11','2026-09-26 23:06:11');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wali_kelas`
--

DROP TABLE IF EXISTS `wali_kelas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wali_kelas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `kelas_id` bigint(20) unsigned NOT NULL,
  `tahun_ajaran_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wali_kelas_kelas_id_tahun_ajaran_id_unique` (`kelas_id`,`tahun_ajaran_id`),
  KEY `wali_kelas_user_id_foreign` (`user_id`),
  KEY `wali_kelas_tahun_ajaran_id_foreign` (`tahun_ajaran_id`),
  CONSTRAINT `wali_kelas_kelas_id_foreign` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wali_kelas_tahun_ajaran_id_foreign` FOREIGN KEY (`tahun_ajaran_id`) REFERENCES `tahun_ajaran` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wali_kelas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wali_kelas`
--

LOCK TABLES `wali_kelas` WRITE;
/*!40000 ALTER TABLE `wali_kelas` DISABLE KEYS */;
INSERT INTO `wali_kelas` VALUES (1,2,14,1,'2026-09-26 22:56:25','2026-09-26 22:56:25');
/*!40000 ALTER TABLE `wali_kelas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-27 13:08:36
