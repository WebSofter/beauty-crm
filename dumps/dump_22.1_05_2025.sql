-- --------------------------------------------------------
-- Хост:                         localhost
-- Версия сервера:               8.0.42 - MySQL Community Server - GPL
-- Операционная система:         Linux
-- HeidiSQL Версия:              12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Дамп структуры для таблица django_db.appointment_appointment
CREATE TABLE IF NOT EXISTS `appointment_appointment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `start_time` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `status` varchar(10) NOT NULL,
  `notes` longtext,
  `client_id` bigint NOT NULL,
  `service_id` bigint DEFAULT NULL,
  `worker_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appointment_appointm_client_id_9829a0eb_fk_profile_c` (`client_id`),
  KEY `appointment_appointm_service_id_c235daf3_fk_service_s` (`service_id`),
  KEY `appointment_appointm_worker_id_7bec2fd1_fk_profile_w` (`worker_id`),
  CONSTRAINT `appointment_appointm_client_id_9829a0eb_fk_profile_c` FOREIGN KEY (`client_id`) REFERENCES `profile_clientprofile` (`id`),
  CONSTRAINT `appointment_appointm_service_id_c235daf3_fk_service_s` FOREIGN KEY (`service_id`) REFERENCES `service_service` (`id`),
  CONSTRAINT `appointment_appointm_worker_id_7bec2fd1_fk_profile_w` FOREIGN KEY (`worker_id`) REFERENCES `profile_workerprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.appointment_appointment: ~7 rows (приблизительно)
INSERT INTO `appointment_appointment` (`id`, `start_time`, `created_at`, `status`, `notes`, `client_id`, `service_id`, `worker_id`) VALUES
	(2, '2025-09-13 13:07:00.000000', '2025-05-21 00:34:39.530235', 'confirmed', '3укака', 7, 10, 1),
	(3, '2025-05-22 15:00:00.000000', '2025-05-21 09:41:02.155635', 'pending', 'Записался', 7, 23, 1),
	(4, '2025-05-22 15:00:00.000000', '2025-05-21 09:41:39.834569', 'pending', 'Записался', 7, 23, 1),
	(5, '2025-05-15 16:00:00.000000', '2025-05-21 09:43:40.945073', 'pending', 'Записался', 7, 9, 1),
	(6, '2025-05-15 19:00:00.000000', '2025-05-21 09:45:48.771009', 'pending', 'Записался', 7, 4, 1),
	(7, '2025-05-23 10:35:00.000000', '2025-05-21 10:13:56.008779', 'pending', 'Запись на 23', 7, 33, 3),
	(8, '2025-05-23 10:35:00.000000', '2025-05-21 10:14:36.012740', 'completed', 'Запись на 23', 7, 33, 3),
	(9, '2025-05-28 13:00:00.000000', '2025-05-22 14:46:32.246151', 'completed', 'Хочу укладку волос', 8, 9, 4),
	(10, '2025-05-29 12:00:00.000000', '2025-05-22 15:54:50.440441', 'completed', 'Хочу крутую прическу', 9, 10, 1);

