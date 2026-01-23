-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- مضيف: localhost:3306
-- وقت الجيل: 09 يناير 2026 الساعة 20:26
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
  `log_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` bigint UNSIGNED DEFAULT NULL,
  `causer_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` bigint UNSIGNED DEFAULT NULL,
  `properties` json DEFAULT NULL,
  `batch_uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `activity_log`
--

INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(1, 'departments', 'ID#1 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\Department', 'created', 1, 'App\\Models\\User', 1, '[]', NULL, '2026-01-07 01:20:31', '2026-01-07 01:20:31'),
(2, 'specializations', 'ID#1 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\Specialization', 'created', 1, 'App\\Models\\User', 1, '[]', NULL, '2026-01-07 01:21:20', '2026-01-07 01:21:20'),
(3, 'specializations', 'ID#2 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\Specialization', 'created', 2, 'App\\Models\\User', 1, '[]', NULL, '2026-01-07 01:21:32', '2026-01-07 01:21:32'),
(4, 'specializations', 'ID#3 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\Specialization', 'created', 3, 'App\\Models\\User', 1, '[]', NULL, '2026-01-07 01:22:46', '2026-01-07 01:22:46'),
(5, 'specializations', 'ID#4 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\Specialization', 'created', 4, 'App\\Models\\User', 1, '[]', NULL, '2026-01-07 01:23:00', '2026-01-07 01:23:00'),
(6, 'projects', 'ID#1 has been created by Antwan Robel DVM [\"supervisor\"]', 'App\\Models\\Project', 'created', 1, 'App\\Models\\User', 3, '[]', NULL, '2026-01-07 01:45:07', '2026-01-07 01:45:07'),
(7, 'projects', 'ID#2 has been created by Antwan Robel DVM [\"supervisor\"]', 'App\\Models\\Project', 'created', 2, 'App\\Models\\User', 3, '[]', NULL, '2026-01-07 01:45:42', '2026-01-07 01:45:42'),
(8, 'projects', 'ID#2 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Project', 'updated', 2, 'App\\Models\\User', 1, '[]', NULL, '2026-01-07 01:46:03', '2026-01-07 01:46:03'),
(9, 'project_assignments', 'ID#1 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 1, 'App\\Models\\User', 1, '[]', NULL, '2026-01-07 01:46:03', '2026-01-07 01:46:03'),
(10, 'projects', 'ID#1 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Project', 'updated', 1, 'App\\Models\\User', 1, '[]', NULL, '2026-01-07 01:46:04', '2026-01-07 01:46:04'),
(11, 'project_assignments', 'ID#2 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 2, 'App\\Models\\User', 1, '[]', NULL, '2026-01-07 01:46:04', '2026-01-07 01:46:04'),
(12, 'project_assignments', 'ID#3 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 3, 'App\\Models\\User', 1, '[]', NULL, '2026-01-07 01:46:18', '2026-01-07 01:46:18'),
(13, 'project_assignments', 'ID#4 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 4, 'App\\Models\\User', 1, '[]', NULL, '2026-01-07 01:46:32', '2026-01-07 01:46:32'),
(14, 'project_assignments', 'ID#5 has been created by Administrator [\"Super Admin\"]', 'App\\Models\\ProjectAssignment', 'created', 5, 'App\\Models\\User', 1, '[]', NULL, '2026-01-07 01:46:32', '2026-01-07 01:46:32'),
(15, 'project_submissions', 'ID#1 has been created by Aryanna Kertzmann [\"student\"]', 'App\\Models\\ProjectSubmission', 'created', 1, 'App\\Models\\User', 13, '[]', NULL, '2026-01-07 01:47:21', '2026-01-07 01:47:21'),
(16, 'specializations', 'ID#1 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Specialization', 'updated', 1, 'App\\Models\\User', 1, '[]', NULL, '2026-01-09 15:33:02', '2026-01-09 15:33:02'),
(17, 'project_submissions', 'ID#1 has been deleted by Aryanna Kertzmann [\"student\"]', 'App\\Models\\ProjectSubmission', 'deleted', 1, 'App\\Models\\User', 13, '[]', NULL, '2026-01-09 15:33:26', '2026-01-09 15:33:26'),
(18, 'specializations', 'ID#1 has been updated by Administrator [\"Super Admin\"]', 'App\\Models\\Specialization', 'updated', 1, 'App\\Models\\User', 1, '[]', NULL, '2026-01-09 15:35:48', '2026-01-09 15:35:48'),
(19, 'project_submissions', 'ID#2 has been created by Aryanna Kertzmann [\"student\"]', 'App\\Models\\ProjectSubmission', 'created', 2, 'App\\Models\\User', 13, '[]', NULL, '2026-01-09 16:50:32', '2026-01-09 16:50:32');

-- --------------------------------------------------------

--
-- بنية الجدول `conversations`
--

CREATE TABLE `conversations` (
  `id` bigint UNSIGNED NOT NULL,
  `type` enum('direct','project_group','admin_support') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'project_group',
  `project_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_message_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `conversations`
