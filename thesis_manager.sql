-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- مضيف: localhost:3306
-- وقت الجيل: 01 يناير 2026 الساعة 18:23
-- إصدار الخادم: 8.4.3
-- نسخة PHP: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- قاعدة بيانات: `thesis_manager`
--

-- --------------------------------------------------------

--
-- بنية الجدول `activity_log`
--

CREATE TABLE `activity_log` (
  `id` bigint UNSIGNED NOT NULL,
  `log_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` bigint UNSIGNED DEFAULT NULL,
  `causer_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` bigint UNSIGNED DEFAULT NULL,
  `properties` json DEFAULT NULL,
  `batch_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `activity_log`
--

INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(24, 'defenses', 'ID#1 has been created by Developer [\"Developer\"]', 'App\\Models\\Defense', 'created', 1, 'App\\Models\\User', 2, '[]', NULL, '2025-11-07 07:48:19', '2025-11-07 07:48:19'),
(25, 'projects', 'ID#2 has been created by Developer [\"Developer\"]', 'App\\Models\\Project', 'created', 2, 'App\\Models\\User', 2, '[]', NULL, '2025-11-07 21:52:38', '2025-11-07 21:52:38'),
(26, 'projects', 'ID#2 has been updated by Developer [\"Developer\"]', 'App\\Models\\Project', 'updated', 2, 'App\\Models\\User', 2, '[]', NULL, '2025-11-07 21:52:52', '2025-11-07 21:52:52'),
(27, 'project_assignments', 'ID#7 has been created by Developer [\"Developer\"]', 'App\\Models\\ProjectAssignment', 'created', 7, 'App\\Models\\User', 2, '[]', NULL, '2025-11-07 21:53:59', '2025-11-07 21:53:59'),
(28, 'project_assignments', 'ID#8 has been created by Developer [\"Developer\"]', 'App\\Models\\ProjectAssignment', 'created', 8, 'App\\Models\\User', 2, '[]', NULL, '2025-11-07 21:53:59', '2025-11-07 21:53:59'),
(29, 'defenses', 'ID#1 has been updated by Developer [\"Developer\"]', 'App\\Models\\Defense', 'updated', 1, 'App\\Models\\User', 2, '[]', NULL, '2025-11-07 22:02:33', '2025-11-07 22:02:33'),
(30, 'defenses', 'ID#1 has been updated by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\Defense', 'updated', 1, 'App\\Models\\User', 75, '[]', NULL, '2025-11-07 22:45:46', '2025-11-07 22:45:46'),
(31, 'defenses', 'ID#1 has been updated by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\Defense', 'updated', 1, 'App\\Models\\User', 75, '[]', NULL, '2025-11-07 22:45:50', '2025-11-07 22:45:50'),
(32, 'projects', 'ID#3 has been created by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\Project', 'created', 3, 'App\\Models\\User', 75, '[]', NULL, '2025-11-07 23:01:31', '2025-11-07 23:01:31'),
(36, 'project_requests', 'ID#1 has been updated by Developer [\"Developer\"]', 'App\\Models\\ProjectRequest', 'updated', 1, 'App\\Models\\User', 2, '[]', NULL, '2025-11-08 20:05:44', '2025-11-08 20:05:44'),
(37, 'project_requests', 'ID#1 has been updated by Developer [\"Developer\"]', 'App\\Models\\ProjectRequest', 'updated', 1, 'App\\Models\\User', 2, '[]', NULL, '2025-11-08 20:11:04', '2025-11-08 20:11:04'),
(42, 'project_requests', 'ID#1 has been updated by Developer [\"Developer\"]', 'App\\Models\\ProjectRequest', 'updated', 1, 'App\\Models\\User', 2, '[]', NULL, '2025-11-08 20:37:48', '2025-11-08 20:37:48'),
(43, 'project_assignments', 'ID#15 has been created by Developer [\"Developer\"]', 'App\\Models\\ProjectAssignment', 'created', 15, 'App\\Models\\User', 2, '[]', NULL, '2025-11-08 20:37:48', '2025-11-08 20:37:48'),
(45, 'project_submissions', 'ID#1 has been updated by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\ProjectSubmission', 'updated', 1, 'App\\Models\\User', 75, '[]', NULL, '2025-11-09 19:17:08', '2025-11-09 19:17:08'),
(46, 'project_submissions', 'ID#1 has been updated by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\ProjectSubmission', 'updated', 1, 'App\\Models\\User', 75, '[]', NULL, '2025-11-10 04:52:23', '2025-11-10 04:52:23'),
(47, 'project_submissions', 'ID#1 has been updated by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\ProjectSubmission', 'updated', 1, 'App\\Models\\User', 75, '[]', NULL, '2025-11-10 04:54:51', '2025-11-10 04:54:51'),
(48, 'project_submissions', 'ID#1 has been updated by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\ProjectSubmission', 'updated', 1, 'App\\Models\\User', 75, '[]', NULL, '2025-11-10 04:55:09', '2025-11-10 04:55:09'),
(49, 'project_submissions', 'ID#1 has been updated by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\ProjectSubmission', 'updated', 1, 'App\\Models\\User', 75, '[]', NULL, '2025-11-12 10:14:27', '2025-11-12 10:14:27'),
(50, 'project_submissions', 'ID#1 has been updated by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\ProjectSubmission', 'updated', 1, 'App\\Models\\User', 75, '[]', NULL, '2025-11-12 10:16:57', '2025-11-12 10:16:57'),
(54, 'project_assignments', 'ID#16 has been created by Developer [\"Developer\"]', 'App\\Models\\ProjectAssignment', 'created', 16, 'App\\Models\\User', 2, '[]', NULL, '2025-11-13 06:35:37', '2025-11-13 06:35:37'),
(55, 'project_assignments', 'ID#17 has been created by Developer [\"Developer\"]', 'App\\Models\\ProjectAssignment', 'created', 17, 'App\\Models\\User', 2, '[]', NULL, '2025-11-13 06:55:52', '2025-11-13 06:55:52'),
(56, 'projects', 'ID#1 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Project', 'updated', 1, 'App\\Models\\User', 1, '[]', NULL, '2025-11-13 13:05:27', '2025-11-13 13:05:27'),
(57, 'projects', 'ID#1 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Project', 'updated', 1, 'App\\Models\\User', 1, '[]', NULL, '2025-11-13 13:05:41', '2025-11-13 13:05:41'),
(58, 'projects', 'ID#3 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Project', 'updated', 3, 'App\\Models\\User', 1, '[]', NULL, '2025-11-13 13:05:48', '2025-11-13 13:05:48'),
(59, 'projects', 'ID#3 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Project', 'updated', 3, 'App\\Models\\User', 1, '[]', NULL, '2025-11-13 13:05:51', '2025-11-13 13:05:51'),
(60, 'projects', 'ID#4 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\Project', 'created', 4, 'App\\Models\\User', 1, '[]', NULL, '2025-11-13 13:14:27', '2025-11-13 13:14:27'),
(61, 'projects', 'ID#4 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Project', 'updated', 4, 'App\\Models\\User', 1, '[]', NULL, '2025-11-13 13:14:32', '2025-11-13 13:14:32'),
(62, 'project_requests', 'ID#2 has been created by Miss Audie Zieme [\"student\"]', 'App\\Models\\ProjectRequest', 'created', 2, 'App\\Models\\User', 6, '[]', NULL, '2025-11-13 13:15:03', '2025-11-13 13:15:03'),
(63, 'project_requests', 'ID#2 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\ProjectRequest', 'updated', 2, 'App\\Models\\User', 1, '[]', NULL, '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
(64, 'project_assignments', 'ID#18 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 18, 'App\\Models\\User', 1, '[]', NULL, '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
(65, 'project_assignments', 'ID#19 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 19, 'App\\Models\\User', 1, '[]', NULL, '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
(66, 'project_assignments', 'ID#20 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 20, 'App\\Models\\User', 1, '[]', NULL, '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
(67, 'project_assignments', 'ID#21 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 21, 'App\\Models\\User', 1, '[]', NULL, '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
(68, 'project_assignments', 'ID#22 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 22, 'App\\Models\\User', 1, '[]', NULL, '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
(69, 'project_submissions', 'ID#5 has been created by   Anzam Dip [\"student\"]', 'App\\Models\\ProjectSubmission', 'created', 5, 'App\\Models\\User', 3, '[]', NULL, '2025-11-13 13:19:30', '2025-11-13 13:19:30'),
(70, 'projects', 'ID#2 has been updated by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\Project', 'updated', 2, 'App\\Models\\User', 75, '[]', NULL, '2025-11-13 13:22:30', '2025-11-13 13:22:30'),
(71, 'defenses', 'ID#1 has been updated by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\Defense', 'updated', 1, 'App\\Models\\User', 75, '[]', NULL, '2025-11-13 13:26:38', '2025-11-13 13:26:38'),
(72, 'defenses', 'ID#1 has been updated by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\Defense', 'updated', 1, 'App\\Models\\User', 75, '[]', NULL, '2025-11-13 13:26:42', '2025-11-13 13:26:42'),
(73, 'defenses', 'ID#1 has been updated by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\Defense', 'updated', 1, 'App\\Models\\User', 75, '[]', NULL, '2025-11-13 13:26:45', '2025-11-13 13:26:45'),
(74, 'defenses', 'ID#1 has been updated by Jannatul Ferdous [\"supervisor\"]', 'App\\Models\\Defense', 'updated', 1, 'App\\Models\\User', 75, '[]', NULL, '2025-11-13 13:26:48', '2025-11-13 13:26:48'),
(75, 'projects', 'ID#3 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Project', 'updated', 3, 'App\\Models\\User', 1, '[]', NULL, '2025-12-14 19:46:58', '2025-12-14 19:46:58'),
(76, 'projects', 'ID#3 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Project', 'updated', 3, 'App\\Models\\User', 1, '[]', NULL, '2025-12-14 19:47:06', '2025-12-14 19:47:06'),
(77, 'projects', 'ID#3 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Project', 'updated', 3, 'App\\Models\\User', 1, '[]', NULL, '2025-12-14 21:44:22', '2025-12-14 21:44:22'),
(78, 'projects', 'ID#3 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Project', 'updated', 3, 'App\\Models\\User', 1, '[]', NULL, '2025-12-14 21:45:04', '2025-12-14 21:45:04'),
(79, 'projects', 'ID#3 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Project', 'updated', 3, 'App\\Models\\User', 1, '[]', NULL, '2025-12-14 21:54:41', '2025-12-14 21:54:41'),
(80, 'project_assignments', 'ID#23 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 23, 'App\\Models\\User', 1, '[]', NULL, '2025-12-14 22:14:49', '2025-12-14 22:14:49'),
(81, 'project_assignments', 'ID#24 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 24, 'App\\Models\\User', 1, '[]', NULL, '2025-12-18 00:51:25', '2025-12-18 00:51:25'),
(82, 'projects', 'ID#5 has been created by projectadmin [\"Project Admin\"]', 'App\\Models\\Project', 'created', 5, 'App\\Models\\User', 77, '[]', NULL, '2025-12-18 01:26:35', '2025-12-18 01:26:35'),
(83, 'project_requests', 'ID#3 has been created by Bayan Znika [\"student\"]', 'App\\Models\\ProjectRequest', 'created', 3, 'App\\Models\\User', 76, '[]', NULL, '2025-12-18 01:27:25', '2025-12-18 01:27:25'),
(84, 'project_requests', 'ID#3 has been updated by projectadmin [\"Project Admin\"]', 'App\\Models\\ProjectRequest', 'updated', 3, 'App\\Models\\User', 77, '[]', NULL, '2025-12-18 01:28:01', '2025-12-18 01:28:01'),
(85, 'project_assignments', 'ID#25 has been created by projectadmin [\"Project Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 25, 'App\\Models\\User', 77, '[]', NULL, '2025-12-18 01:28:01', '2025-12-18 01:28:01'),
(86, 'project_assignments', 'ID#26 has been created by projectadmin [\"Project Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 26, 'App\\Models\\User', 77, '[]', NULL, '2025-12-18 01:28:07', '2025-12-18 01:28:07'),
(87, 'project_assignments', 'ID#27 has been created by projectadmin [\"Project Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 27, 'App\\Models\\User', 77, '[]', NULL, '2025-12-18 01:28:07', '2025-12-18 01:28:07'),
(88, 'projects', 'ID#6 has been created by Casimer Sipes III [\"supervisor\"]', 'App\\Models\\Project', 'created', 6, 'App\\Models\\User', 54, '[]', NULL, '2025-12-18 19:11:52', '2025-12-18 19:11:52'),
(89, 'projects', 'ID#6 has been updated by projectadmin [\"Project Admin\"]', 'App\\Models\\Project', 'updated', 6, 'App\\Models\\User', 77, '[]', NULL, '2025-12-18 19:13:10', '2025-12-18 19:13:10'),
(90, 'defenses', 'ID#1 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Defense', 'updated', 1, 'App\\Models\\User', 1, '[]', NULL, '2025-12-28 23:47:21', '2025-12-28 23:47:21'),
(91, 'defenses', 'ID#1 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Defense', 'updated', 1, 'App\\Models\\User', 1, '[]', NULL, '2025-12-28 23:47:31', '2025-12-28 23:47:31'),
(92, 'defenses', 'ID#2 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\Defense', 'created', 2, 'App\\Models\\User', 1, '[]', NULL, '2025-12-28 23:48:40', '2025-12-28 23:48:40'),
(93, 'specializations', 'ID#6 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\Specialization', 'created', 6, 'App\\Models\\User', 1, '[]', NULL, '2025-12-31 23:55:08', '2025-12-31 23:55:08'),
(94, 'specializations', 'ID#6 has been deleted by Administrator [\"Super Admin\"]', 'App\\Models\\Specialization', 'deleted', 6, 'App\\Models\\User', 1, '[]', NULL, '2025-12-31 23:55:15', '2025-12-31 23:55:15'),
(95, 'specializations', 'ID#7 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\Specialization', 'created', 7, 'App\\Models\\User', 1, '[]', NULL, '2025-12-31 23:59:12', '2025-12-31 23:59:12'),
(96, 'specializations', 'ID#7 has been deleted by Administrator [\"Super Admin\"]', 'App\\Models\\Specialization', 'deleted', 7, 'App\\Models\\User', 1, '[]', NULL, '2025-12-31 23:59:18', '2025-12-31 23:59:18'),
(97, 'specializations', 'ID#8 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\Specialization', 'created', 8, 'App\\Models\\User', 1, '[]', NULL, '2026-01-01 00:02:06', '2026-01-01 00:02:06'),
(98, 'specializations', 'ID#8 has been deleted by Administrator [\"Super Admin\"]', 'App\\Models\\Specialization', 'deleted', 8, 'App\\Models\\User', 1, '[]', NULL, '2026-01-01 00:02:11', '2026-01-01 00:02:11');

-- --------------------------------------------------------

--
-- بنية الجدول `conversations`
--

CREATE TABLE `conversations` (
  `id` bigint UNSIGNED NOT NULL,
  `type` enum('direct','project_group','admin_support') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'project_group',
  `project_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_message_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `conversations`
--

INSERT INTO `conversations` (`id`, `type`, `project_id`, `name`, `last_message_at`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'project_group', 1, 'Real-Time Collaborative Code Editor - Chat', NULL, 54, '2025-11-12 20:24:01', '2025-11-12 20:24:01'),
(2, 'project_group', 2, 'IoT Network Intrusion Detection System - Chat', '2025-11-13 13:24:19', 75, '2025-11-12 20:24:48', '2025-11-13 13:24:19'),
(3, 'admin_support', NULL, 'Support Chat - Jannatul Ferdous', NULL, 75, '2025-11-13 07:10:26', '2025-11-13 07:10:26'),
(4, 'admin_support', NULL, 'Support Chat - Jannatul Ferdous', NULL, 75, '2025-11-13 07:10:29', '2025-11-13 07:10:29'),
(7, 'admin_support', NULL, 'Support Chat - Jannatul Ferdous', '2025-11-13 13:01:23', 75, '2025-11-13 13:01:06', '2025-11-13 13:01:23');

-- --------------------------------------------------------

--
-- بنية الجدول `conversation_participants`
--

CREATE TABLE `conversation_participants` (
  `id` bigint UNSIGNED NOT NULL,
  `conversation_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `role` enum('admin','supervisor','student','member','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `unread_count` int NOT NULL DEFAULT '0',
  `last_read_at` timestamp NULL DEFAULT NULL,
  `joined_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `conversation_participants`
--

INSERT INTO `conversation_participants` (`id`, `conversation_id`, `user_id`, `role`, `unread_count`, `last_read_at`, `joined_at`, `created_at`, `updated_at`) VALUES
(1, 1, 54, 'supervisor', 0, '2025-12-14 23:13:33', '2025-11-12 20:24:01', '2025-11-12 20:24:01', '2025-12-14 23:13:33'),
(2, 1, 55, 'supervisor', 0, NULL, '2025-11-12 20:24:01', '2025-11-12 20:24:01', '2025-11-12 20:24:01'),
(4, 1, 5, 'student', 0, NULL, '2025-11-12 20:24:01', '2025-11-12 20:24:01', '2025-11-12 20:24:01'),
(6, 2, 75, 'supervisor', 1, '2025-11-13 13:23:57', '2025-11-12 20:24:48', '2025-11-12 20:24:48', '2025-11-13 13:23:57'),
(8, 2, 4, 'student', 1, '2025-11-13 06:58:38', '2025-11-13 06:55:52', '2025-11-13 06:55:52', '2025-11-13 06:58:38'),
(13, 7, 75, 'user', 1, '2025-11-13 13:01:09', '2025-11-13 13:01:06', '2025-11-13 13:01:06', '2025-11-13 13:01:09'),
(14, 7, 1, 'admin', 0, '2025-12-14 18:47:34', '2025-11-13 13:01:06', '2025-11-13 13:01:06', '2025-12-14 18:47:34'),
(15, 1, 4, 'student', 0, NULL, '2025-12-14 22:14:49', '2025-12-14 22:14:49', '2025-12-14 22:14:49');

-- --------------------------------------------------------

--
-- بنية الجدول `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint UNSIGNED NOT NULL,
  `currency_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `thousand_separator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `decimal_separator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `currencies`
--

INSERT INTO `currencies` (`id`, `currency_name`, `code`, `symbol`, `thousand_separator`, `decimal_separator`, `exchange_rate`, `created_at`, `updated_at`) VALUES
(1, 'US Dollar', 'USD', '$', ',', '.', NULL, '2025-11-05 15:55:51', '2025-11-05 15:55:51');

-- --------------------------------------------------------

--
-- بنية الجدول `defenses`
--

CREATE TABLE `defenses` (
  `id` bigint UNSIGNED NOT NULL,
  `project_id` bigint UNSIGNED NOT NULL,
  `discussion_hall` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `discussion_date` datetime NOT NULL,
  `discussion_type` enum('proposal','seminar','final') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('scheduled','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'scheduled',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `defenses`
--

INSERT INTO `defenses` (`id`, `project_id`, `discussion_hall`, `discussion_date`, `discussion_type`, `status`, `notes`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'B-101', '2026-01-30 02:45:00', 'proposal', 'scheduled', '<p>This is to confirm that the final defense for the project, <strong>\"IoT Network Intrusion Detection System\"</strong>, has been scheduled.</p><p>Please review the following details:</p><ol><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Student(s):</strong> Alex Johnson</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Supervisor(s):</strong> Dr. Emily White</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Discussion Members:</strong> Dr. Ben Carter, Prof. Sarah Jenkins </li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Date:</strong> November 25, 2025 </li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Time:</strong> 2:00 PM </li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Location:</strong> Conference Hall B </li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Defense Type:</strong> Graduation 2 Final </li></ol><p>Please ensure all necessary materials are prepared and submitted prior to the scheduled time.</p>', 2, '2025-11-07 07:48:19', '2025-12-28 23:47:31'),
(2, 2, 'IT-01', '2026-01-31 21:18:00', 'final', 'scheduled', NULL, 1, '2025-12-28 23:48:40', '2025-12-28 23:48:40');

-- --------------------------------------------------------

--
-- بنية الجدول `defense_members`
--

CREATE TABLE `defense_members` (
  `id` bigint UNSIGNED NOT NULL,
  `defense_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `defense_members`
--

INSERT INTO `defense_members` (`id`, `defense_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 54, '2025-11-07 07:48:19', '2025-11-07 07:48:19'),
(3, 1, 75, '2025-11-07 22:02:33', '2025-11-07 22:02:33'),
(4, 2, 59, '2025-12-28 23:48:40', '2025-12-28 23:48:40'),
(5, 2, 58, '2025-12-28 23:48:40', '2025-12-28 23:48:40');

-- --------------------------------------------------------

--
-- بنية الجدول `departments`
--

CREATE TABLE `departments` (
  `id` bigint UNSIGNED NOT NULL,
  `short_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `departments`
--

INSERT INTO `departments` (`id`, `short_name`, `name`, `created_at`, `updated_at`) VALUES
(1, 'CSE', 'Computer Science & Engineering', '2025-11-05 21:08:40', '2025-11-05 21:08:40'),
(2, 'EEE', 'Electrical & Electronic Engineering', '2025-11-05 21:08:58', '2025-11-05 21:09:49'),
(3, 'SWE', 'Software Engineering', '2025-11-05 21:09:10', '2025-11-05 21:09:10'),
(4, 'TE', 'Textile Engineering', '2025-11-05 21:09:40', '2025-11-05 21:09:40'),
(5, 'ENG', 'Engineering', '2025-11-05 22:51:17', '2025-11-05 22:51:17');

-- --------------------------------------------------------

--
-- بنية الجدول `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `media`
--

CREATE TABLE `media` (
  `id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  `uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversions_disk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint UNSIGNED NOT NULL,
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `generated_conversions` json NOT NULL,
  `responsive_images` json NOT NULL,
  `order_column` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `media`
--

INSERT INTO `media` (`id`, `model_type`, `model_id`, `uuid`, `collection_name`, `name`, `file_name`, `mime_type`, `disk`, `conversions_disk`, `size`, `manipulations`, `custom_properties`, `generated_conversions`, `responsive_images`, `order_column`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\Setting', 1, '2ddaa807-4065-45bb-b99c-79667ecce39a', 'logo', 'app-logo', '690b7b12081c31762360082.png', 'image/png', 'public', 'public', 13064, '[]', '[]', '[]', '[]', 1, '2025-11-05 15:58:02', '2025-11-05 15:58:02'),
(2, 'App\\Models\\Setting', 1, '7b49c677-edd5-4e40-a117-c4b9505f1c7a', 'favicon', 'app-logo', '690b7b135ce6a1762360083.png', 'image/png', 'public', 'public', 13064, '[]', '[]', '[]', '[]', 2, '2025-11-05 15:58:03', '2025-11-05 15:58:03');

-- --------------------------------------------------------

--
-- بنية الجدول `messages`
--

CREATE TABLE `messages` (
  `id` bigint UNSIGNED NOT NULL,
  `conversation_id` bigint UNSIGNED NOT NULL,
  `sender_id` bigint UNSIGNED DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('text','file','system') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `messages`
--

INSERT INTO `messages` (`id`, `conversation_id`, `sender_id`, `message`, `type`, `read_at`, `created_at`, `updated_at`) VALUES
(27, 2, NULL, 'hi', 'text', NULL, '2025-11-13 05:27:30', '2025-11-13 05:27:30'),
(28, 2, 75, 'hello', 'text', NULL, '2025-11-13 05:27:47', '2025-11-13 05:27:47'),
(29, 2, NULL, 'how are you', 'text', NULL, '2025-11-13 05:31:08', '2025-11-13 05:31:08'),
(30, 2, NULL, 'all good?', 'text', NULL, '2025-11-13 05:36:32', '2025-11-13 05:36:32'),
(31, 2, 75, 'yes', 'text', NULL, '2025-11-13 05:36:43', '2025-11-13 05:36:43'),
(32, 2, NULL, 'nice', 'text', NULL, '2025-11-13 05:36:49', '2025-11-13 05:36:49'),
(33, 2, 75, 'dupe message', 'text', NULL, '2025-11-13 05:39:14', '2025-11-13 05:39:14'),
(34, 1, 1, 'Test broadcast message', 'text', NULL, '2025-11-13 05:42:33', '2025-11-13 05:42:33'),
(35, 2, 75, 'hi', 'text', NULL, '2025-11-13 05:45:15', '2025-11-13 05:45:15'),
(36, 2, NULL, 'hello', 'text', NULL, '2025-11-13 05:45:28', '2025-11-13 05:45:28'),
(37, 2, 75, 'What are you doing', 'text', NULL, '2025-11-13 05:45:50', '2025-11-13 05:45:50'),
(38, 2, NULL, 'nothing', 'text', NULL, '2025-11-13 05:47:59', '2025-11-13 05:47:59'),
(39, 2, NULL, 'Hi', 'text', NULL, '2025-11-13 05:49:39', '2025-11-13 05:49:39'),
(40, 2, 75, 'hh', 'text', NULL, '2025-11-13 05:50:32', '2025-11-13 05:50:32'),
(41, 2, NULL, 'kk', 'text', NULL, '2025-11-13 05:53:20', '2025-11-13 05:53:20'),
(42, 2, 75, 'kk', 'text', NULL, '2025-11-13 05:53:25', '2025-11-13 05:53:25'),
(43, 2, NULL, 'hi', 'text', NULL, '2025-11-13 05:56:01', '2025-11-13 05:56:01'),
(44, 2, 75, 'hello', 'text', NULL, '2025-11-13 05:56:11', '2025-11-13 05:56:11'),
(45, 2, NULL, 'Test broadcast message from tinker', 'text', NULL, '2025-11-13 05:56:53', '2025-11-13 05:56:53'),
(46, 2, NULL, 'hh', 'text', NULL, '2025-11-13 05:57:53', '2025-11-13 05:57:53'),
(47, 2, 75, 'ssdf', 'text', NULL, '2025-11-13 06:00:58', '2025-11-13 06:00:58'),
(48, 2, NULL, 'sdfsf', 'text', NULL, '2025-11-13 06:01:14', '2025-11-13 06:01:14'),
(49, 2, NULL, 'hi', 'text', NULL, '2025-11-13 06:13:04', '2025-11-13 06:13:04'),
(50, 2, 75, 'hello', 'text', NULL, '2025-11-13 06:13:16', '2025-11-13 06:13:16'),
(51, 2, NULL, 'Now', 'text', NULL, '2025-11-13 06:13:27', '2025-11-13 06:13:27'),
(52, 2, 75, 'hi', 'text', NULL, '2025-11-13 06:13:44', '2025-11-13 06:13:44'),
(53, 2, 75, 'jj', 'text', NULL, '2025-11-13 06:18:50', '2025-11-13 06:18:50'),
(54, 2, NULL, 'kk', 'text', NULL, '2025-11-13 06:18:57', '2025-11-13 06:18:57'),
(55, 2, 75, 'nmnm', 'text', NULL, '2025-11-13 06:19:08', '2025-11-13 06:19:08'),
(56, 2, 75, 'kkk', 'text', NULL, '2025-11-13 06:19:21', '2025-11-13 06:19:21'),
(57, 2, 75, 'jij', 'text', NULL, '2025-11-13 06:30:12', '2025-11-13 06:30:12'),
(58, 2, NULL, 'jkj', 'text', NULL, '2025-11-13 06:30:21', '2025-11-13 06:30:21'),
(59, 2, 75, 'nn', 'text', NULL, '2025-11-13 06:30:32', '2025-11-13 06:30:32'),
(60, 2, 75, 'sdf', 'text', NULL, '2025-11-13 06:31:05', '2025-11-13 06:31:05'),
(61, 2, NULL, 'sd', 'text', NULL, '2025-11-13 06:31:18', '2025-11-13 06:31:18'),
(62, 2, 75, 'sdf', 'text', NULL, '2025-11-13 06:31:25', '2025-11-13 06:31:25'),
(63, 2, NULL, 'hi', 'text', NULL, '2025-11-13 06:57:44', '2025-11-13 06:57:44'),
(64, 2, 4, 'hello', 'text', NULL, '2025-11-13 06:58:40', '2025-11-13 06:58:40'),
(74, 7, NULL, 'Support chat created. A Super Admin will assist you shortly.', 'system', NULL, '2025-11-13 13:01:06', '2025-11-13 13:01:06'),
(75, 7, 75, 'Hi', 'text', NULL, '2025-11-13 13:01:12', '2025-11-13 13:01:12'),
(76, 7, 1, 'Hello', 'text', NULL, '2025-11-13 13:01:23', '2025-11-13 13:01:23'),
(77, 2, NULL, 'Hello', 'text', NULL, '2025-11-13 13:24:19', '2025-11-13 13:24:19');

-- --------------------------------------------------------

--
-- بنية الجدول `message_reads`
--

CREATE TABLE `message_reads` (
  `id` bigint UNSIGNED NOT NULL,
  `message_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `read_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_10_20_182350_create_permission_tables', 1),
(6, '2023_10_22_180740_create_media_table', 1),
(7, '2023_10_23_135629_create_uploads_table', 1),
(8, '2023_10_24_175242_create_currencies_table', 1),
(9, '2023_10_24_175244_create_settings_table', 1),
(10, '2024_01_28_035646_add_extra_fields_to_users_table', 1),
(11, '2024_01_29_005831_create_activity_log_table', 1),
(12, '2024_01_29_005832_add_event_column_to_activity_log_table', 1),
(13, '2024_01_29_005833_add_batch_uuid_column_to_activity_log_table', 1),
(14, '2024_02_01_225753_create_payment_methods_table', 1),
(15, '2025_11_06_011930_create_specializations_table', 2),
(16, '2025_11_06_011937_create_departments_table', 2),
(19, '2025_11_06_033441_create_projects_table', 3),
(20, '2025_11_07_022733_create_project_assignments_table', 4),
(21, '2025_11_07_042105_create_defenses_table', 5),
(22, '2025_11_07_043048_create_defense_members_table', 5),
(23, '2025_11_09_003532_create_project_requests_table', 6),
(25, '2025_11_09_034213_create_project_submissions_table', 7),
(26, '2025_11_12_163218_add_code_link_to_project_submissions_table', 8),
(27, '2025_11_12_224803_create_notifications_table', 9),
(28, '2025_11_13_015808_create_conversations_table', 10),
(29, '2025_11_13_015816_create_conversation_participants_table', 10),
(30, '2025_11_13_015823_create_messages_table', 10),
(31, '2025_11_13_015847_create_message_reads_table', 10),
(32, '2025_11_13_130135_add_admin_support_type_to_conversations_table', 11),
(33, '2025_11_13_131245_add_user_role_to_conversation_participants_table', 12);

-- --------------------------------------------------------

--
-- بنية الجدول `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(4, 'App\\Models\\User', 4),
(4, 'App\\Models\\User', 5),
(4, 'App\\Models\\User', 6),
(4, 'App\\Models\\User', 7),
(4, 'App\\Models\\User', 8),
(4, 'App\\Models\\User', 9),
(4, 'App\\Models\\User', 10),
(4, 'App\\Models\\User', 11),
(4, 'App\\Models\\User', 12),
(4, 'App\\Models\\User', 13),
(4, 'App\\Models\\User', 14),
(4, 'App\\Models\\User', 15),
(4, 'App\\Models\\User', 16),
(4, 'App\\Models\\User', 17),
(4, 'App\\Models\\User', 18),
(4, 'App\\Models\\User', 19),
(4, 'App\\Models\\User', 20),
(4, 'App\\Models\\User', 21),
(4, 'App\\Models\\User', 22),
(4, 'App\\Models\\User', 23),
(4, 'App\\Models\\User', 24),
(4, 'App\\Models\\User', 25),
(4, 'App\\Models\\User', 26),
(4, 'App\\Models\\User', 27),
(4, 'App\\Models\\User', 28),
(4, 'App\\Models\\User', 29),
(4, 'App\\Models\\User', 30),
(4, 'App\\Models\\User', 31),
(4, 'App\\Models\\User', 32),
(4, 'App\\Models\\User', 33),
(4, 'App\\Models\\User', 34),
(4, 'App\\Models\\User', 35),
(4, 'App\\Models\\User', 36),
(4, 'App\\Models\\User', 37),
(4, 'App\\Models\\User', 38),
(4, 'App\\Models\\User', 39),
(4, 'App\\Models\\User', 40),
(4, 'App\\Models\\User', 41),
(4, 'App\\Models\\User', 42),
(4, 'App\\Models\\User', 43),
(4, 'App\\Models\\User', 44),
(4, 'App\\Models\\User', 45),
(4, 'App\\Models\\User', 46),
(4, 'App\\Models\\User', 47),
(4, 'App\\Models\\User', 48),
(4, 'App\\Models\\User', 49),
(4, 'App\\Models\\User', 50),
(4, 'App\\Models\\User', 51),
(4, 'App\\Models\\User', 52),
(4, 'App\\Models\\User', 53),
(5, 'App\\Models\\User', 54),
(5, 'App\\Models\\User', 55),
(5, 'App\\Models\\User', 56),
(5, 'App\\Models\\User', 57),
(5, 'App\\Models\\User', 58),
(5, 'App\\Models\\User', 59),
(5, 'App\\Models\\User', 60),
(5, 'App\\Models\\User', 61),
(5, 'App\\Models\\User', 62),
(5, 'App\\Models\\User', 63),
(5, 'App\\Models\\User', 64),
(5, 'App\\Models\\User', 65),
(5, 'App\\Models\\User', 66),
(5, 'App\\Models\\User', 67),
(5, 'App\\Models\\User', 68),
(5, 'App\\Models\\User', 69),
(5, 'App\\Models\\User', 70),
(5, 'App\\Models\\User', 71),
(5, 'App\\Models\\User', 72),
(5, 'App\\Models\\User', 73),
(5, 'App\\Models\\User', 75),
(4, 'App\\Models\\User', 76),
(6, 'App\\Models\\User', 77);

-- --------------------------------------------------------

--
-- بنية الجدول `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint UNSIGNED NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('01b4d854-9527-484d-8756-b35dcbd8a284', 'App\\Notifications\\SupervisorAssignedNotification', 'App\\Models\\User', 55, '{\"type\":\"supervisor_assigned\",\"title\":\"New Supervision Assignment\",\"message\":\"You have been assigned as supervisor for \\\"Test project\\\"\",\"project_id\":4,\"project_title\":\"Test project\",\"project_type\":\"Semester\",\"url\":\"\\/supervisor\\/supervised-projects\\/4\",\"icon\":\"ri-user-star-line\",\"icon_color\":\"text-primary\"}', NULL, '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
('1ddab608-2f90-4c83-9419-542576ed32b9', 'App\\Notifications\\ChapterSubmittedNotification', 'App\\Models\\User', 54, '{\"type\":\"chapter_submitted\",\"title\":\"New Chapter Submission\",\"message\":\"  Anzam Dip submitted Introduction for Real-Time Collaborative Code Editor\",\"submission_id\":2,\"project_id\":1,\"project_title\":\"Real-Time Collaborative Code Editor\",\"chapter_type\":\"Introduction\",\"student_name\":\"  Anzam Dip\",\"url\":\"\\/supervisor\\/supervised-projects\\/1\",\"icon\":\"ri-file-upload-line\",\"icon_color\":\"text-primary\"}', NULL, '2025-11-12 17:46:07', '2025-11-12 17:46:07'),
('3a2cdc5f-89db-4ef2-b68c-b4f6ecf160c3', 'App\\Notifications\\ProjectAssignedNotification', 'App\\Models\\User', 6, '{\"type\":\"project_assigned\",\"title\":\"Project Assigned\",\"message\":\"You have been assigned to \\\"Test project\\\"\",\"project_id\":4,\"project_title\":\"Test project\",\"project_type\":\"Semester\",\"url\":\"\\/student\\/assigned-projects\\/4\",\"icon\":\"ri-folder-add-line\",\"icon_color\":\"text-success\"}', '2025-11-13 13:19:53', '2025-11-13 13:15:40', '2025-11-13 13:19:53'),
('54c2c1cc-faf4-4a39-ac3c-1c3469941292', 'App\\Notifications\\ProjectAssignedNotification', 'App\\Models\\User', 9, '{\"type\":\"project_assigned\",\"title\":\"Project Assigned\",\"message\":\"You have been assigned to \\\"Test project\\\"\",\"project_id\":4,\"project_title\":\"Test project\",\"project_type\":\"Semester\",\"url\":\"\\/student\\/assigned-projects\\/4\",\"icon\":\"ri-folder-add-line\",\"icon_color\":\"text-success\"}', NULL, '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
('72944917-8b08-4dc0-8eed-f1fb2b1ee6ac', 'App\\Notifications\\SupervisorAssignedNotification', 'App\\Models\\User', 68, '{\"type\":\"supervisor_assigned\",\"title\":\"New Supervision Assignment\",\"message\":\"You have been assigned as supervisor for \\\"Soundscape\\\"\",\"project_id\":5,\"project_title\":\"Soundscape\",\"project_type\":\"Semester\",\"url\":\"\\/supervisor\\/supervised-projects\\/5\",\"icon\":\"ri-user-star-line\",\"icon_color\":\"text-primary\"}', NULL, '2025-12-18 01:28:07', '2025-12-18 01:28:07'),
('75201533-1655-422b-a04e-8500432ff771', 'App\\Notifications\\ProjectAssignedNotification', 'App\\Models\\User', 11, '{\"type\":\"project_assigned\",\"title\":\"Project Assigned\",\"message\":\"You have been assigned to \\\"Test project\\\"\",\"project_id\":4,\"project_title\":\"Test project\",\"project_type\":\"Semester\",\"url\":\"\\/student\\/assigned-projects\\/4\",\"icon\":\"ri-folder-add-line\",\"icon_color\":\"text-success\"}', NULL, '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
('7a4d4d83-839c-4a8e-bb80-98a2e317dc89', 'App\\Notifications\\SupervisorAssignedNotification', 'App\\Models\\User', 54, '{\"type\":\"supervisor_assigned\",\"title\":\"New Supervision Assignment\",\"message\":\"You have been assigned as supervisor for \\\"Test project\\\"\",\"project_id\":4,\"project_title\":\"Test project\",\"project_type\":\"Semester\",\"url\":\"\\/supervisor\\/supervised-projects\\/4\",\"icon\":\"ri-user-star-line\",\"icon_color\":\"text-primary\"}', NULL, '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
('8b875325-f4f0-48e2-9274-af2f1afa42de', 'App\\Notifications\\DefenseScheduledNotification', 'App\\Models\\User', 4, '{\"type\":\"defense_scheduled\",\"title\":\"Defense Scheduled\",\"message\":\"final defense scheduled for \\\"IoT Network Intrusion Detection System\\\" on Jan 31, 2026\",\"defense_id\":2,\"project_id\":2,\"project_title\":\"IoT Network Intrusion Detection System\",\"discussion_type\":\"final\",\"discussion_date\":\"2026-01-31 21:18:00\",\"discussion_hall\":\"IT-01\",\"url\":\"\\/defenses\\/2\",\"icon\":\"ri-calendar-event-line\",\"icon_color\":\"text-info\"}', NULL, '2025-12-28 23:48:48', '2025-12-28 23:48:48'),
('9d513626-c50a-4931-ac66-9eec14c90ba4', 'App\\Notifications\\ChapterSubmittedNotification', 'App\\Models\\User', 75, '{\"type\":\"chapter_submitted\",\"title\":\"New Chapter Submission\",\"message\":\"  Anzam Dip submitted Result & Analysis for IoT Network Intrusion Detection System\",\"submission_id\":5,\"project_id\":2,\"project_title\":\"IoT Network Intrusion Detection System\",\"chapter_type\":\"Result & Analysis\",\"student_name\":\"  Anzam Dip\",\"url\":\"\\/supervisor\\/supervised-projects\\/2\",\"icon\":\"ri-file-upload-line\",\"icon_color\":\"text-primary\"}', NULL, '2025-11-13 13:19:30', '2025-11-13 13:19:30'),
('9dbff486-32e5-43a3-8d1d-b5dd5747ac90', 'App\\Notifications\\ChapterSubmittedNotification', 'App\\Models\\User', 55, '{\"type\":\"chapter_submitted\",\"title\":\"New Chapter Submission\",\"message\":\"  Anzam Dip submitted Introduction for Real-Time Collaborative Code Editor\",\"submission_id\":2,\"project_id\":1,\"project_title\":\"Real-Time Collaborative Code Editor\",\"chapter_type\":\"Introduction\",\"student_name\":\"  Anzam Dip\",\"url\":\"\\/supervisor\\/supervised-projects\\/1\",\"icon\":\"ri-file-upload-line\",\"icon_color\":\"text-primary\"}', NULL, '2025-11-12 17:46:07', '2025-11-12 17:46:07'),
('acf24260-096e-4edc-8f5d-3b256dff418c', 'App\\Notifications\\ProjectAssignedNotification', 'App\\Models\\User', 20, '{\"type\":\"project_assigned\",\"title\":\"Project Assigned\",\"message\":\"You have been assigned to \\\"Soundscape\\\"\",\"project_id\":5,\"project_title\":\"Soundscape\",\"project_type\":\"Semester\",\"url\":\"\\/student\\/assigned-projects\\/5\",\"icon\":\"ri-folder-add-line\",\"icon_color\":\"text-success\"}', NULL, '2025-12-18 01:28:07', '2025-12-18 01:28:07'),
('ba2a2f06-ad3e-4fde-a0cd-522c43b72ebf', 'App\\Notifications\\DefenseScheduledNotification', 'App\\Models\\User', 58, '{\"type\":\"defense_scheduled\",\"title\":\"Defense Scheduled\",\"message\":\"final defense scheduled for \\\"IoT Network Intrusion Detection System\\\" on Jan 31, 2026\",\"defense_id\":2,\"project_id\":2,\"project_title\":\"IoT Network Intrusion Detection System\",\"discussion_type\":\"final\",\"discussion_date\":\"2026-01-31 21:18:00\",\"discussion_hall\":\"IT-01\",\"url\":\"\\/defenses\\/2\",\"icon\":\"ri-calendar-event-line\",\"icon_color\":\"text-info\"}', NULL, '2025-12-28 23:48:48', '2025-12-28 23:48:48'),
('ba6a1a88-2cd6-4abb-a5bf-0e8f065e8286', 'App\\Notifications\\DefenseScheduledNotification', 'App\\Models\\User', 75, '{\"type\":\"defense_scheduled\",\"title\":\"Defense Scheduled\",\"message\":\"final defense scheduled for \\\"IoT Network Intrusion Detection System\\\" on Jan 31, 2026\",\"defense_id\":2,\"project_id\":2,\"project_title\":\"IoT Network Intrusion Detection System\",\"discussion_type\":\"final\",\"discussion_date\":\"2026-01-31 21:18:00\",\"discussion_hall\":\"IT-01\",\"url\":\"\\/defenses\\/2\",\"icon\":\"ri-calendar-event-line\",\"icon_color\":\"text-info\"}', NULL, '2025-12-28 23:48:48', '2025-12-28 23:48:48'),
('c6827f06-53f3-46fa-a2a1-bd58bf34979a', 'App\\Notifications\\ChapterSubmittedNotification', 'App\\Models\\User', 75, '{\"type\":\"chapter_submitted\",\"title\":\"New Chapter Submission\",\"message\":\"  Anzam Dip submitted Literature Review for IoT Network Intrusion Detection System\",\"submission_id\":3,\"project_id\":2,\"project_title\":\"IoT Network Intrusion Detection System\",\"chapter_type\":\"Literature Review\",\"student_name\":\"  Anzam Dip\",\"url\":\"\\/supervisor\\/supervised-projects\\/2\",\"icon\":\"ri-file-upload-line\",\"icon_color\":\"text-primary\"}', '2025-11-12 18:03:08', '2025-11-12 17:46:52', '2025-11-12 18:03:08'),
('d8b66406-eb6c-4c06-8020-c7c370000e2f', 'App\\Notifications\\ProjectAssignedNotification', 'App\\Models\\User', 76, '{\"type\":\"project_assigned\",\"title\":\"Project Assigned\",\"message\":\"You have been assigned to \\\"Soundscape\\\"\",\"project_id\":5,\"project_title\":\"Soundscape\",\"project_type\":\"Semester\",\"url\":\"\\/student\\/assigned-projects\\/5\",\"icon\":\"ri-folder-add-line\",\"icon_color\":\"text-success\"}', '2025-12-18 01:29:09', '2025-12-18 01:28:07', '2025-12-18 01:29:09'),
('f5700ef9-2d87-42cf-8196-077366b48143', 'App\\Notifications\\ChapterSubmittedNotification', 'App\\Models\\User', 75, '{\"type\":\"chapter_submitted\",\"title\":\"New Chapter Submission\",\"message\":\"  Anzam Dip submitted Methodology for IoT Network Intrusion Detection System\",\"submission_id\":4,\"project_id\":2,\"project_title\":\"IoT Network Intrusion Detection System\",\"chapter_type\":\"Methodology\",\"student_name\":\"  Anzam Dip\",\"url\":\"\\/supervisor\\/supervised-projects\\/2\",\"icon\":\"ri-file-upload-line\",\"icon_color\":\"text-primary\"}', '2025-11-13 13:20:25', '2025-11-12 18:07:34', '2025-11-13 13:20:25'),
('f6b66452-7094-4d15-b5fe-3d7dc57c1067', 'App\\Notifications\\DefenseScheduledNotification', 'App\\Models\\User', 59, '{\"type\":\"defense_scheduled\",\"title\":\"Defense Scheduled\",\"message\":\"final defense scheduled for \\\"IoT Network Intrusion Detection System\\\" on Jan 31, 2026\",\"defense_id\":2,\"project_id\":2,\"project_title\":\"IoT Network Intrusion Detection System\",\"discussion_type\":\"final\",\"discussion_date\":\"2026-01-31 21:18:00\",\"discussion_hall\":\"IT-01\",\"url\":\"\\/defenses\\/2\",\"icon\":\"ri-calendar-event-line\",\"icon_color\":\"text-info\"}', NULL, '2025-12-28 23:48:48', '2025-12-28 23:48:48');

-- --------------------------------------------------------

--
-- بنية الجدول `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` bigint UNSIGNED NOT NULL,
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'access_dashboard', 'web', '2025-11-05 15:55:51', '2025-11-05 15:55:51'),
(2, 'user_can_edit_own_profile', 'web', '2025-11-05 15:55:51', '2025-11-05 15:55:51'),
(3, 'access_user_management', 'web', '2025-11-05 15:55:51', '2025-11-05 15:55:51'),
(4, 'access_currencies', 'web', '2025-11-05 15:55:51', '2025-11-05 15:55:51'),
(5, 'access_reports', 'web', '2025-11-05 15:55:51', '2025-11-05 15:55:51'),
(6, 'access_activity_logs', 'web', '2025-11-05 15:55:51', '2025-11-05 15:55:51'),
(7, 'access_settings', 'web', '2025-11-05 15:55:51', '2025-11-05 15:55:51'),
(8, 'access_payment_methods', 'web', '2025-11-05 15:55:51', '2025-11-05 15:55:51'),
(9, 'access_specializations', 'web', '2025-11-05 19:21:54', '2025-11-05 19:21:54'),
(10, 'access_departments', 'web', '2025-11-05 19:21:54', '2025-11-05 19:21:54'),
(11, 'view_projects', 'web', '2025-11-05 23:16:12', '2025-11-05 23:16:12'),
(12, 'create_projects', 'web', '2025-11-05 23:16:12', '2025-11-05 23:16:12'),
(13, 'edit_projects', 'web', '2025-11-05 23:16:12', '2025-11-05 23:16:12'),
(14, 'delete_projects', 'web', '2025-11-05 23:16:12', '2025-11-05 23:16:12'),
(15, 'view_supervisors', 'web', '2025-11-06 19:46:17', '2025-11-06 19:46:17'),
(16, 'view_students', 'web', '2025-11-06 19:46:17', '2025-11-06 19:46:17'),
(17, 'view_assignments', 'web', '2025-11-06 20:26:29', '2025-11-06 20:26:29'),
(18, 'create_assignments', 'web', '2025-11-06 20:26:29', '2025-11-06 20:26:29'),
(19, 'edit_assignments', 'web', '2025-11-06 20:26:29', '2025-11-06 20:26:29'),
(20, 'delete_assignments', 'web', '2025-11-06 20:26:29', '2025-11-06 20:26:29'),
(21, 'assign_supervisors', 'web', '2025-11-06 20:26:29', '2025-11-06 20:26:29'),
(22, 'assign_students', 'web', '2025-11-06 20:26:29', '2025-11-06 20:26:29'),
(23, 'view_defenses', 'web', '2025-11-06 22:39:16', '2025-11-06 22:39:16'),
(24, 'create_defenses', 'web', '2025-11-06 22:39:16', '2025-11-06 22:39:16'),
(25, 'edit_defenses', 'web', '2025-11-06 22:39:17', '2025-11-06 22:39:17'),
(26, 'delete_defenses', 'web', '2025-11-06 22:39:17', '2025-11-06 22:39:17'),
(27, 'view_project_requests', 'web', '2025-11-12 18:28:22', '2025-11-12 18:28:22'),
(28, 'access_support_chats', 'web', '2025-11-13 07:53:38', '2025-11-13 07:53:38');

-- --------------------------------------------------------

--
-- بنية الجدول `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `projects`
--

CREATE TABLE `projects` (
  `id` bigint UNSIGNED NOT NULL,
  `specialization_id` bigint UNSIGNED DEFAULT NULL,
  `department_id` bigint UNSIGNED DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Semester, Graduation 1, Graduation 2',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Pending, Approved, Rejected',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `projects`
--

INSERT INTO `projects` (`id`, `specialization_id`, `department_id`, `title`, `description`, `project_type`, `created_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Real-Time Collaborative Code Editor', '<p>A web-based application (like a simplified VS Code) that allows multiple users to edit the same code file simultaneously. The project will use WebSockets for real-time communication and CRDTs (Conflict-free Replicated Data Types) for conflict-free merging.</p><p><strong>Key Objectives:</strong></p><ol><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Develop a stable, multi-user text editor.</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Implement real-time updates via WebSockets.</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Ensure conflict-free editing.</li></ol>', 'Semester', 2, 'Approved', '2025-11-06 13:52:27', '2025-11-13 13:05:41'),
(2, 3, 1, 'IoT Network Intrusion Detection System', '<p>A project to develop a lightweight intrusion detection system (IDS) specifically designed for Internet of Fhings (IoT) devices. It will monitor network traffic for common attack patterns (like DDoS or port scanning) and be deployed on a low-power device like a Raspberry Pi.</p><p><strong>Key Objectives:</strong></p><ol><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Implement a packet sniffer to monitor network traffic.</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Develop signature-based detection for at least 3 common IoT attacks.</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Create a logging system to record all detected threats.</li></ol>', 'Graduation 1', 2, 'Approved', '2025-11-07 21:52:38', '2025-11-13 13:22:30'),
(3, 4, 1, 'Student Churn Prediction Model', '<p>An analysis and machine learning model designed to predict the likelihood of a student dropping out. The model will be trained on historical university data, including grades, attendance, and demographic information, to help administrators intervene early.</p><p><strong>Key Objectives:</strong></p><ol><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Clean and preprocess historical student data.</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Train and evaluate at least three different classification models (e.g., Logistic Regression, Random Forest, Gradient Boosting).</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Develop a simple dashboard to visualize the risk score for a student.</li></ol>', 'Graduation 1', 75, 'Rejected', '2025-11-07 23:01:31', '2025-12-14 21:54:41'),
(4, 1, 1, 'Test project', '<p>testing</p>', 'Semester', 1, 'Approved', '2025-11-13 13:14:27', '2025-11-13 13:14:32'),
(5, 1, 1, 'Soundscape', '<p><strong>online web application</strong> where users can create, manage, and share personal song collections (playlists). Instead of scanning local folders, users <strong>search or upload songs</strong> to build their lists in the cloud. The core experience revolves around discovering music, organizing it into playlists, and accessing them from any device with an internet connection.</p><p><br></p><p>The main objectives:</p><ol><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>ser-Centric Playlist Creation</strong></li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Music Discovery &amp; Catalog Integration</strong></li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Cloud Synchronization &amp; Accessibility</strong>				</li></ol>', 'Semester', 77, 'Approved', '2025-12-18 01:26:35', '2025-12-18 01:26:35'),
(6, 1, 1, 'Home Care System', '<p>Allows customers to submit maintenance requests, upload images of issues, and compare service offers. It also supports features such as role-based access control, notifications, and ratings. It enables service providers to enhance their visibility based on the quality of their work.</p>', 'Semester', 54, 'Approved', '2025-12-18 19:11:52', '2025-12-18 19:13:10');

-- --------------------------------------------------------

--
-- بنية الجدول `project_assignments`
--

CREATE TABLE `project_assignments` (
  `id` bigint UNSIGNED NOT NULL,
  `project_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `role` enum('supervisor','student') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `assigned_by` bigint UNSIGNED DEFAULT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `project_assignments`
--

INSERT INTO `project_assignments` (`id`, `project_id`, `user_id`, `role`, `assigned_by`, `assigned_at`, `created_at`, `updated_at`) VALUES
(1, 1, 54, 'supervisor', 2, '2025-11-06 20:42:49', '2025-11-06 20:42:49', '2025-11-06 20:42:49'),
(5, 1, 5, 'student', 2, '2025-11-06 20:42:49', '2025-11-06 20:42:49', '2025-11-06 20:42:49'),
(6, 1, 55, 'supervisor', 2, '2025-11-06 20:55:53', '2025-11-06 20:55:53', '2025-11-06 20:55:53'),
(7, 2, 75, 'supervisor', 2, '2025-11-07 21:53:59', '2025-11-07 21:53:59', '2025-11-07 21:53:59'),
(17, 2, 4, 'student', 2, '2025-11-13 06:55:52', '2025-11-13 06:55:52', '2025-11-13 06:55:52'),
(18, 4, 6, 'student', NULL, '2025-11-13 13:45:40', '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
(19, 4, 11, 'student', NULL, '2025-11-13 13:45:40', '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
(20, 4, 9, 'student', NULL, '2025-11-13 13:45:40', '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
(21, 4, 54, 'supervisor', NULL, '2025-11-13 13:45:40', '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
(22, 4, 55, 'supervisor', NULL, '2025-11-13 13:45:40', '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
(23, 1, 4, 'student', 1, '2025-12-14 22:14:49', '2025-12-14 22:14:49', '2025-12-14 22:14:49'),
(25, 5, 76, 'student', NULL, '2025-12-17 22:58:01', '2025-12-18 01:28:01', '2025-12-18 01:28:01'),
(26, 5, 20, 'student', NULL, '2025-12-17 22:58:07', '2025-12-18 01:28:07', '2025-12-18 01:28:07'),
(27, 5, 68, 'supervisor', NULL, '2025-12-17 22:58:07', '2025-12-18 01:28:07', '2025-12-18 01:28:07');

-- --------------------------------------------------------

--
-- بنية الجدول `project_requests`
--

CREATE TABLE `project_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `project_id` bigint UNSIGNED NOT NULL,
  `student_id` bigint UNSIGNED NOT NULL,
  `request_type` enum('individual','group') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'individual',
  `group_members` json DEFAULT NULL,
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `reviewed_by` bigint UNSIGNED DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `project_requests`
--

INSERT INTO `project_requests` (`id`, `project_id`, `student_id`, `request_type`, `group_members`, `status`, `message`, `reviewed_by`, `reviewed_at`, `created_at`, `updated_at`) VALUES
(2, 4, 6, 'group', '[11, 9]', 'approved', 'Testing', 1, '2025-11-13 13:15:40', '2025-11-13 13:15:03', '2025-11-13 13:15:40'),
(3, 5, 76, 'group', '[20]', 'approved', NULL, 77, '2025-12-18 01:28:01', '2025-12-18 01:27:25', '2025-12-18 01:28:01');

-- --------------------------------------------------------

--
-- بنية الجدول `project_submissions`
--

CREATE TABLE `project_submissions` (
  `id` bigint UNSIGNED NOT NULL,
  `project_id` bigint UNSIGNED NOT NULL,
  `uploaded_by` bigint UNSIGNED NOT NULL,
  `chapter_type` enum('Introduction','Literature Review','Methodology','Result & Analysis','Conclusion','Abstract','Full Draft') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `supervisor_feedback` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `reviewed_by` bigint UNSIGNED DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'web', '2025-11-05 15:55:51', '2025-11-05 15:55:51'),
(2, 'Developer', 'web', '2025-11-05 15:55:51', '2025-11-05 15:55:51'),
(3, 'Admin', 'web', '2025-11-05 15:55:51', '2025-11-05 15:55:51'),
(4, 'student', 'web', '2025-11-05 15:56:51', '2025-11-05 15:56:51'),
(5, 'supervisor', 'web', '2025-11-05 15:56:51', '2025-11-05 15:56:51'),
(6, 'Project Admin', 'web', '2025-11-13 12:58:20', '2025-11-13 12:58:20');

-- --------------------------------------------------------

--
-- بنية الجدول `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 3),
(2, 3),
(4, 3),
(5, 3),
(6, 3),
(7, 3),
(8, 3),
(9, 3),
(10, 3),
(11, 3),
(12, 3),
(13, 3),
(14, 3),
(15, 3),
(16, 3),
(17, 3),
(18, 3),
(19, 3),
(20, 3),
(21, 3),
(22, 3),
(23, 3),
(24, 3),
(25, 3),
(26, 3),
(27, 3),
(2, 4),
(2, 5),
(2, 6),
(11, 6),
(12, 6),
(13, 6),
(14, 6),
(17, 6),
(18, 6),
(19, 6),
(20, 6),
(21, 6),
(22, 6),
(23, 6),
(24, 6),
(25, 6),
(26, 6),
(27, 6),
(28, 6);

-- --------------------------------------------------------

--
-- بنية الجدول `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `currency_id` bigint UNSIGNED DEFAULT NULL,
  `company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_email_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_mobile_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notification_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `company_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `vat_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_percentage` int DEFAULT NULL,
  `decimal_point` tinyint(1) NOT NULL DEFAULT '1',
  `date_format` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_zone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_format` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `settings`
--

INSERT INTO `settings` (`id`, `currency_id`, `company_name`, `company_email`, `company_email_2`, `company_mobile`, `company_mobile_2`, `currency_position`, `notification_email`, `footer_text`, `company_address`, `vat_id`, `tax_percentage`, `decimal_point`, `date_format`, `time_zone`, `time_format`, `created_at`, `updated_at`) VALUES
(1, 1, 'Cool Company', 'coolcompany@gmail.com', NULL, '1234567890', NULL, 'suffix_space', NULL, NULL, '123 Cool Street, Cool City, 12345', NULL, 0, 0, 'DD-MM-YYYY', 'Asia/Dhaka', '12H', '2025-11-05 15:55:52', '2025-11-05 15:58:02');

-- --------------------------------------------------------

--
-- بنية الجدول `specializations`
--

CREATE TABLE `specializations` (
  `id` bigint UNSIGNED NOT NULL,
  `short_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `specializations`
--

INSERT INTO `specializations` (`id`, `short_name`, `name`, `created_at`, `updated_at`) VALUES
(1, 'SWE', 'Software Engineering', '2025-11-05 21:06:39', '2025-11-05 21:06:39'),
(2, 'DTSC', 'Data Science', '2025-11-05 21:07:14', '2025-11-05 21:07:14'),
(3, 'CBS', 'Cybersecurity', '2025-11-05 21:07:57', '2025-11-05 21:07:57'),
(4, 'AI', 'Artificial Intelligence', '2025-11-05 21:08:13', '2025-11-05 21:08:13'),
(5, 'CS', 'Computer Science', '2025-11-05 22:51:17', '2025-11-05 22:51:17');

-- --------------------------------------------------------

--
-- بنية الجدول `uploads`
--

CREATE TABLE `uploads` (
  `id` bigint UNSIGNED NOT NULL,
  `folder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Male/Female',
  `date_of_birth` date DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `first_name`, `last_name`, `mobile`, `gender`, `date_of_birth`, `address`) VALUES
(1, 'Administrator', 'super.admin@test.com', NULL, '$2y$10$TDtkHFYAUR6FE275SggKJeADweSSDGgIEWjR3jf4Sle5psi6cXXT6', NULL, '2025-11-05 15:55:51', '2025-11-13 13:01:12', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'Developer', 'developer@test.com', NULL, '$2y$10$Zmbvo8OdCKE0Ts8Bp/xCHOeYgJGV0SN9y2dPT7a/KfWsGoG0HX4Pa', NULL, '2025-11-05 15:55:51', '2025-11-05 15:55:51', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'Rico Satterfield', 'paucek.shanelle@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'I3OizyBen0vNDKl8eDgD6NcEFoM5uktIcaXHiGT5Jzynhe5vSzh081JigpQe', '2025-11-06 20:06:02', '2025-11-13 13:24:19', NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'Garth Abernathy', 'vmohr@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'MzKXBGiKoM', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'Miss Audie Zieme', 'eharris@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'H9pAIbvv0vzHLEc8uWh2dDKItnNgxJQVGJoiLC6XjNXa7039UVbawb0VQZuH', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'Ms. Linda Stehr Jr.', 'cristopher.lindgren@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'nitPLrYnop', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'Dr. Kaylee Witting MD', 'jones.stacy@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'jewWWdXQpY', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'Jamel Harber', 'jrunolfsdottir@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'TQ98uLvUnf', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'Lorna Sanford', 'zemlak.marcel@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'NohhZp7obC', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(11, 'Prof. Sofia Osinski', 'katharina.quigley@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'EzTuzMsinv', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'Davonte Wisoky V', 'avis.armstrong@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'hRV0R3szHI', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(13, 'Nia Hahn', 'raynor.marjorie@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ESBwD5fycm', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(14, 'Dr. Buck Herzog I', 'ashley.hartmann@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'NrzxJnl8a4', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(15, 'Camryn O\'Keefe', 'simone.bashirian@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'L3TLt69tjj', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(16, 'Prof. Steve Altenwerth', 'marie23@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'w4fWvGZcW2', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(17, 'Isabella Borer', 'hspinka@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'RHebvTlfO1', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(18, 'Prof. Charlotte Reynolds', 'tkoch@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'dKCUbn5Y7D', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(19, 'Emely Farrell DDS', 'dylan26@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'sjnj05YUyH', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(20, 'Kory Swift', 'qleffler@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '2veycqah2O', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(21, 'Linda Denesik', 'pbode@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'PMpvRSBp7I', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(22, 'Maximillia Senger', 'lisa.streich@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'w0rFQhXcsp', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(23, 'Prof. Albertha Sporer IV', 'trinity05@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'J6WO1VMrRp', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(24, 'Mr. Bart Glover MD', 'favian74@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'hb4hZHO7vy', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(25, 'Trevion Crona', 'jarod23@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Wk6Qby7S6U', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(26, 'Hallie Hilpert', 'maurine30@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'XYtZfO0NDQ', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(27, 'Thurman Deckow', 'schulist.nyasia@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'PrPOB8v1mX', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(28, 'Ashtyn Casper', 'gwen.nicolas@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'i4Lwtnl6dt', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(29, 'Sincere Daniel II', 'cmante@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'GpadrQHfhu', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(30, 'Prof. Mallory Leuschke', 'wiegand.kali@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'uiCeeFNIw0', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(31, 'Prof. Armando Fay', 'hannah.hand@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'MxZcUDOt58', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(32, 'Prof. Meagan Batz', 'schuster.mollie@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'n79efdQQJA', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(33, 'Lavinia Lubowitz', 'freeda.shields@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '8Gc3Lj9g2w', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(34, 'Noemy Rolfson III', 'ziemann.francesca@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'JjPeEkPyyC', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(35, 'Heath Kreiger III', 'rigoberto12@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ZvqQgZz5fm', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(36, 'Albert Rolfson', 'jordyn19@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'XHDiDpIYmR', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(37, 'Ethan Towne II', 'tracy75@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '440Gvy5BuK', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(38, 'Rahul Crona', 'beer.merl@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'qPLGvMgq93', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(39, 'Dr. Kali Quigley', 'mitchell99@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'yYQe7xCs6h', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(40, 'Lessie Mohr', 'bstroman@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'F3P8WrWFkh', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(41, 'Jayden Jaskolski', 'russ.murazik@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'RZCcoZA5cM', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(42, 'Tyson Doyle', 'kunze.arturo@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'hZPviOUUrm', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(43, 'Bertha Jacobson', 'hmayert@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Tv5XK4vIVB', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(44, 'Mrs. Eleanora Boyer Jr.', 'katelyn15@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '3wpPGmK6Ee', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(45, 'Mr. Alfonso Luettgen Jr.', 'hosea.beer@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'VeCdAdR0Vu', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(46, 'Jayda Bogan', 'aheathcote@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '8qBZRooNcV', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(47, 'Torey Borer', 'simone47@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'GWcE98YNtC', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(48, 'Wayne Sanford', 'xupton@example.net', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '3zpbfwNFj2', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(49, 'Prof. Mellie Hickle', 'gerardo12@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '0h2AzRWNEQ', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(50, 'Shania Dietrich', 'dach.kory@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'HqXCzuZYRz', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(51, 'Mrs. Marlene Schmitt', 'elsie.harris@example.com', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ggho4Br423', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(52, 'Dr. Jermey Klein II', 'fgutkowski@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'XqB98Q6FfP', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(53, 'Virgie Carter', 'cielo54@example.org', '2025-11-06 20:06:02', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'TiLN6K6Om6', '2025-11-06 20:06:02', '2025-11-06 20:06:02', NULL, NULL, NULL, NULL, NULL, NULL),
(54, 'Casimer Sipes III', 'macejkovic.howell@example.com', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'uSJfq3AgtSNwqO4y9OvBJGLexEgRf6nHWFBtkxHSy7QfsAwPJB8luE1jLF0P', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(55, 'Fiona Trantow', 'vauer@example.org', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'e0nnvkleub', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(56, 'Prof. Bo Bernhard', 'schamberger.karl@example.net', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'zBWqScXUguloe3Wh1OMOEiafEM34YU5KoiJhK9XGJdSfEkcVfQiS80aZpIiN', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(57, 'Shania Crona', 'adalberto07@example.net', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '1QG5rLnkqP', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(58, 'Dave Skiles', 'melba.wehner@example.net', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'elWZ6J9n4L', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(59, 'Delilah Bauch', 'genevieve.wolf@example.net', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'nJZrZMo89s', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(60, 'Mrs. Rosalyn Lang I', 'harvey.alessandra@example.net', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'nz628aGp5e', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(61, 'Leonora Schultz Jr.', 'kdickens@example.net', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'oOZOpKW6aR', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(62, 'Melyna Anderson', 'olga.sauer@example.net', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'dlvZB5qntZ', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(63, 'Dr. Frances Kulas', 'brandon28@example.org', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'hU0arvQ7oP', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(64, 'Dr. Lyric Hills DDS', 'gboyle@example.com', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'w574AKfLUI', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(65, 'Breanne Jacobson', 'ondricka.bernardo@example.net', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '1cmT5yKPoh', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(66, 'Miss Rubie Harvey I', 'raleigh.langworth@example.com', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'U1Veplxqre', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(67, 'Mrs. Lucienne Cruickshank', 'rollin43@example.com', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '17HFyf5UBX', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(68, 'Ms. Alvena Lueilwitz PhD', 'hagenes.dayton@example.com', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ZqvcC9EiBA', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(69, 'Mrs. Marina Lang I', 'wintheiser.icie@example.org', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'zJ50oZQRpy', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(70, 'Prof. Brandi Ullrich', 'uriel.keebler@example.net', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'C9QKF5AIG3', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(71, 'Garnet Jerde', 'evert.gutmann@example.org', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'fku0KMal7l', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(72, 'Chasity Wuckert', 'marcella.sporer@example.org', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '7iklVMSnRI', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(73, 'Telly Lehner', 'pouros.natalie@example.net', '2025-11-06 20:06:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'VH8cli8F1u', '2025-11-06 20:06:15', '2025-11-06 20:06:15', NULL, NULL, NULL, NULL, NULL, NULL),
(75, 'Jannatul Ferdous', 'jannat@gmail.com', NULL, '$2y$10$a5VlshujjYxKJ6yTXU4FEeCOp5.Cp0D83XgeJ8YMoZ1cCIc/YaRJu', NULL, '2025-11-07 21:23:37', '2025-11-13 13:24:19', NULL, NULL, NULL, NULL, NULL, NULL),
(76, 'Bayan Znika', 'bayanzn2001@gmail.com', NULL, '$2y$10$wh0AofdBJ2huwxD/cdetJ.i/tLLMIujkf6tbtRmTd/i07Znv0vqEW', NULL, '2025-12-14 18:22:35', '2025-12-14 18:22:35', NULL, NULL, NULL, NULL, NULL, NULL),
(77, 'projectadmin', 'projectadmin@test.com', NULL, '$2y$10$/upU5RT3nFm8pd1nMvq5wuHwSDar6bDTU8XUu7PJVSbu9PeLgZWZG', NULL, '2025-12-18 00:42:56', '2025-12-18 00:42:56', NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- فهارس للجدول `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject` (`subject_type`,`subject_id`),
  ADD KEY `causer` (`causer_type`,`causer_id`),
  ADD KEY `activity_log_log_name_index` (`log_name`);

--
-- فهارس للجدول `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversations_created_by_foreign` (`created_by`),
  ADD KEY `conversations_project_id_type_index` (`project_id`,`type`);

--
-- فهارس للجدول `conversation_participants`
--
ALTER TABLE `conversation_participants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `conversation_participants_conversation_id_user_id_unique` (`conversation_id`,`user_id`),
  ADD KEY `conversation_participants_user_id_index` (`user_id`);

--
-- فهارس للجدول `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `defenses`
--
ALTER TABLE `defenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `defenses_created_by_foreign` (`created_by`),
  ADD KEY `defenses_project_id_discussion_type_index` (`project_id`,`discussion_type`),
  ADD KEY `defenses_discussion_date_index` (`discussion_date`),
  ADD KEY `defenses_status_index` (`status`);

--
-- فهارس للجدول `defense_members`
--
ALTER TABLE `defense_members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `defense_members_defense_id_user_id_unique` (`defense_id`,`user_id`),
  ADD KEY `defense_members_user_id_index` (`user_id`);

--
-- فهارس للجدول `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `departments_short_name_unique` (`short_name`);

--
-- فهارس للجدول `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- فهارس للجدول `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_uuid_unique` (`uuid`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  ADD KEY `media_order_column_index` (`order_column`);

--
-- فهارس للجدول `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messages_conversation_id_created_at_index` (`conversation_id`,`created_at`),
  ADD KEY `messages_sender_id_index` (`sender_id`);

--
-- فهارس للجدول `message_reads`
--
ALTER TABLE `message_reads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `message_reads_message_id_user_id_unique` (`message_id`,`user_id`),
  ADD KEY `message_reads_user_id_index` (`user_id`);

--
-- فهارس للجدول `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- فهارس للجدول `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- فهارس للجدول `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- فهارس للجدول `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- فهارس للجدول `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- فهارس للجدول `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- فهارس للجدول `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `projects_specialization_id_foreign` (`specialization_id`),
  ADD KEY `projects_department_id_foreign` (`department_id`),
  ADD KEY `projects_created_by_foreign` (`created_by`);

--
-- فهارس للجدول `project_assignments`
--
ALTER TABLE `project_assignments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `project_assignments_project_id_user_id_role_unique` (`project_id`,`user_id`,`role`),
  ADD KEY `project_assignments_assigned_by_foreign` (`assigned_by`),
  ADD KEY `project_assignments_project_id_role_index` (`project_id`,`role`),
  ADD KEY `project_assignments_user_id_index` (`user_id`);

--
-- فهارس للجدول `project_requests`
--
ALTER TABLE `project_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_requests_project_id_foreign` (`project_id`),
  ADD KEY `project_requests_student_id_foreign` (`student_id`),
  ADD KEY `project_requests_reviewed_by_foreign` (`reviewed_by`);

--
-- فهارس للجدول `project_submissions`
--
ALTER TABLE `project_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_submissions_project_id_foreign` (`project_id`),
  ADD KEY `project_submissions_uploaded_by_foreign` (`uploaded_by`),
  ADD KEY `project_submissions_reviewed_by_foreign` (`reviewed_by`);

--
-- فهارس للجدول `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- فهارس للجدول `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- فهارس للجدول `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `settings_currency_id_foreign` (`currency_id`);

--
-- فهارس للجدول `specializations`
--
ALTER TABLE `specializations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `specializations_short_name_unique` (`short_name`);

--
-- فهارس للجدول `uploads`
--
ALTER TABLE `uploads`
  ADD PRIMARY KEY (`id`);

--
-- فهارس للجدول `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `conversation_participants`
--
ALTER TABLE `conversation_participants`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `defenses`
--
ALTER TABLE `defenses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `defense_members`
--
ALTER TABLE `defense_members`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `message_reads`
--
ALTER TABLE `message_reads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `project_assignments`
--
ALTER TABLE `project_assignments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `project_requests`
--
ALTER TABLE `project_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `project_submissions`
--
ALTER TABLE `project_submissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `specializations`
--
ALTER TABLE `specializations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `uploads`
--
ALTER TABLE `uploads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- القيود المفروضة على الجداول الملقاة
--

--
-- قيود الجداول `conversations`
--
ALTER TABLE `conversations`
  ADD CONSTRAINT `conversations_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `conversations_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `conversation_participants`
--
ALTER TABLE `conversation_participants`
  ADD CONSTRAINT `conversation_participants_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `conversation_participants_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `defenses`
--
ALTER TABLE `defenses`
  ADD CONSTRAINT `defenses_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `defenses_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `defense_members`
--
ALTER TABLE `defense_members`
  ADD CONSTRAINT `defense_members_defense_id_foreign` FOREIGN KEY (`defense_id`) REFERENCES `defenses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `defense_members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- قيود الجداول `message_reads`
--
ALTER TABLE `message_reads`
  ADD CONSTRAINT `message_reads_message_id_foreign` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `message_reads_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `projects_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `projects_specialization_id_foreign` FOREIGN KEY (`specialization_id`) REFERENCES `specializations` (`id`) ON DELETE SET NULL;

--
-- قيود الجداول `project_assignments`
--
ALTER TABLE `project_assignments`
  ADD CONSTRAINT `project_assignments_assigned_by_foreign` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `project_assignments_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `project_assignments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `project_requests`
--
ALTER TABLE `project_requests`
  ADD CONSTRAINT `project_requests_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `project_requests_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `project_requests_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `project_submissions`
--
ALTER TABLE `project_submissions`
  ADD CONSTRAINT `project_submissions_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `project_submissions_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `project_submissions_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `settings`
--
ALTER TABLE `settings`
  ADD CONSTRAINT `settings_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