-- Дамп структуры для таблица django_db.appointment_review
CREATE TABLE IF NOT EXISTS `appointment_review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rating` int NOT NULL,
  `comment` longtext,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `appointment_id` bigint NOT NULL,
  `client_id` bigint NOT NULL,
  `worker_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appointment_review_client_id_appointment_id_abb1a8b5_uniq` (`client_id`,`appointment_id`),
  KEY `idx_review_client` (`client_id`),
  KEY `idx_review_worker` (`worker_id`),
  KEY `idx_review_appointment` (`appointment_id`),
  CONSTRAINT `appointment_review_appointment_id_84e5c896_fk_appointme` FOREIGN KEY (`appointment_id`) REFERENCES `appointment_appointment` (`id`),
  CONSTRAINT `appointment_review_client_id_9ded1104_fk_profile_c` FOREIGN KEY (`client_id`) REFERENCES `profile_clientprofile` (`id`),
  CONSTRAINT `appointment_review_worker_id_2e40d9e1_fk_profile_w` FOREIGN KEY (`worker_id`) REFERENCES `profile_workerprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.appointment_review: ~0 rows (приблизительно)
INSERT INTO `appointment_review` (`id`, `rating`, `comment`, `created_at`, `updated_at`, `appointment_id`, `client_id`, `worker_id`) VALUES
	(5, 4, 'Процедура была выполнена профессионально, мастер внимательно подошёл к индивидуальным особенностям, что позволило полностью расслабиться и снять напряжение. Атмосфера в салоне спокойная и уютная, что дополнительно способствовало комфортному отдыху. ', '2025-05-22 11:34:16.952064', '2025-05-22 11:34:16.952080', 8, 7, 3),
	(6, 5, 'Укладка волос в салоне превзошла все ожидания! Мастер профессионально и аккуратно выполнил работу, волосы легли идеально, сохраняя форму даже на следующий день без дополнительной укладки. Результат выглядит естественно и стильно, при этом мастер дал полезные советы по уходу и укладке дома.', '2025-05-22 15:18:57.124056', '2025-05-22 15:18:57.124073', 9, 8, 4),
	(7, 4, 'Очень доволен новой прической! Мастер учёл все мои пожелания, результат получился стильным и аккуратным. Волосы выглядят ухоженно и держат форму целый день. Атмосфера в салоне приятная, обслуживание на высшем уровне. Обязательно вернусь ещё раз! :)', '2025-05-22 16:00:59.482999', '2025-05-22 16:00:59.483016', 10, 9, 1);

-- Дамп структуры для таблица django_db.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.auth_group: ~0 rows (приблизительно)

-- Дамп структуры для таблица django_db.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.auth_group_permissions: ~0 rows (приблизительно)

-- Дамп структуры для таблица django_db.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.auth_permission: ~80 rows (приблизительно)
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can view log entry', 1, 'view_logentry'),
	(5, 'Can add permission', 2, 'add_permission'),
	(6, 'Can change permission', 2, 'change_permission'),
	(7, 'Can delete permission', 2, 'delete_permission'),
	(8, 'Can view permission', 2, 'view_permission'),
	(9, 'Can add group', 3, 'add_group'),
	(10, 'Can change group', 3, 'change_group'),
	(11, 'Can delete group', 3, 'delete_group'),
	(12, 'Can view group', 3, 'view_group'),
	(13, 'Can add user', 4, 'add_user'),
	(14, 'Can change user', 4, 'change_user'),
	(15, 'Can delete user', 4, 'delete_user'),
	(16, 'Can view user', 4, 'view_user'),
	(17, 'Can add content type', 5, 'add_contenttype'),
	(18, 'Can change content type', 5, 'change_contenttype'),
	(19, 'Can delete content type', 5, 'delete_contenttype'),
	(20, 'Can view content type', 5, 'view_contenttype'),
	(21, 'Can add session', 6, 'add_session'),
	(22, 'Can change session', 6, 'change_session'),
	(23, 'Can delete session', 6, 'delete_session'),
	(24, 'Can view session', 6, 'view_session'),
	(25, 'Can add client', 7, 'add_client'),
	(26, 'Can change client', 7, 'change_client'),
	(27, 'Can delete client', 7, 'delete_client'),
	(28, 'Can view client', 7, 'view_client'),
	(29, 'Can add comment', 8, 'add_comment'),
	(30, 'Can change comment', 8, 'change_comment'),
	(31, 'Can delete comment', 8, 'delete_comment'),
	(32, 'Can view comment', 8, 'view_comment'),
	(33, 'Can add client file', 9, 'add_clientfile'),
	(34, 'Can change client file', 9, 'change_clientfile'),
	(35, 'Can delete client file', 9, 'delete_clientfile'),
	(36, 'Can view client file', 9, 'view_clientfile'),
	(37, 'Can add lead', 10, 'add_lead'),
	(38, 'Can change lead', 10, 'change_lead'),
	(39, 'Can delete lead', 10, 'delete_lead'),
	(40, 'Can view lead', 10, 'view_lead'),
	(41, 'Can add comment', 11, 'add_comment'),
	(42, 'Can change comment', 11, 'change_comment'),
	(43, 'Can delete comment', 11, 'delete_comment'),
	(44, 'Can view comment', 11, 'view_comment'),
	(45, 'Can add lead file', 12, 'add_leadfile'),
	(46, 'Can change lead file', 12, 'change_leadfile'),
	(47, 'Can delete lead file', 12, 'delete_leadfile'),
	(48, 'Can view lead file', 12, 'view_leadfile'),
	(49, 'Can add team', 13, 'add_team'),
	(50, 'Can change team', 13, 'change_team'),
	(51, 'Can delete team', 13, 'delete_team'),
	(52, 'Can view team', 13, 'view_team'),
	(53, 'Can add plan', 14, 'add_plan'),
	(54, 'Can change plan', 14, 'change_plan'),
	(55, 'Can delete plan', 14, 'delete_plan'),
	(56, 'Can view plan', 14, 'view_plan'),
	(57, 'Can add userprofile', 15, 'add_userprofile'),
	(58, 'Can change userprofile', 15, 'change_userprofile'),
	(59, 'Can delete userprofile', 15, 'delete_userprofile'),
	(60, 'Can view userprofile', 15, 'view_userprofile'),
	(61, 'Can add service', 16, 'add_service'),
	(62, 'Can change service', 16, 'change_service'),
	(63, 'Can delete service', 16, 'delete_service'),
	(64, 'Can view service', 16, 'view_service'),
	(65, 'Can add service category', 17, 'add_servicecategory'),
	(66, 'Can change service category', 17, 'change_servicecategory'),
	(67, 'Can delete service category', 17, 'delete_servicecategory'),
	(68, 'Can view service category', 17, 'view_servicecategory'),
	(69, 'Can add worker profile', 18, 'add_workerprofile'),
	(70, 'Can change worker profile', 18, 'change_workerprofile'),
	(71, 'Can delete worker profile', 18, 'delete_workerprofile'),
	(72, 'Can view worker profile', 18, 'view_workerprofile'),
	(73, 'Can add client profile', 19, 'add_clientprofile'),
	(74, 'Can change client profile', 19, 'change_clientprofile'),
	(75, 'Can delete client profile', 19, 'delete_clientprofile'),
	(76, 'Can view client profile', 19, 'view_clientprofile'),
	(77, 'Can add position', 20, 'add_position'),
	(78, 'Can change position', 20, 'change_position'),
	(79, 'Can delete position', 20, 'delete_position'),
	(80, 'Can view position', 20, 'view_position'),
	(81, 'Can add appointment', 21, 'add_appointment'),
	(82, 'Can change appointment', 21, 'change_appointment'),
	(83, 'Can delete appointment', 21, 'delete_appointment'),
	(84, 'Can view appointment', 21, 'view_appointment'),
	(85, 'Can add Выплата зарплаты', 22, 'add_payment'),
	(86, 'Can change Выплата зарплаты', 22, 'change_payment'),
	(87, 'Can delete Выплата зарплаты', 22, 'delete_payment'),
	(88, 'Can view Выплата зарплаты', 22, 'view_payment'),
	(89, 'Can add review', 23, 'add_review'),
	(90, 'Can change review', 23, 'change_review'),
	(91, 'Can delete review', 23, 'delete_review'),
	(92, 'Can view review', 23, 'view_review'),
	(93, 'Can add review', 24, 'add_review'),
	(94, 'Can change review', 24, 'change_review'),
	(95, 'Can delete review', 24, 'delete_review'),
	(96, 'Can view review', 24, 'view_review');

-- Дамп структуры для таблица django_db.auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.auth_user: ~9 rows (приблизительно)
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$1000000$wgLekuZsnbFjfIxyV7GBpe$EsNC6pm6lN2tUngxgtfxvWJ4e92FHON+FWftMxyrMro=', '2025-05-22 15:59:10.304851', 1, 'django_admin', 'Django', 'Admin', 'django_admin@gmail.com', 1, 1, '2025-05-07 06:48:55.399954'),
	(2, 'pbkdf2_sha256$1000000$wgLekuZsnbFjfIxyV7GBpe$EsNC6pm6lN2tUngxgtfxvWJ4e92FHON+FWftMxyrMro=', NULL, 0, 'ivan', 'Иван', 'Самойлов', 'mail.websofter@yandex.ru', 0, 1, '2025-05-18 13:17:54.473042'),
	(4, 'pbkdf2_sha256$1000000$wgLekuZsnbFjfIxyV7GBpe$EsNC6pm6lN2tUngxgtfxvWJ4e92FHON+FWftMxyrMro=', '2025-05-22 06:39:12.017618', 0, 'Irina', 'Ирина', 'Роднина', 'mail.websofter1@yandex.ru', 0, 1, '2025-05-18 13:21:01.668706'),
	(5, 'pbkdf2_sha256$1000000$wgLekuZsnbFjfIxyV7GBpe$EsNC6pm6lN2tUngxgtfxvWJ4e92FHON+FWftMxyrMro=', NULL, 0, 'sergey', 'Сергей', 'Леонов', 'mail.websofter2@yandex.ru', 0, 1, '2025-05-18 13:45:11.081494'),
	(6, 'pbkdf2_sha256$1000000$wgLekuZsnbFjfIxyV7GBpe$EsNC6pm6lN2tUngxgtfxvWJ4e92FHON+FWftMxyrMro=', '2025-05-22 15:24:54.459532', 0, 'andrey_master', 'Андрей', 'Ларин', 'mail.websofter3@yandex.ru', 0, 1, '2025-05-18 13:50:32.374432'),
	(7, 'pbkdf2_sha256$1000000$wgLekuZsnbFjfIxyV7GBpe$EsNC6pm6lN2tUngxgtfxvWJ4e92FHON+FWftMxyrMro=', '2025-05-22 06:40:39.466102', 0, 'newuser', 'Ганимед', 'Венедикт', 'Admin@mail.ru', 0, 1, '2025-05-18 16:28:41.689582'),
	(8, 'pbkdf2_sha256$1000000$wgLekuZsnbFjfIxyV7GBpe$EsNC6pm6lN2tUngxgtfxvWJ4e92FHON+FWftMxyrMro=', NULL, 0, 'sergei', 'Сергей', 'Серов', 'test-buyer@mail.ru', 0, 1, '2025-05-18 17:12:15.981801'),
	(9, 'pbkdf2_sha256$1000000$wgLekuZsnbFjfIxyV7GBpe$EsNC6pm6lN2tUngxgtfxvWJ4e92FHON+FWftMxyrMro=', NULL, 0, 'pasha', 'Паша', 'Техник', 'retgtg@rtgt.ru', 0, 1, '2025-05-18 17:26:51.651678'),
	(10, 'pbkdf2_sha256$1000000$wgLekuZsnbFjfIxyV7GBpe$EsNC6pm6lN2tUngxgtfxvWJ4e92FHON+FWftMxyrMro=', NULL, 0, 'ilya', 'Илья', 'Казанец', 'base_TelAviv@mail.ru', 0, 1, '2025-05-18 17:31:04.599734'),
	(12, 'pbkdf2_sha256$1000000$wgLekuZsnbFjfIxyV7GBpe$EsNC6pm6lN2tUngxgtfxvWJ4e92FHON+FWftMxyrMro=', '2025-05-22 07:26:49.007397', 0, 'gosha', 'Гоша', 'Махавин', 'mail.websofter@gmail.com', 0, 1, '2025-05-18 17:49:45.984048'),
	(13, 'pbkdf2_sha256$1000000$wgLekuZsnbFjfIxyV7GBpe$EsNC6pm6lN2tUngxgtfxvWJ4e92FHON+FWftMxyrMro=', '2025-05-22 15:15:43.428913', 0, 'bill_client', 'Бил', 'Гейтц', 'mail.beeway@gmail.com', 0, 1, '2025-05-22 12:37:57.828392'),
	(15, 'pbkdf2_sha256$1000000$wgLekuZsnbFjfIxyV7GBpe$EsNC6pm6lN2tUngxgtfxvWJ4e92FHON+FWftMxyrMro=', '2025-05-22 15:59:56.878601', 0, 'petia', 'Петя', '', 'mail.websofter@gmail.com', 0, 1, '2025-05-22 15:54:48.404994');

-- Дамп структуры для таблица django_db.auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.auth_user_groups: ~0 rows (приблизительно)

-- Дамп структуры для таблица django_db.auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.auth_user_user_permissions: ~0 rows (приблизительно)

-- Дамп структуры для таблица django_db.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.django_admin_log: ~0 rows (приблизительно)

-- Дамп структуры для таблица django_db.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.django_content_type: ~20 rows (приблизительно)
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(21, 'appointment', 'appointment'),
	(24, 'appointment', 'review'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(7, 'client', 'client'),
	(9, 'client', 'clientfile'),
	(8, 'client', 'comment'),
	(5, 'contenttypes', 'contenttype'),
	(11, 'lead', 'comment'),
	(10, 'lead', 'lead'),
	(12, 'lead', 'leadfile'),
	(22, 'payment', 'payment'),
	(19, 'profile', 'clientprofile'),
	(20, 'profile', 'position'),
	(18, 'profile', 'workerprofile'),
	(23, 'service', 'review'),
	(16, 'service', 'service'),
	(17, 'service', 'servicecategory'),
	(6, 'sessions', 'session'),
	(14, 'team', 'plan'),
	(13, 'team', 'team'),
	(15, 'userprofile', 'userprofile');

-- Дамп структуры для таблица django_db.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.django_migrations: ~48 rows (приблизительно)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2025-05-07 06:47:27.113803'),
	(2, 'auth', '0001_initial', '2025-05-07 06:47:27.551510'),
	(3, 'admin', '0001_initial', '2025-05-07 06:47:27.663836'),
	(4, 'admin', '0002_logentry_remove_auto_add', '2025-05-07 06:47:27.670388'),
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-05-07 06:47:27.676824'),
	(6, 'contenttypes', '0002_remove_content_type_name', '2025-05-07 06:47:27.769919'),
	(7, 'auth', '0002_alter_permission_name_max_length', '2025-05-07 06:47:27.829869'),
	(8, 'auth', '0003_alter_user_email_max_length', '2025-05-07 06:47:27.848017'),
	(9, 'auth', '0004_alter_user_username_opts', '2025-05-07 06:47:27.856893'),
	(10, 'auth', '0005_alter_user_last_login_null', '2025-05-07 06:47:27.901622'),
	(11, 'auth', '0006_require_contenttypes_0002', '2025-05-07 06:47:27.905609'),
	(12, 'auth', '0007_alter_validators_add_error_messages', '2025-05-07 06:47:27.912994'),
	(13, 'auth', '0008_alter_user_username_max_length', '2025-05-07 06:47:27.966643'),
	(14, 'auth', '0009_alter_user_last_name_max_length', '2025-05-07 06:47:28.035732'),
	(15, 'auth', '0010_alter_group_name_max_length', '2025-05-07 06:47:28.060224'),
	(16, 'auth', '0011_update_proxy_permissions', '2025-05-07 06:47:28.073209'),
	(17, 'auth', '0012_alter_user_first_name_max_length', '2025-05-07 06:47:28.141815'),
	(18, 'team', '0001_initial', '2025-05-07 06:47:28.430696'),
	(19, 'team', '0002_plan', '2025-05-07 06:47:28.449013'),
	(20, 'team', '0003_team_plan', '2025-05-07 06:47:28.528773'),
	(21, 'client', '0001_initial', '2025-05-07 06:47:28.603679'),
	(22, 'client', '0002_client_team', '2025-05-07 06:47:28.666157'),
	(23, 'client', '0003_alter_client_options', '2025-05-07 06:47:28.674284'),
	(24, 'client', '0004_comment', '2025-05-07 06:47:28.896661'),
	(25, 'client', '0005_clientfile', '2025-05-07 06:47:29.058257'),
	(26, 'lead', '0001_initial', '2025-05-07 06:47:29.128159'),
	(27, 'lead', '0002_lead_converted_to_client', '2025-05-07 06:47:29.177169'),
	(28, 'lead', '0003_lead_team', '2025-05-07 06:47:29.247972'),
	(29, 'lead', '0004_alter_lead_options', '2025-05-07 06:47:29.257816'),
	(30, 'lead', '0005_comment', '2025-05-07 06:47:29.416379'),
	(31, 'lead', '0006_leadfile', '2025-05-07 06:47:29.571553'),
	(32, 'sessions', '0001_initial', '2025-05-07 06:47:29.604681'),
	(33, 'team', '0004_alter_team_plan', '2025-05-07 06:47:29.733549'),
	(34, 'userprofile', '0001_initial', '2025-05-07 06:47:29.812763'),
	(35, 'userprofile', '0002_userprofile_active_team', '2025-05-07 06:47:29.874721'),
	(36, 'service', '0001_initial', '2025-05-16 14:16:24.960715'),
	(37, 'profile', '0001_initial', '2025-05-18 09:24:44.270969'),
	(38, 'profile', '0002_position_gender', '2025-05-18 11:03:36.036315'),
	(39, 'profile', '0003_remove_workerprofile_position_workerprofile_position', '2025-05-18 11:36:52.532643'),
	(40, 'profile', '0004_alter_clientprofile_user_alter_workerprofile_user', '2025-05-18 13:43:27.253253'),
	(41, 'profile', '0005_alter_position_gender', '2025-05-18 19:50:27.370221'),
	(42, 'appointment', '0001_initial', '2025-05-18 19:50:27.637090'),
	(43, 'payment', '0001_initial', '2025-05-18 23:39:15.331284'),
	(44, 'service', 'manually_add_gender_field', '2025-05-19 06:34:27.023765'),
	(45, 'profile', '0006_clientprofile_bonuses_workerprofile_bonuses', '2025-05-21 18:19:17.526044'),
	(46, 'profile', '0007_workerprofile_salary', '2025-05-22 00:14:36.459284'),
	(47, 'payment', '0002_remove_payment_period_end_and_more', '2025-05-22 02:11:36.674344'),
	(49, 'appointment', '0002_review', '2025-05-22 08:54:25.183831');

-- Дамп структуры для таблица django_db.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.django_session: ~2 rows (приблизительно)
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('gbkwzbaf3l8dhod7pc268z9anwgefrx1', '.eJxVjEsOgzAMBe-SdRU5hoTQZfecAdlx3NBWIPFZVb17QWLRbmfmvbfpaVtLvy157gcxV-O8ufxCpvTM42HkQeN9smka13lgeyT2tIvtJsmv29n-HRRayr4O0gK7VEtgCBogo0dgD9F5xYoVm4RRELSpIzRatdQS7rhytYoymc8X9aA38w:1uI8Kq:IZWyqfcRI03oCxoj12D0dV0j9UN8infQriuQ4cNi-BM', '2025-06-05 15:59:56.882316'),
	('op6m8e8u1k5g90mjdg7cn4yhle45b9mq', '.eJxVjE0OwiAYBe_C2hAKKRSX7j0D-f6QqoGktCvj3bVJF7p9M_NeKsG2lrR1WdLM6qwGdfrdEOghdQd8h3prmlpdlxn1ruiDdn1tLM_L4f4dFOjlW0fOLiPxiIiGWLIJFr2dWMA6Y4JDQogxRMhgvCBOzlHGwCMbHnxU7w8qyzl1:1uCYgz:5pp6cx_hW4MtZDwXsrkGkQ4_rfPm0JhfbZlbkjuAyZ4', '2025-05-21 06:55:45.707031');

-- Дамп структуры для таблица django_db.payment_payment
CREATE TABLE IF NOT EXISTS `payment_payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` date NOT NULL,
  `comment` longtext,
  `worker_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_payment_worker_id_a9644289_fk_profile_workerprofile_id` (`worker_id`),
  CONSTRAINT `payment_payment_worker_id_a9644289_fk_profile_workerprofile_id` FOREIGN KEY (`worker_id`) REFERENCES `profile_workerprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.payment_payment: ~0 rows (приблизительно)