--

INSERT INTO `conversations` (`id`, `type`, `project_id`, `name`, `last_message_at`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'project_group', 2, 'Project Group: Smart Appointment Booking Platform', NULL, 1, '2026-01-07 01:46:03', '2026-01-07 01:46:03'),
(2, 'project_group', 1, 'Project Group: Enterprise Task Management System', '2026-01-09 15:27:56', 1, '2026-01-07 01:46:04', '2026-01-09 15:27:56'),
(3, 'admin_support', NULL, 'Support Chat - Antwan Robel DVM', '2026-01-09 22:32:40', 3, '2026-01-09 22:31:50', '2026-01-09 22:32:40');

-- --------------------------------------------------------

--
-- بنية الجدول `conversation_participants`
--

CREATE TABLE `conversation_participants` (
  `id` bigint UNSIGNED NOT NULL,
  `conversation_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `role` enum('admin','supervisor','student','member','user') COLLATE utf8mb4_unicode_ci NOT NULL,
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
(1, 1, 3, 'supervisor', 0, '2026-01-09 15:27:07', '2026-01-07 01:46:03', '2026-01-07 01:46:03', '2026-01-09 15:27:07'),
(2, 2, 3, 'supervisor', 0, '2026-01-09 15:27:08', '2026-01-07 01:46:05', '2026-01-07 01:46:05', '2026-01-09 15:27:08'),
(3, 1, 13, 'student', 0, '2026-01-07 01:47:39', '2026-01-07 01:46:18', '2026-01-07 01:46:18', '2026-01-07 01:47:39'),
(4, 2, 14, 'student', 0, '2026-01-09 15:31:02', '2026-01-07 01:46:32', '2026-01-07 01:46:32', '2026-01-09 15:31:02'),
(5, 2, 15, 'student', 2, NULL, '2026-01-07 01:46:33', '2026-01-07 01:46:33', '2026-01-07 01:46:33'),
(6, 3, 3, 'user', 0, '2026-01-09 22:32:20', '2026-01-09 22:31:50', '2026-01-09 22:31:50', '2026-01-09 22:32:20'),
(7, 3, 1, 'admin', 0, '2026-01-09 22:33:07', '2026-01-09 22:31:50', '2026-01-09 22:31:50', '2026-01-09 22:33:07');

-- --------------------------------------------------------

--
-- بنية الجدول `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint UNSIGNED NOT NULL,
  `currency_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thousand_separator` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `decimal_separator` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `currencies`
--

INSERT INTO `currencies` (`id`, `currency_name`, `code`, `symbol`, `thousand_separator`, `decimal_separator`, `exchange_rate`, `created_at`, `updated_at`) VALUES
(1, 'US Dollar', 'USD', '$', ',', '.', NULL, '2026-01-07 01:17:41', '2026-01-07 01:17:41');

-- --------------------------------------------------------

--
-- بنية الجدول `defenses`
--

CREATE TABLE `defenses` (
  `id` bigint UNSIGNED NOT NULL,
  `project_id` bigint UNSIGNED NOT NULL,
  `discussion_hall` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discussion_date` datetime NOT NULL,
  `discussion_type` enum('proposal','seminar','final') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('scheduled','completed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'scheduled',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

-- --------------------------------------------------------

--
-- بنية الجدول `departments`
--

CREATE TABLE `departments` (
  `id` bigint UNSIGNED NOT NULL,
  `short_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `departments`
--

INSERT INTO `departments` (`id`, `short_name`, `name`, `created_at`, `updated_at`) VALUES
(1, 'INF', 'Information Engineering', '2026-01-07 01:20:31', '2026-01-07 01:20:31');

-- --------------------------------------------------------

--
-- بنية الجدول `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `media`
--

CREATE TABLE `media` (
  `id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversions_disk` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint UNSIGNED NOT NULL,
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `generated_conversions` json NOT NULL,
  `responsive_images` json NOT NULL,
  `order_column` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `messages`
--

CREATE TABLE `messages` (
  `id` bigint UNSIGNED NOT NULL,
  `conversation_id` bigint UNSIGNED NOT NULL,
  `sender_id` bigint UNSIGNED DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('text','file','system') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `messages`
--

INSERT INTO `messages` (`id`, `conversation_id`, `sender_id`, `message`, `type`, `read_at`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'Project group chat created for: Smart Appointment Booking Platform', 'system', NULL, '2026-01-07 01:46:03', '2026-01-07 01:46:03'),
(2, 2, NULL, 'Project group chat created for: Enterprise Task Management System', 'system', NULL, '2026-01-07 01:46:04', '2026-01-07 01:46:04'),
(3, 2, 3, 'Hello', 'text', NULL, '2026-01-09 15:27:15', '2026-01-09 15:27:15'),
(4, 2, 3, 'i want to see what you have done', 'text', NULL, '2026-01-09 15:27:56', '2026-01-09 15:27:56'),
(5, 3, NULL, 'Support chat created. A Super Admin will assist you shortly.', 'system', NULL, '2026-01-09 22:31:50', '2026-01-09 22:31:50'),
(6, 3, 3, 'Hi, i\'ve facing a problem while displaying defenses', 'text', NULL, '2026-01-09 22:32:40', '2026-01-09 22:32:40');

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
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
(15, '2025_11_06_011930_create_specializations_table', 1),
(16, '2025_11_06_011937_create_departments_table', 1),
(17, '2025_11_06_033441_create_projects_table', 1),
(18, '2025_11_07_022733_create_project_assignments_table', 1),
(19, '2025_11_07_042105_create_defenses_table', 1),
(20, '2025_11_07_043048_create_defense_members_table', 1),
(21, '2025_11_09_003532_create_project_requests_table', 1),
(22, '2025_11_09_034213_create_project_submissions_table', 1),
(23, '2025_11_12_163218_add_code_link_to_project_submissions_table', 1),
(24, '2025_11_12_224803_create_notifications_table', 1),
(25, '2025_11_13_015808_create_conversations_table', 1),
(26, '2025_11_13_015816_create_conversation_participants_table', 1),
(27, '2025_11_13_015823_create_messages_table', 1),
(28, '2025_11_13_015847_create_message_reads_table', 1),
(29, '2025_11_13_130135_add_admin_support_type_to_conversations_table', 1),
(30, '2025_11_13_131245_add_user_role_to_conversation_participants_table', 1),
(31, '2026_01_04_015820_add_department_id_to_specializations_table', 1),
(32, '2026_01_04_023433_add_specialization_id_to_users_table', 1),
(33, '2026_01_07_032644_add_chapters_to_specializations_table', 1),
(34, '2026_01_07_041950_create_tasks_table', 2),
(35, '2026_01_09_192552_change_chapter_type_to_string_in_project_submissions_table', 3),
(36, '2026_01_09_194458_change_chapter_type_to_string_in_project_submissions', 3);

-- --------------------------------------------------------

--
-- بنية الجدول `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(5, 'App\\Models\\User', 3),
(5, 'App\\Models\\User', 4),
(5, 'App\\Models\\User', 5),
(5, 'App\\Models\\User', 6),
(5, 'App\\Models\\User', 7),
(5, 'App\\Models\\User', 8),
(5, 'App\\Models\\User', 9),
(5, 'App\\Models\\User', 10),
(5, 'App\\Models\\User', 11),
(5, 'App\\Models\\User', 12),
(4, 'App\\Models\\User', 13),
(4, 'App\\Models\\User', 14),
(4, 'App\\Models\\User', 15),
(4, 'App\\Models\\User', 16),
(4, 'App\\Models\\User', 17),
(4, 'App\\Models\\User', 18),
(4, 'App\\Models\\User', 19),
(4, 'App\\Models\\User', 20),
(4, 'App\\Models\\User', 21),
(4, 'App\\Models\\User', 22);

-- --------------------------------------------------------

--
-- بنية الجدول `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('1701256d-99c4-410d-95ce-c85650e2739a', 'App\\Notifications\\NewMessageNotification', 'App\\Models\\User', 15, '{\"type\":\"new_message\",\"title\":\"New Message\",\"message\":\"Antwan Robel DVM sent a message in Project Group: Enterprise Task Management System\",\"conversation_id\":2,\"conversation_name\":\"Project Group: Enterprise Task Management System\",\"conversation_type\":\"Project Chat\",\"message_id\":4,\"message_preview\":\"i want to see what you have done\",\"sender_id\":3,\"sender_name\":\"Antwan Robel DVM\",\"url\":\"\\/chat?conversation=2\",\"icon\":\"ri-message-2-line\",\"icon_color\":\"text-primary\"}', NULL, '2026-01-09 15:27:57', '2026-01-09 15:27:57'),
('1892667f-3085-46d3-aadf-a8d6e3972567', 'App\\Notifications\\NewMessageNotification', 'App\\Models\\User', 15, '{\"type\":\"new_message\",\"title\":\"New Message\",\"message\":\"Antwan Robel DVM sent a message in Project Group: Enterprise Task Management System\",\"conversation_id\":2,\"conversation_name\":\"Project Group: Enterprise Task Management System\",\"conversation_type\":\"Project Chat\",\"message_id\":3,\"message_preview\":\"Hello\",\"sender_id\":3,\"sender_name\":\"Antwan Robel DVM\",\"url\":\"\\/chat?conversation=2\",\"icon\":\"ri-message-2-line\",\"icon_color\":\"text-primary\"}', NULL, '2026-01-09 15:27:20', '2026-01-09 15:27:20'),
('2a425158-3e19-4217-bbc5-abcae322788a', 'App\\Notifications\\NewMessageNotification', 'App\\Models\\User', 14, '{\"type\":\"new_message\",\"title\":\"New Message\",\"message\":\"Antwan Robel DVM sent a message in Project Group: Enterprise Task Management System\",\"conversation_id\":2,\"conversation_name\":\"Project Group: Enterprise Task Management System\",\"conversation_type\":\"Project Chat\",\"message_id\":3,\"message_preview\":\"Hello\",\"sender_id\":3,\"sender_name\":\"Antwan Robel DVM\",\"url\":\"\\/chat?conversation=2\",\"icon\":\"ri-message-2-line\",\"icon_color\":\"text-primary\"}', '2026-01-09 15:30:57', '2026-01-09 15:27:20', '2026-01-09 15:30:57'),
('5535d646-2f9f-462f-87cf-3d19c2f55379', 'App\\Notifications\\ChapterSubmittedNotification', 'App\\Models\\User', 3, '{\"type\":\"chapter_submitted\",\"title\":\"New Chapter Submission\",\"message\":\"Aryanna Kertzmann submitted Full Paper for Smart Appointment Booking Platform\",\"submission_id\":2,\"project_id\":2,\"project_title\":\"Smart Appointment Booking Platform\",\"chapter_type\":\"Full Paper\",\"student_name\":\"Aryanna Kertzmann\",\"url\":\"\\/supervisor\\/supervised-projects\\/2\",\"icon\":\"ri-file-upload-line\",\"icon_color\":\"text-primary\"}', '2026-01-09 16:51:49', '2026-01-09 16:50:35', '2026-01-09 16:51:49'),
('a41e76f5-8f9c-48f2-aa30-aff7d29534db', 'App\\Notifications\\NewMessageNotification', 'App\\Models\\User', 1, '{\"type\":\"new_message\",\"title\":\"New Message\",\"message\":\"Antwan Robel DVM sent a message in Support Chat - Antwan Robel DVM\",\"conversation_id\":3,\"conversation_name\":\"Support Chat - Antwan Robel DVM\",\"conversation_type\":\"Admin Support\",\"message_id\":6,\"message_preview\":\"Hi, i\'ve facing a problem while displaying defenses\",\"sender_id\":3,\"sender_name\":\"Antwan Robel DVM\",\"url\":\"\\/chat?conversation=3\",\"icon\":\"ri-message-2-line\",\"icon_color\":\"text-primary\"}', '2026-01-09 22:33:03', '2026-01-09 22:32:43', '2026-01-09 22:33:03'),
('b30ae3e2-06b8-47ae-add9-1b7836c86351', 'App\\Notifications\\ChapterSubmittedNotification', 'App\\Models\\User', 3, '{\"type\":\"chapter_submitted\",\"title\":\"New Chapter Submission\",\"message\":\"Aryanna Kertzmann submitted Full Draft for Smart Appointment Booking Platform\",\"submission_id\":1,\"project_id\":2,\"project_title\":\"Smart Appointment Booking Platform\",\"chapter_type\":\"Full Draft\",\"student_name\":\"Aryanna Kertzmann\",\"url\":\"\\/supervisor\\/supervised-projects\\/2\",\"icon\":\"ri-file-upload-line\",\"icon_color\":\"text-primary\"}', NULL, '2026-01-07 01:47:26', '2026-01-07 01:47:26'),
('d76eec18-5a03-45c1-b199-fdd9fde8f887', 'App\\Notifications\\NewMessageNotification', 'App\\Models\\User', 14, '{\"type\":\"new_message\",\"title\":\"New Message\",\"message\":\"Antwan Robel DVM sent a message in Project Group: Enterprise Task Management System\",\"conversation_id\":2,\"conversation_name\":\"Project Group: Enterprise Task Management System\",\"conversation_type\":\"Project Chat\",\"message_id\":4,\"message_preview\":\"i want to see what you have done\",\"sender_id\":3,\"sender_name\":\"Antwan Robel DVM\",\"url\":\"\\/chat?conversation=2\",\"icon\":\"ri-message-2-line\",\"icon_color\":\"text-primary\"}', '2026-01-09 15:30:48', '2026-01-09 15:27:56', '2026-01-09 15:30:48');

-- --------------------------------------------------------

--
-- بنية الجدول `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` bigint UNSIGNED NOT NULL,
  `method_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'access_dashboard', 'web', '2026-01-07 01:17:43', '2026-01-07 01:17:43'),
(2, 'user_can_edit_own_profile', 'web', '2026-01-07 01:17:43', '2026-01-07 01:17:43'),
(3, 'access_user_management', 'web', '2026-01-07 01:17:43', '2026-01-07 01:17:43'),
(4, 'access_currencies', 'web', '2026-01-07 01:17:43', '2026-01-07 01:17:43'),
(5, 'access_reports', 'web', '2026-01-07 01:17:43', '2026-01-07 01:17:43'),
(6, 'access_activity_logs', 'web', '2026-01-07 01:17:43', '2026-01-07 01:17:43'),
(7, 'access_settings', 'web', '2026-01-07 01:17:43', '2026-01-07 01:17:43'),
(8, 'access_payment_methods', 'web', '2026-01-07 01:17:43', '2026-01-07 01:17:43'),
(9, 'access_specializations', 'web', '2026-01-07 01:17:43', '2026-01-07 01:17:43'),
(10, 'access_departments', 'web', '2026-01-07 01:17:43', '2026-01-07 01:17:43'),
(11, 'access_support_chats', 'web', '2026-01-07 01:17:43', '2026-01-07 01:17:43'),
(12, 'view_projects', 'web', '2026-01-07 01:17:44', '2026-01-07 01:17:44'),
(13, 'create_projects', 'web', '2026-01-07 01:17:44', '2026-01-07 01:17:44'),
(14, 'edit_projects', 'web', '2026-01-07 01:17:44', '2026-01-07 01:17:44'),
(15, 'delete_projects', 'web', '2026-01-07 01:17:44', '2026-01-07 01:17:44'),
(16, 'view_project_requests', 'web', '2026-01-07 01:17:44', '2026-01-07 01:17:44'),
(17, 'view_supervisors', 'web', '2026-01-07 01:17:44', '2026-01-07 01:17:44'),
(18, 'view_students', 'web', '2026-01-07 01:17:44', '2026-01-07 01:17:44'),
(19, 'view_assignments', 'web', '2026-01-07 01:17:45', '2026-01-07 01:17:45'),
(20, 'create_assignments', 'web', '2026-01-07 01:17:46', '2026-01-07 01:17:46'),
(21, 'edit_assignments', 'web', '2026-01-07 01:17:46', '2026-01-07 01:17:46'),
(22, 'delete_assignments', 'web', '2026-01-07 01:17:46', '2026-01-07 01:17:46'),
(23, 'assign_supervisors', 'web', '2026-01-07 01:17:46', '2026-01-07 01:17:46'),
(24, 'assign_students', 'web', '2026-01-07 01:17:46', '2026-01-07 01:17:46'),
(25, 'view_defenses', 'web', '2026-01-07 01:17:46', '2026-01-07 01:17:46'),
(26, 'create_defenses', 'web', '2026-01-07 01:17:46', '2026-01-07 01:17:46'),
(27, 'edit_defenses', 'web', '2026-01-07 01:17:46', '2026-01-07 01:17:46'),
(28, 'delete_defenses', 'web', '2026-01-07 01:17:46', '2026-01-07 01:17:46');

-- --------------------------------------------------------

--
-- بنية الجدول `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
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
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Semester, Graduation 1, Graduation 2',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Proposed, Approved, Rejected, Completed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `projects`
--

INSERT INTO `projects` (`id`, `specialization_id`, `department_id`, `title`, `description`, `project_type`, `created_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Enterprise Task Management System', '<p>Description: A comprehensive web application for managing tasks and projects within organizations, with integrated collaboration tools and reporting features.</p><p><br></p><p>Main Objectives:</p><ol><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>· Develop a user-friendly interface (React/Angular)</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>· Build a RESTful API using Node.js or Django</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>· Apply Agile methodologies in the development lifecycle</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>· Integrate real-time notification system (WebSockets)</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>· Write unit tests and integration tests</li></ol>', 'Semester', 3, 'Approved', '2026-01-07 01:45:07', '2026-01-07 01:46:04'),
(2, 1, 1, 'Smart Appointment Booking Platform', '<p>Description: An appointment booking system for clinics/companies with intelligent recommendations and resource management.</p><p><br></p><p>Main Objectives:</p><ol><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>· Design a complex relational database (MySQL/PostgreSQL)</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>· Implement software design patterns</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>· Ensure scalability and performance</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>· Set up CI/CD pipeline</li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>· Create comprehensive API documentation</li></ol>', 'Semester', 3, 'Approved', '2026-01-07 01:45:42', '2026-01-07 01:46:03');

-- --------------------------------------------------------

--
-- بنية الجدول `project_assignments`
--

CREATE TABLE `project_assignments` (
  `id` bigint UNSIGNED NOT NULL,
  `project_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `role` enum('supervisor','student') COLLATE utf8mb4_unicode_ci NOT NULL,
  `assigned_by` bigint UNSIGNED DEFAULT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `project_assignments`
--

INSERT INTO `project_assignments` (`id`, `project_id`, `user_id`, `role`, `assigned_by`, `assigned_at`, `created_at`, `updated_at`) VALUES
(1, 2, 3, 'supervisor', 1, '2026-01-07 01:46:03', '2026-01-07 01:46:03', '2026-01-07 01:46:03'),
(2, 1, 3, 'supervisor', 1, '2026-01-07 01:46:04', '2026-01-07 01:46:04', '2026-01-07 01:46:04'),
(3, 2, 13, 'student', 1, '2026-01-07 01:46:18', '2026-01-07 01:46:18', '2026-01-07 01:46:18'),
(4, 1, 14, 'student', 1, '2026-01-07 01:46:32', '2026-01-07 01:46:32', '2026-01-07 01:46:32'),
(5, 1, 15, 'student', 1, '2026-01-07 01:46:32', '2026-01-07 01:46:32', '2026-01-07 01:46:32');

-- --------------------------------------------------------

--
-- بنية الجدول `project_requests`
--

CREATE TABLE `project_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `project_id` bigint UNSIGNED NOT NULL,
  `student_id` bigint UNSIGNED NOT NULL,
  `request_type` enum('individual','group') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'individual',
  `group_members` json DEFAULT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `message` text COLLATE utf8mb4_unicode_ci,
  `reviewed_by` bigint UNSIGNED DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `project_submissions`
--

CREATE TABLE `project_submissions` (
  `id` bigint UNSIGNED NOT NULL,
  `project_id` bigint UNSIGNED NOT NULL,
  `uploaded_by` bigint UNSIGNED NOT NULL,
  `chapter_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `supervisor_feedback` text COLLATE utf8mb4_unicode_ci,
  `reviewed_by` bigint UNSIGNED DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `project_submissions`
--

INSERT INTO `project_submissions` (`id`, `project_id`, `uploaded_by`, `chapter_type`, `file_path`, `code_link`, `status`, `supervisor_feedback`, `reviewed_by`, `reviewed_at`, `created_at`, `updated_at`) VALUES
(2, 2, 13, 'Full Paper', 'project-submissions/DirIZyGhrOagFjz0YcR9bLOLVajWOzd0xI1KvVVt.pdf', NULL, 'pending', NULL, NULL, NULL, '2026-01-09 16:50:32', '2026-01-09 16:50:32');

-- --------------------------------------------------------

--
-- بنية الجدول `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'web', '2026-01-07 01:17:42', '2026-01-07 01:17:42'),
(2, 'Developer', 'web', '2026-01-07 01:17:42', '2026-01-07 01:17:42'),
(3, 'Admin', 'web', '2026-01-07 01:17:46', '2026-01-07 01:17:46'),
(4, 'student', 'web', '2025-11-05 12:56:51', '2025-11-05 12:56:51'),
(5, 'supervisor', 'web', '2025-11-05 12:56:51', '2025-11-05 12:56:51'),
(6, 'Project Admin', 'web', '2025-11-13 09:58:20', '2025-11-13 09:58:20');

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
(28, 3),
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
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_email_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_mobile_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notification_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer_text` text COLLATE utf8mb4_unicode_ci,
  `company_address` text COLLATE utf8mb4_unicode_ci,
  `vat_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_percentage` int DEFAULT NULL,
  `decimal_point` tinyint(1) NOT NULL DEFAULT '1',
  `date_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_zone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `settings`
--

INSERT INTO `settings` (`id`, `currency_id`, `company_name`, `company_email`, `company_email_2`, `company_mobile`, `company_mobile_2`, `currency_position`, `notification_email`, `footer_text`, `company_address`, `vat_id`, `tax_percentage`, `decimal_point`, `date_format`, `time_zone`, `time_format`, `created_at`, `updated_at`) VALUES
(1, 1, 'Cool Company', 'coolcompany@gmail.com', NULL, '1234567890', NULL, 'suffix_space', NULL, NULL, '123 Cool Street, Cool City, 12345', '', NULL, 1, 'DD-MM-YYYY', 'Asia/Dhaka', '12H', '2026-01-07 01:17:46', '2026-01-07 01:17:46');

-- --------------------------------------------------------

--
-- بنية الجدول `specializations`
--

CREATE TABLE `specializations` (
  `id` bigint UNSIGNED NOT NULL,
  `department_id` bigint UNSIGNED DEFAULT NULL,
  `short_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chapters` json DEFAULT NULL,
  `chapter_template_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `specializations`
--

INSERT INTO `specializations` (`id`, `department_id`, `short_name`, `name`, `chapters`, `chapter_template_path`, `created_at`, `updated_at`) VALUES
(1, 1, 'SWE', 'Software Engineering', '[\"Chapter 1 - Introduction\", \"Chapter 2 - Literature Review\", \"Chapter 3 - Project Management\", \"Chapter 4 - System Analysis\", \"Chapter 5 - System Design\", \"Chapter 6- Practical Implementation\", \"Chapter 7 - Conclusion\", \"Full Paper\"]', NULL, '2026-01-07 01:21:20', '2026-01-09 15:35:48'),
(2, 1, 'AI', 'Artifical Intelligence', '[\"Introduction\", \"Literature Review\", \"Methodology\", \"Result & Analysis\", \"Conclusion\", \"Abstract\", \"Full Draft\"]', NULL, '2026-01-07 01:21:32', '2026-01-07 01:21:32'),
(3, 1, 'CS', 'Cyber Security', '[\"Introduction\", \"Literature Review\", \"Methodology\", \"Result & Analysis\", \"Conclusion\", \"Abstract\", \"Full Draft\"]', NULL, '2026-01-07 01:22:46', '2026-01-07 01:22:46'),
(4, 1, 'NET', 'Network Engineering', '[\"Introduction\", \"Literature Review\", \"Methodology\", \"Result & Analysis\", \"Conclusion\", \"Abstract\", \"Full Draft\"]', NULL, '2026-01-07 01:23:00', '2026-01-07 01:23:00');

-- --------------------------------------------------------

--
-- بنية الجدول `uploads`
--

CREATE TABLE `uploads` (
  `id` bigint UNSIGNED NOT NULL,
  `folder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `specialization_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Male/Female',
  `date_of_birth` date DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `users`
--

INSERT INTO `users` (`id`, `specialization_id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `first_name`, `last_name`, `mobile`, `gender`, `date_of_birth`, `address`) VALUES
(1, NULL, 'Administrator', 'super.admin@test.com', NULL, '$2y$10$5KZif9tdsaWMM/OTd.sjvuMsE5ePmGQWXQkpnO0QQVtThLPzD8A8u', NULL, '2026-01-07 01:17:42', '2026-01-09 22:32:40', NULL, NULL, NULL, NULL, NULL, NULL),
(2, NULL, 'Developer', 'developer@test.com', NULL, '$2y$10$i.iHJJDOTEDXZdYhgsh9BeehyuDQiX1pwHiBXlhEN74v0uDQqBT7K', NULL, '2026-01-07 01:17:42', '2026-01-07 01:17:42', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 1, 'Antwan Robel DVM', 'corine.ortiz@example.com', '2026-01-07 01:37:31', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Zg2kiAJVcGZSsCXBvzacNXJjoDKIiAIwe8mBp2qeLPPTQhXM4HjX8RI9RoUA', '2026-01-07 01:37:31', '2026-01-07 01:38:58', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, 'Mrs. Cheyanne Hoeger MD', 'aurore.hill@example.org', '2026-01-07 01:37:31', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'HE6hNpGY1k', '2026-01-07 01:37:31', '2026-01-07 01:39:05', NULL, NULL, NULL, NULL, NULL, NULL),
(5, 2, 'Miller Cruickshank', 'shanna33@example.com', '2026-01-07 01:37:31', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'gnyRKtLMo5', '2026-01-07 01:37:32', '2026-01-07 01:39:13', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 3, 'Shanna Schaden', 'thalia.hudson@example.org', '2026-01-07 01:37:31', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'D224jX8PyA', '2026-01-07 01:37:32', '2026-01-07 01:39:19', NULL, NULL, NULL, NULL, NULL, NULL),
(7, 4, 'Dr. Teagan Collins', 'ywolff@example.com', '2026-01-07 01:37:31', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'XE5oEhqlCE', '2026-01-07 01:37:32', '2026-01-07 01:39:28', NULL, NULL, NULL, NULL, NULL, NULL),
(8, 4, 'Dr. Rollin Bogisich', 'regan41@example.com', '2026-01-07 01:37:31', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ufSdM7qfDr', '2026-01-07 01:37:32', '2026-01-07 01:39:34', NULL, NULL, NULL, NULL, NULL, NULL),
(9, 1, 'Palma Stracke', 'else92@example.org', '2026-01-07 01:37:31', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'uM0vWKac72', '2026-01-07 01:37:32', '2026-01-07 01:39:40', NULL, NULL, NULL, NULL, NULL, NULL),
(10, 2, 'Prof. Nigel Hammes', 'koby.parker@example.org', '2026-01-07 01:37:31', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'quXPZh1AOm', '2026-01-07 01:37:32', '2026-01-07 01:39:49', NULL, NULL, NULL, NULL, NULL, NULL),
(11, 3, 'Sadye Graham', 'jay69@example.com', '2026-01-07 01:37:31', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'gVwbAkyvDr', '2026-01-07 01:37:32', '2026-01-07 01:39:55', NULL, NULL, NULL, NULL, NULL, NULL),
(12, 4, 'Pauline Auer', 'braxton.nolan@example.com', '2026-01-07 01:37:31', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'r0Mnawn3pn', '2026-01-07 01:37:32', '2026-01-07 01:40:02', NULL, NULL, NULL, NULL, NULL, NULL),
(13, 1, 'Aryanna Kertzmann', 'myriam51@example.org', '2026-01-07 01:37:47', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '4OttPe6kdDaZOPomEDpzijgWPUcwOBaV0OQZAp5El4sqpxHVI8fEcsX3YNd5', '2026-01-07 01:37:48', '2026-01-07 01:38:47', NULL, NULL, NULL, NULL, NULL, NULL),
(14, 1, 'Stanford Emmerich', 'shanahan.alejandrin@example.org', '2026-01-07 01:37:48', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Ie5CkoOIeVrgYkHGeYIns9z6wZ2poBo1F2lCdAmQSE8YR6QbruEOWLDb1QCj', '2026-01-07 01:37:48', '2026-01-09 15:27:56', NULL, NULL, NULL, NULL, NULL, NULL),
(15, 1, 'Agnes Reichel', 'collier.verla@example.net', '2026-01-07 01:37:48', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 's2IJhHE1il', '2026-01-07 01:37:48', '2026-01-09 15:27:56', NULL, NULL, NULL, NULL, NULL, NULL),
(16, 1, 'Jadyn Boyle', 'mhickle@example.org', '2026-01-07 01:37:48', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'T6BTqSiKF7', '2026-01-07 01:37:48', '2026-01-07 01:40:34', NULL, NULL, NULL, NULL, NULL, NULL),
(17, 2, 'Hilda Kris', 'morar.kevin@example.net', '2026-01-07 01:37:48', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'sNsNE3639C', '2026-01-07 01:37:48', '2026-01-07 01:41:38', NULL, NULL, NULL, NULL, NULL, NULL),
(18, 4, 'Mandy Block', 'baby61@example.com', '2026-01-07 01:37:48', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'O4fyTFSb9A', '2026-01-07 01:37:48', '2026-01-07 01:41:29', NULL, NULL, NULL, NULL, NULL, NULL),
(19, 4, 'Ashly Leannon', 'christiansen.moises@example.org', '2026-01-07 01:37:48', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'SiOq8LKdBI', '2026-01-07 01:37:48', '2026-01-07 01:41:20', NULL, NULL, NULL, NULL, NULL, NULL),
(20, 4, 'Vaughn Zieme', 'nmante@example.com', '2026-01-07 01:37:48', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Wx6WnA2ylv', '2026-01-07 01:37:48', '2026-01-07 01:41:09', NULL, NULL, NULL, NULL, NULL, NULL),
(21, 2, 'Freda Bode IV', 'wrice@example.net', '2026-01-07 01:37:48', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'cORHNpq5p3', '2026-01-07 01:37:48', '2026-01-07 01:41:00', NULL, NULL, NULL, NULL, NULL, NULL),
(22, 3, 'Dr. Aurore VonRueden', 'joey.schoen@example.org', '2026-01-07 01:37:48', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'hCzQ1MXCiq', '2026-01-07 01:37:48', '2026-01-07 01:40:45', NULL, NULL, NULL, NULL, NULL, NULL);

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
  ADD UNIQUE KEY `specializations_short_name_unique` (`short_name`),
  ADD KEY `specializations_department_id_foreign` (`department_id`);

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
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_specialization_id_foreign` (`specialization_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `conversation_participants`
--
ALTER TABLE `conversation_participants`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `defenses`
--
ALTER TABLE `defenses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `defense_members`
--
ALTER TABLE `defense_members`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `message_reads`
--
ALTER TABLE `message_reads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `project_assignments`
--
ALTER TABLE `project_assignments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `project_requests`
--
ALTER TABLE `project_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_submissions`
--
ALTER TABLE `project_submissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `uploads`
--
ALTER TABLE `uploads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

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

--
-- قيود الجداول `specializations`
--
ALTER TABLE `specializations`
  ADD CONSTRAINT `specializations_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL;

--
-- قيود الجداول `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_specialization_id_foreign` FOREIGN KEY (`specialization_id`) REFERENCES `specializations` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
