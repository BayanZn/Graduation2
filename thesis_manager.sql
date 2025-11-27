-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- مضيف: localhost:3306
-- وقت الجيل: 26 نوفمبر 2025 الساعة 14:08
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
(2, 'App\\Models\\Setting', 1, '7b49c677-edd5-4e40-a117-c4b9505f1c7a', 'favicon', 'app-logo', '690b7b135ce6a1762360083.png', 'image/png', 'public', 'public', 13064, '[]', '[]', '[]', '[]', 2, '2025-11-05 15:58:03', '2025-11-05 15:58:03'),
(3, 'App\\Models\\User', 3, '04c24b9d-6d18-41a8-b0a9-7304ff593eaf', 'avatar', '690dc267c5d4a1762509415', '690dc267c5d4a1762509415.jpg', 'image/jpeg', 'public', 'public', 28634, '[]', '[]', '[]', '[]', 1, '2025-11-07 09:27:03', '2025-11-07 09:27:03');

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
(4, 'App\\Models\\User', 3),
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
(5, 'App\\Models\\User', 75);

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
('1ddab608-2f90-4c83-9419-542576ed32b9', 'App\\Notifications\\ChapterSubmittedNotification', 'App\\Models\\User', 54, '{\"type\":\"chapter_submitted\",\"title\":\"New Chapter Submission\",\"message\":\"Fahim Anzam Dip submitted Introduction for Real-Time Collaborative Code Editor\",\"submission_id\":2,\"project_id\":1,\"project_title\":\"Real-Time Collaborative Code Editor\",\"chapter_type\":\"Introduction\",\"student_name\":\"Fahim Anzam Dip\",\"url\":\"\\/supervisor\\/supervised-projects\\/1\",\"icon\":\"ri-file-upload-line\",\"icon_color\":\"text-primary\"}', NULL, '2025-11-12 17:46:07', '2025-11-12 17:46:07'),
('3a2cdc5f-89db-4ef2-b68c-b4f6ecf160c3', 'App\\Notifications\\ProjectAssignedNotification', 'App\\Models\\User', 6, '{\"type\":\"project_assigned\",\"title\":\"Project Assigned\",\"message\":\"You have been assigned to \\\"Test project\\\"\",\"project_id\":4,\"project_title\":\"Test project\",\"project_type\":\"Semester\",\"url\":\"\\/student\\/assigned-projects\\/4\",\"icon\":\"ri-folder-add-line\",\"icon_color\":\"text-success\"}', '2025-11-13 13:19:53', '2025-11-13 13:15:40', '2025-11-13 13:19:53'),
('54c2c1cc-faf4-4a39-ac3c-1c3469941292', 'App\\Notifications\\ProjectAssignedNotification', 'App\\Models\\User', 9, '{\"type\":\"project_assigned\",\"title\":\"Project Assigned\",\"message\":\"You have been assigned to \\\"Test project\\\"\",\"project_id\":4,\"project_title\":\"Test project\",\"project_type\":\"Semester\",\"url\":\"\\/student\\/assigned-projects\\/4\",\"icon\":\"ri-folder-add-line\",\"icon_color\":\"text-success\"}', NULL, '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
('75201533-1655-422b-a04e-8500432ff771', 'App\\Notifications\\ProjectAssignedNotification', 'App\\Models\\User', 11, '{\"type\":\"project_assigned\",\"title\":\"Project Assigned\",\"message\":\"You have been assigned to \\\"Test project\\\"\",\"project_id\":4,\"project_title\":\"Test project\",\"project_type\":\"Semester\",\"url\":\"\\/student\\/assigned-projects\\/4\",\"icon\":\"ri-folder-add-line\",\"icon_color\":\"text-success\"}', NULL, '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
('7a4d4d83-839c-4a8e-bb80-98a2e317dc89', 'App\\Notifications\\SupervisorAssignedNotification', 'App\\Models\\User', 54, '{\"type\":\"supervisor_assigned\",\"title\":\"New Supervision Assignment\",\"message\":\"You have been assigned as supervisor for \\\"Test project\\\"\",\"project_id\":4,\"project_title\":\"Test project\",\"project_type\":\"Semester\",\"url\":\"\\/supervisor\\/supervised-projects\\/4\",\"icon\":\"ri-user-star-line\",\"icon_color\":\"text-primary\"}', NULL, '2025-11-13 13:15:40', '2025-11-13 13:15:40'),
('9d513626-c50a-4931-ac66-9eec14c90ba4', 'App\\Notifications\\ChapterSubmittedNotification', 'App\\Models\\User', 75, '{\"type\":\"chapter_submitted\",\"title\":\"New Chapter Submission\",\"message\":\"Fahim Anzam Dip submitted Result & Analysis for IoT Network Intrusion Detection System\",\"submission_id\":5,\"project_id\":2,\"project_title\":\"IoT Network Intrusion Detection System\",\"chapter_type\":\"Result & Analysis\",\"student_name\":\"Fahim Anzam Dip\",\"url\":\"\\/supervisor\\/supervised-projects\\/2\",\"icon\":\"ri-file-upload-line\",\"icon_color\":\"text-primary\"}', NULL, '2025-11-13 13:19:30', '2025-11-13 13:19:30'),
('9dbff486-32e5-43a3-8d1d-b5dd5747ac90', 'App\\Notifications\\ChapterSubmittedNotification', 'App\\Models\\User', 55, '{\"type\":\"chapter_submitted\",\"title\":\"New Chapter Submission\",\"message\":\"Fahim Anzam Dip submitted Introduction for Real-Time Collaborative Code Editor\",\"submission_id\":2,\"project_id\":1,\"project_title\":\"Real-Time Collaborative Code Editor\",\"chapter_type\":\"Introduction\",\"student_name\":\"Fahim Anzam Dip\",\"url\":\"\\/supervisor\\/supervised-projects\\/1\",\"icon\":\"ri-file-upload-line\",\"icon_color\":\"text-primary\"}', NULL, '2025-11-12 17:46:07', '2025-11-12 17:46:07'),
('c6827f06-53f3-46fa-a2a1-bd58bf34979a', 'App\\Notifications\\ChapterSubmittedNotification', 'App\\Models\\User', 75, '{\"type\":\"chapter_submitted\",\"title\":\"New Chapter Submission\",\"message\":\"Fahim Anzam Dip submitted Literature Review for IoT Network Intrusion Detection System\",\"submission_id\":3,\"project_id\":2,\"project_title\":\"IoT Network Intrusion Detection System\",\"chapter_type\":\"Literature Review\",\"student_name\":\"Fahim Anzam Dip\",\"url\":\"\\/supervisor\\/supervised-projects\\/2\",\"icon\":\"ri-file-upload-line\",\"icon_color\":\"text-primary\"}', '2025-11-12 18:03:08', '2025-11-12 17:46:52', '2025-11-12 18:03:08'),
('f5700ef9-2d87-42cf-8196-077366b48143', 'App\\Notifications\\ChapterSubmittedNotification', 'App\\Models\\User', 75, '{\"type\":\"chapter_submitted\",\"title\":\"New Chapter Submission\",\"message\":\"Fahim Anzam Dip submitted Methodology for IoT Network Intrusion Detection System\",\"submission_id\":4,\"project_id\":2,\"project_title\":\"IoT Network Intrusion Detection System\",\"chapter_type\":\"Methodology\",\"student_name\":\"Fahim Anzam Dip\",\"url\":\"\\/supervisor\\/supervised-projects\\/2\",\"icon\":\"ri-file-upload-line\",\"icon_color\":\"text-primary\"}', '2025-11-13 13:20:25', '2025-11-12 18:07:34', '2025-11-13 13:20:25');

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
(27, 6);

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
(2, 'Developer', 'developer@test.com', NULL, '$2y$10$Zmbvo8OdCKE0Ts8Bp/xCHOeYgJGV0SN9y2dPT7a/KfWsGoG0HX4Pa', NULL, '2025-11-05 15:55:51', '2025-11-05 15:55:51', NULL, NULL, NULL, NULL, NULL, NULL);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `conversation_participants`
--
ALTER TABLE `conversation_participants`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `defenses`
--
ALTER TABLE `defenses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `defense_members`
--
ALTER TABLE `defense_members`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `project_assignments`
--
ALTER TABLE `project_assignments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `project_requests`
--
ALTER TABLE `project_requests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `uploads`
--
ALTER TABLE `uploads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

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