INSERT INTO `payment_payment` (`id`, `amount`, `payment_date`, `comment`, `worker_id`) VALUES
	(1, 3000.00, '2025-05-22', 'Выплачен аванс', 1);

-- Дамп структуры для таблица django_db.profile_clientprofile
CREATE TABLE IF NOT EXISTS `profile_clientprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) NOT NULL,
  `address` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `notes` longtext NOT NULL,
  `user_id` int DEFAULT NULL,
  `bonuses` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `profile_clientprofile_user_id_d82fdf84_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.profile_clientprofile: ~4 rows (приблизительно)
INSERT INTO `profile_clientprofile` (`id`, `phone`, `address`, `created_at`, `updated_at`, `notes`, `user_id`, `bonuses`) VALUES
	(1, '9999999999', 'Some address', '2025-05-18 17:12:16.592561', '2025-05-18 17:23:03.791460', 'Some comment', 8, 0),
	(3, '9253826214', 'Test ул дом 1 кор 3 кв 70', '2025-05-18 17:26:52.293604', '2025-05-18 17:26:52.293632', 'rtgtrg', 9, 0),
	(5, '9253826214', 'г Москва, ул Грина, д 1 к', '2025-05-18 17:31:05.159905', '2025-05-18 17:31:05.159926', '', 10, 0),
	(7, '9999999998', 'г Москва, ул Грина, д 1 к', '2025-05-18 17:49:46.508436', '2025-05-18 17:49:46.508457', 'Note some', 12, 0),
	(8, '9253826214', 'г Москва, ул Грина, д 1 к', '2025-05-22 12:37:58.337094', '2025-05-22 14:38:41.304030', 'Разработчик Windows', 13, 0),
	(9, '9999999999', '', '2025-05-22 15:54:50.434664', '2025-05-22 15:54:50.434685', '', 15, 0);

