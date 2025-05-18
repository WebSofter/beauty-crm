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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.auth_permission: ~68 rows (приблизительно)
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
	(68, 'Can view service category', 17, 'view_servicecategory');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.auth_user: ~0 rows (приблизительно)
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$1000000$wgLekuZsnbFjfIxyV7GBpe$EsNC6pm6lN2tUngxgtfxvWJ4e92FHON+FWftMxyrMro=', '2025-05-08 16:40:26.614577', 1, 'django_admin', '', '', 'django_admin@gmail.com', 1, 1, '2025-05-07 06:48:55.399954');

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

-- Дамп структуры для таблица django_db.basket
CREATE TABLE IF NOT EXISTS `basket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_basket_product` (`product_id`),
  KEY `fk_basket_customer` (`customer_id`),
  CONSTRAINT `fk_basket_customer` FOREIGN KEY (`customer_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_basket_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.basket: ~0 rows (приблизительно)

-- Дамп структуры для таблица django_db.client_client
CREATE TABLE IF NOT EXISTS `client_client` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(254) NOT NULL,
  `description` longtext,
  `created_at` datetime(6) NOT NULL,
  `modified_at` datetime(6) NOT NULL,
  `created_by_id` int NOT NULL,
  `team_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_client_created_by_id_a8280477_fk_auth_user_id` (`created_by_id`),
  KEY `client_client_team_id_03d21ed3_fk_team_team_id` (`team_id`),
  CONSTRAINT `client_client_created_by_id_a8280477_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `client_client_team_id_03d21ed3_fk_team_team_id` FOREIGN KEY (`team_id`) REFERENCES `team_team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.client_client: ~0 rows (приблизительно)

-- Дамп структуры для таблица django_db.client_clientfile
CREATE TABLE IF NOT EXISTS `client_clientfile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `client_id` bigint NOT NULL,
  `created_by_id` int NOT NULL,
  `team_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_clientfile_client_id_564c2789_fk_client_client_id` (`client_id`),
  KEY `client_clientfile_created_by_id_6152b910_fk_auth_user_id` (`created_by_id`),
  KEY `client_clientfile_team_id_7e856e34_fk_team_team_id` (`team_id`),
  CONSTRAINT `client_clientfile_client_id_564c2789_fk_client_client_id` FOREIGN KEY (`client_id`) REFERENCES `client_client` (`id`),
  CONSTRAINT `client_clientfile_created_by_id_6152b910_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `client_clientfile_team_id_7e856e34_fk_team_team_id` FOREIGN KEY (`team_id`) REFERENCES `team_team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.client_clientfile: ~0 rows (приблизительно)

-- Дамп структуры для таблица django_db.client_comment
CREATE TABLE IF NOT EXISTS `client_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `created_at` datetime(6) NOT NULL,
  `client_id` bigint NOT NULL,
  `created_by_id` int NOT NULL,
  `team_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_comment_client_id_9c6f82a6_fk_client_client_id` (`client_id`),
  KEY `client_comment_created_by_id_784443cd_fk_auth_user_id` (`created_by_id`),
  KEY `client_comment_team_id_3e34a737_fk_team_team_id` (`team_id`),
  CONSTRAINT `client_comment_client_id_9c6f82a6_fk_client_client_id` FOREIGN KEY (`client_id`) REFERENCES `client_client` (`id`),
  CONSTRAINT `client_comment_created_by_id_784443cd_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `client_comment_team_id_3e34a737_fk_team_team_id` FOREIGN KEY (`team_id`) REFERENCES `team_team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.client_comment: ~0 rows (приблизительно)

-- Дамп структуры для таблица django_db.customer
CREATE TABLE IF NOT EXISTS `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.customer: ~5 rows (приблизительно)
INSERT INTO `customer` (`id`, `username`, `created_at`) VALUES
	(1, 'alex', '2025-05-10 16:09:38'),
	(2, 'max', '2025-05-10 16:09:38'),
	(3, 'vova', '2025-05-10 16:09:38'),
	(4, 'maria', '2025-05-10 16:09:38'),
	(5, 'gella', '2025-05-10 16:09:38');

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.django_content_type: ~17 rows (приблизительно)
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.django_migrations: ~36 rows (приблизительно)
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
	(36, 'service', '0001_initial', '2025-05-16 14:16:24.960715');

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
	('op6m8e8u1k5g90mjdg7cn4yhle45b9mq', '.eJxVjE0OwiAYBe_C2hAKKRSX7j0D-f6QqoGktCvj3bVJF7p9M_NeKsG2lrR1WdLM6qwGdfrdEOghdQd8h3prmlpdlxn1ruiDdn1tLM_L4f4dFOjlW0fOLiPxiIiGWLIJFr2dWMA6Y4JDQogxRMhgvCBOzlHGwCMbHnxU7w8qyzl1:1uCYgz:5pp6cx_hW4MtZDwXsrkGkQ4_rfPm0JhfbZlbkjuAyZ4', '2025-05-21 06:55:45.707031'),
	('zej84jejx93g43a6vm0y57c9m5gdp0xz', '.eJxVjE0OwiAYBe_C2hAKKRSX7j0D-f6QqoGktCvj3bVJF7p9M_NeKsG2lrR1WdLM6qwGdfrdEOghdQd8h3prmlpdlxn1ruiDdn1tLM_L4f4dFOjlW0fOLiPxiIiGWLIJFr2dWMA6Y4JDQogxRMhgvCBOzlHGwCMbHnxU7w8qyzl1:1uD4IM:0FAnWX1EbA5iuQFLlX6WLRN0GOZTa4q_ZU748TztyTo', '2025-05-22 16:40:26.626710');

-- Дамп структуры для таблица django_db.lead_comment
CREATE TABLE IF NOT EXISTS `lead_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `created_at` datetime(6) NOT NULL,
  `created_by_id` int NOT NULL,
  `lead_id` bigint NOT NULL,
  `team_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lead_comment_created_by_id_7254878c_fk_auth_user_id` (`created_by_id`),
  KEY `lead_comment_lead_id_d986e598_fk_lead_lead_id` (`lead_id`),
  KEY `lead_comment_team_id_2d5e4bc0_fk_team_team_id` (`team_id`),
  CONSTRAINT `lead_comment_created_by_id_7254878c_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `lead_comment_lead_id_d986e598_fk_lead_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `lead_lead` (`id`),
  CONSTRAINT `lead_comment_team_id_2d5e4bc0_fk_team_team_id` FOREIGN KEY (`team_id`) REFERENCES `team_team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.lead_comment: ~0 rows (приблизительно)

-- Дамп структуры для таблица django_db.lead_lead
CREATE TABLE IF NOT EXISTS `lead_lead` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(254) NOT NULL,
  `description` longtext,
  `priority` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `modified_at` datetime(6) NOT NULL,
  `created_by_id` int NOT NULL,
  `converted_to_client` tinyint(1) NOT NULL,
  `team_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lead_lead_created_by_id_7c49765b_fk_auth_user_id` (`created_by_id`),
  KEY `lead_lead_team_id_fbb770a0_fk_team_team_id` (`team_id`),
  CONSTRAINT `lead_lead_created_by_id_7c49765b_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `lead_lead_team_id_fbb770a0_fk_team_team_id` FOREIGN KEY (`team_id`) REFERENCES `team_team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.lead_lead: ~0 rows (приблизительно)

-- Дамп структуры для таблица django_db.lead_leadfile
CREATE TABLE IF NOT EXISTS `lead_leadfile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by_id` int NOT NULL,
  `lead_id` bigint NOT NULL,
  `team_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lead_leadfile_created_by_id_4645ede8_fk_auth_user_id` (`created_by_id`),
  KEY `lead_leadfile_lead_id_6a88ae7f_fk_lead_lead_id` (`lead_id`),
  KEY `lead_leadfile_team_id_858384e7_fk_team_team_id` (`team_id`),
  CONSTRAINT `lead_leadfile_created_by_id_4645ede8_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `lead_leadfile_lead_id_6a88ae7f_fk_lead_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `lead_lead` (`id`),
  CONSTRAINT `lead_leadfile_team_id_858384e7_fk_team_team_id` FOREIGN KEY (`team_id`) REFERENCES `team_team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.lead_leadfile: ~0 rows (приблизительно)

-- Дамп структуры для таблица django_db.product
CREATE TABLE IF NOT EXISTS `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `p_name` varchar(50) DEFAULT NULL,
  `price` decimal(5,2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.product: ~3 rows (приблизительно)
INSERT INTO `product` (`id`, `p_name`, `price`, `created_at`) VALUES
	(1, 'sugar', 2.99, '2025-05-10 16:58:50'),
	(2, 'pomidor', 5.34, '2025-05-10 16:58:50'),
	(3, 'salt', 4.55, '2025-05-10 16:58:50');

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
  PRIMARY KEY (`id`),
  KEY `idx_service_category` (`category_id`),
  CONSTRAINT `service_service_category_id_1cbf2f9f_fk_service_s` FOREIGN KEY (`category_id`) REFERENCES `service_servicecategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.service_service: ~2 rows (приблизительно)
INSERT INTO `service_service` (`id`, `name`, `description`, `duration`, `price`, `is_active`, `created_at`, `updated_at`, `category_id`) VALUES
	(1, 'Стрижка головы', 'Услуги мужской стрижки головы', 30, 600.00, 1, '2025-05-17 15:02:16.014816', '2025-05-17 15:24:26.414835', 3),
	(2, 'Стрижка головы', 'Женская стрижка головы', 120, 1500.00, 1, '2025-05-17 15:34:08.428821', '2025-05-17 15:34:08.428840', 4);

-- Дамп структуры для таблица django_db.service_servicecategory
CREATE TABLE IF NOT EXISTS `service_servicecategory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.service_servicecategory: ~2 rows (приблизительно)
INSERT INTO `service_servicecategory` (`id`, `name`, `description`, `is_active`) VALUES
	(3, 'Мужская стрижка', 'Услуги по мужской стрижки', 1),
	(4, 'Женская стрижка', 'Услуги по женской стрижке', 1);

-- Дамп структуры для таблица django_db.team_plan
CREATE TABLE IF NOT EXISTS `team_plan` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `price` int NOT NULL,
  `description` longtext,
  `max_leads` int NOT NULL,
  `max_clients` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.team_plan: ~0 rows (приблизительно)
INSERT INTO `team_plan` (`id`, `name`, `price`, `description`, `max_leads`, `max_clients`) VALUES
	(1, 'Basic', 10, 'Some desc plan', 10, 10);

-- Дамп структуры для таблица django_db.team_team
CREATE TABLE IF NOT EXISTS `team_team` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by_id` int NOT NULL,
  `plan_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `team_team_created_by_id_368dcdf9_fk_auth_user_id` (`created_by_id`),
  KEY `team_team_plan_id_a68f140a_fk_team_plan_id` (`plan_id`),
  CONSTRAINT `team_team_created_by_id_368dcdf9_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `team_team_plan_id_a68f140a_fk_team_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `team_plan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.team_team: ~0 rows (приблизительно)
INSERT INTO `team_team` (`id`, `name`, `created_at`, `created_by_id`, `plan_id`) VALUES
	(1, 'My Team', '2022-11-24 16:38:04.849166', 1, 1);

-- Дамп структуры для таблица django_db.team_team_members
CREATE TABLE IF NOT EXISTS `team_team_members` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `team_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `team_team_members_team_id_user_id_69a9a465_uniq` (`team_id`,`user_id`),
  KEY `team_team_members_user_id_efff62b4_fk_auth_user_id` (`user_id`),
  CONSTRAINT `team_team_members_team_id_5e29636e_fk_team_team_id` FOREIGN KEY (`team_id`) REFERENCES `team_team` (`id`),
  CONSTRAINT `team_team_members_user_id_efff62b4_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.team_team_members: ~0 rows (приблизительно)
INSERT INTO `team_team_members` (`id`, `team_id`, `user_id`) VALUES
	(1, 1, 1);

-- Дамп структуры для таблица django_db.time_test
CREATE TABLE IF NOT EXISTS `time_test` (
  `t_date` date DEFAULT NULL,
  `t_time` time DEFAULT NULL,
  `t_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.time_test: ~2 rows (приблизительно)
INSERT INTO `time_test` (`t_date`, `t_time`, `t_datetime`) VALUES
	('2025-05-09', '15:31:46', '2025-05-09 15:31:46'),
	('2025-05-10', '15:31:56', '2025-05-09 15:31:56');

-- Дамп структуры для таблица django_db.transaction
CREATE TABLE IF NOT EXISTS `transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `careated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.transaction: ~5 rows (приблизительно)
INSERT INTO `transaction` (`id`, `customer_id`, `careated_at`) VALUES
	(1, 1, '2025-05-10 16:11:39'),
	(2, 2, '2025-05-10 16:11:39'),
	(3, 3, '2025-05-10 16:11:39'),
	(4, 4, '2025-05-10 16:11:39'),
	(5, 5, '2025-05-10 16:11:39');

-- Дамп структуры для таблица django_db.userprofile_userprofile
CREATE TABLE IF NOT EXISTS `userprofile_userprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `active_team_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `userprofile_userprofile_active_team_id_3df66d44_fk_team_team_id` (`active_team_id`),
  CONSTRAINT `userprofile_userprofile_active_team_id_3df66d44_fk_team_team_id` FOREIGN KEY (`active_team_id`) REFERENCES `team_team` (`id`),
  CONSTRAINT `userprofile_userprofile_user_id_59dda034_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы django_db.userprofile_userprofile: ~0 rows (приблизительно)
INSERT INTO `userprofile_userprofile` (`id`, `user_id`, `active_team_id`) VALUES
	(2, 1, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