-- Дамп структуры для таблица django_db.profile_position
CREATE TABLE IF NOT EXISTS `profile_position` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `gender` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.profile_position: ~8 rows (приблизительно)
INSERT INTO `profile_position` (`id`, `name`, `gender`) VALUES
	(2, 'Парикмахер универсал', 'U'),
	(3, 'Женский мастер', 'F'),
	(4, 'Мужской мастер', NULL),
	(5, 'Детский парикмахер', NULL),
	(6, 'Колорист', NULL),
	(7, 'Специалист по окрашиванию волос', NULL),
	(8, 'Специалист по уходу за волосами', NULL);

-- Дамп структуры для таблица django_db.profile_workerprofile
CREATE TABLE IF NOT EXISTS `profile_workerprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) NOT NULL,
  `address` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `hire_date` date NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `user_id` int DEFAULT NULL,
  `bonuses` int NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `profile_workerprofile_user_id_ce760ee6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.profile_workerprofile: ~4 rows (приблизительно)
INSERT INTO `profile_workerprofile` (`id`, `phone`, `address`, `created_at`, `updated_at`, `hire_date`, `is_active`, `user_id`, `bonuses`, `salary`) VALUES
	(1, '9253826214', 'г Москва, ул Грина, д 1 к', '2025-05-18 13:21:02.203345', '2025-05-22 02:24:00.165584', '1989-09-16', 1, 4, 60, 30000.00),
	(2, '9253826214', 'г Москва, ул Грина, д 1 к', '2025-05-18 13:45:11.661002', '2025-05-18 13:45:11.661026', '1989-09-16', 1, 5, 0, 0.00),
	(3, '9253826214', 'г Москва, ул Грина, д 1 к', '2025-05-18 13:45:11.672837', '2025-05-18 16:28:42.271911', '1989-09-16', 1, 7, 0, 0.00),
	(4, '9253826214', 'г Москва, ул Грина, д 1 к', '2025-05-18 13:50:32.933258', '2025-05-18 13:50:32.933279', '1989-09-16', 1, 6, 0, 0.00);

-- Дамп структуры для таблица django_db.profile_workerprofile_position
CREATE TABLE IF NOT EXISTS `profile_workerprofile_position` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `workerprofile_id` bigint NOT NULL,
  `position_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_workerprofile_po_workerprofile_id_positio_379883dc_uniq` (`workerprofile_id`,`position_id`),
  KEY `profile_workerprofil_position_id_c80404d5_fk_profile_p` (`position_id`),
  CONSTRAINT `profile_workerprofil_position_id_c80404d5_fk_profile_p` FOREIGN KEY (`position_id`) REFERENCES `profile_position` (`id`),
  CONSTRAINT `profile_workerprofil_workerprofile_id_4ed408de_fk_profile_w` FOREIGN KEY (`workerprofile_id`) REFERENCES `profile_workerprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.profile_workerprofile_position: ~8 rows (приблизительно)
INSERT INTO `profile_workerprofile_position` (`id`, `workerprofile_id`, `position_id`) VALUES
	(2, 1, 3),
	(3, 1, 5),
	(5, 2, 3),
	(6, 2, 5),
	(8, 3, 3),
	(9, 3, 5),
	(10, 4, 4),
	(11, 4, 6);

-- Дамп структуры для таблица django_db.service_service
CREATE TABLE IF NOT EXISTS `service_service` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext,
  `duration` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `category_id` bigint NOT NULL,
  `gender` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_service_category` (`category_id`),
  CONSTRAINT `service_service_category_id_1cbf2f9f_fk_service_s` FOREIGN KEY (`category_id`) REFERENCES `service_servicecategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.service_service: ~36 rows (приблизительно)
INSERT INTO `service_service` (`id`, `name`, `description`, `duration`, `price`, `is_active`, `created_at`, `updated_at`, `category_id`, `gender`) VALUES
	(2, 'Женская стрижка', 'Стрижка женская (короткие/средние/длинные волосы)', 120, 1500.00, 1, '2025-05-17 15:34:08.428821', '2025-05-19 19:14:43.109677', 3, 'F'),
	(4, 'Мужская стрижка', 'Стрижка мужская (машинкой/ножницами/классическая/модельная)', 30, 600.00, 1, '2025-05-19 18:59:05.162147', '2025-05-19 19:14:59.559326', 3, 'M'),
	(6, 'Окрашивание волос', 'Окрашивание волос (однотонное/сложное/балаяж/омбре/мелирование)', 40, 700.00, 1, '2025-05-19 19:01:57.233945', '2025-05-19 19:15:35.577394', 3, 'F'),
	(7, 'Тонирование волос', 'Тонирование волос', 60, 800.00, 1, '2025-05-19 19:16:06.183783', '2025-05-19 19:16:06.183804', 3, 'U'),
	(8, 'Блондирование волос', 'Блондирование волос', 60, 800.00, 1, '2025-05-19 19:16:23.823045', '2025-05-22 12:18:50.889897', 3, 'M'),
	(9, 'Укладка волос', 'Укладка волос (повседневная/вечерняя/свадебная)', 60, 900.00, 1, '2025-05-19 19:17:04.093091', '2025-05-19 19:17:04.093113', 3, 'F'),
	(10, 'Прически', 'Прически (дневные/вечерние/свадебные)', 60, 800.00, 1, '2025-05-19 19:17:30.729448', '2025-05-19 19:17:30.729467', 3, 'U'),
	(11, 'Маникюр', 'Маникюр (классический/европейский/аппаратный/комбинированный)', 50, 500.00, 1, '2025-05-20 13:56:24.009862', '2025-05-20 13:56:24.009878', 4, 'F'),
	(17, 'Снятие покрытия/наращивания', 'Снятие покрытия/наращивания', 50, 750.00, 1, '2025-05-20 13:59:14.325223', '2025-05-20 13:59:14.325241', 4, 'U'),
	(18, 'Дневной макияж', 'Дневной макияж', 30, 400.00, 1, '2025-05-20 14:03:27.193046', '2025-05-20 14:03:27.193063', 5, 'M'),
	(19, 'Свадебный макияж', 'Услуги свадебного макияжа', 130, 850.00, 1, '2025-05-20 14:04:03.931809', '2025-05-20 14:04:03.931830', 5, 'U'),
	(20, 'Оформление бровей', 'Оформление бровей (коррекция/окрашивание)', 40, 650.00, 1, '2025-05-20 14:04:29.101608', '2025-05-20 14:04:29.101629', 5, 'U'),
	(21, 'Наращивание ресниц', 'Наращивание ресниц (классика/объем 2D/3D/голливуд)', 50, 950.00, 1, '2025-05-20 14:04:50.211846', '2025-05-20 14:04:50.211863', 5, 'F'),
	(22, 'Окрашивание ресниц', 'Окрашивание ресниц', 30, 700.00, 1, '2025-05-20 14:05:29.831561', '2025-05-20 14:05:29.831580', 5, 'F'),
	(23, 'Чистка лица', 'Чистка лица (ультразвуковая/механическая/комбинированная)', 40, 890.00, 1, '2025-05-20 14:06:10.495829', '2025-05-22 12:19:12.840991', 6, 'M'),
	(25, 'Уход за лицом', 'Уходовые процедуры для лица', 40, 800.00, 1, '2025-05-20 14:07:09.985693', '2025-05-20 14:07:09.985714', 6, 'U'),
	(26, 'Инъекционная косметология', 'Инъекционная косметология (ботулинотерапия/филлеры)', 210, 9500.00, 1, '2025-05-20 14:07:56.341633', '2025-05-20 14:07:56.341663', 6, 'U'),
	(27, 'Массаж лица', 'Массаж лица (классический/лимфодренажный/скульптурный)', 50, 550.00, 1, '2025-05-20 14:08:24.145894', '2025-05-20 14:08:24.145922', 6, 'U'),
	(28, 'СПА', 'СПА-программы для тела', 40, 900.00, 1, '2025-05-20 14:08:55.572164', '2025-05-20 14:08:55.572186', 7, 'U'),
	(29, 'Обертывания', 'Обертывания (шоколадное/водорослевое/грязевое)', 50, 2000.00, 1, '2025-05-20 14:09:20.723883', '2025-05-20 14:09:20.723902', 7, 'U'),
	(30, 'Шугаринг', 'Шугаринг (различные зоны)', 30, 550.00, 1, '2025-05-20 14:09:41.176105', '2025-05-20 14:09:41.176127', 7, 'F'),
	(32, 'Лазерная эпиляция', 'Лазерная эпиляция (различные зоны)', 60, 1500.00, 1, '2025-05-20 14:10:40.042821', '2025-05-20 14:10:40.042843', 7, 'U'),
	(33, 'Массаж тела', 'Массаж тела (общий/антицеллюлитный/релаксирующий/спортивный)', 20, 1000.00, 1, '2025-05-20 14:11:14.736981', '2025-05-20 14:11:14.737001', 7, 'U'),
	(37, 'Пирсинг', 'Пирсинг (различные зоны)', 30, 900.00, 1, '2025-05-20 14:13:15.688598', '2025-05-20 14:13:15.688618', 8, 'U');

-- Дамп структуры для таблица django_db.service_servicecategory
CREATE TABLE IF NOT EXISTS `service_servicecategory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.service_servicecategory: ~6 rows (приблизительно)
INSERT INTO `service_servicecategory` (`id`, `name`, `description`, `is_active`) VALUES
	(3, 'Парикмахерские услуги', 'Парикмахерские услуги', 1),
	(4, 'Ногтевой сервис', 'Ногтевой сервис', 1),
	(5, 'Визаж / макияж', 'Визаж / макияж', 1),
	(6, 'Косметология и уход', 'Косметология и уход', 1),
	(7, 'SPA и телесный уход', 'SPA и телесный уход', 1),
	(8, 'Прочее', 'Прочее', 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
