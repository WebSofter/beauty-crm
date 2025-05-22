CREATE TABLE `appointment_appointment` (
  `id` bigint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `start_time` datetime(6) DEFAULT null,
  `created_at` datetime(6) NOT NULL,
  `status` varchar(10) NOT NULL,
  `notes` longtext,
  `client_id` bigint NOT NULL,
  `service_id` bigint DEFAULT null,
  `worker_id` bigint DEFAULT null
);

CREATE TABLE `appointment_review` (
  `id` bigint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `rating` int NOT NULL,
  `comment` longtext,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `appointment_id` bigint NOT NULL,
  `client_id` bigint NOT NULL,
  `worker_id` bigint NOT NULL
);

CREATE TABLE `payment_payment` (
  `id` bigint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` date NOT NULL,
  `comment` longtext,
  `worker_id` bigint NOT NULL
);

CREATE TABLE `profile_clientprofile` (
  `id` bigint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) NOT NULL,
  `address` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `notes` longtext NOT NULL,
  `user_id` int DEFAULT null,
  `bonuses` int NOT NULL
);

CREATE TABLE `profile_position` (
  `id` bigint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `gender` varchar(1) DEFAULT null
);

CREATE TABLE `profile_workerprofile` (
  `id` bigint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) NOT NULL,
  `address` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `hire_date` date NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `user_id` int DEFAULT null,
  `bonuses` int NOT NULL,
  `salary` decimal(10,2) NOT NULL
);

CREATE TABLE `profile_workerprofile_position` (
  `id` bigint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `workerprofile_id` bigint NOT NULL,
  `position_id` bigint NOT NULL
);

CREATE TABLE `service_service` (
  `id` bigint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext,
  `duration` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `category_id` bigint NOT NULL,
  `gender` varchar(10) NOT NULL
);

CREATE TABLE `service_servicecategory` (
  `id` bigint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext,
  `is_active` tinyint(1) NOT NULL
);

CREATE INDEX `appointment_appointm_client_id_9829a0eb_fk_profile_c` ON `appointment_appointment` (`client_id`);

CREATE INDEX `appointment_appointm_service_id_c235daf3_fk_service_s` ON `appointment_appointment` (`service_id`);

CREATE INDEX `appointment_appointm_worker_id_7bec2fd1_fk_profile_w` ON `appointment_appointment` (`worker_id`);

CREATE UNIQUE INDEX `appointment_review_client_id_appointment_id_abb1a8b5_uniq` ON `appointment_review` (`client_id`, `appointment_id`);

CREATE INDEX `idx_review_client` ON `appointment_review` (`client_id`);

CREATE INDEX `idx_review_worker` ON `appointment_review` (`worker_id`);

CREATE INDEX `idx_review_appointment` ON `appointment_review` (`appointment_id`);

CREATE INDEX `payment_payment_worker_id_a9644289_fk_profile_workerprofile_id` ON `payment_payment` (`worker_id`);

CREATE UNIQUE INDEX `user_id` ON `profile_clientprofile` (`user_id`);

CREATE UNIQUE INDEX `name` ON `profile_position` (`name`);

CREATE UNIQUE INDEX `user_id` ON `profile_workerprofile` (`user_id`);

CREATE UNIQUE INDEX `profile_workerprofile_po_workerprofile_id_positio_379883dc_uniq` ON `profile_workerprofile_position` (`workerprofile_id`, `position_id`);

CREATE INDEX `profile_workerprofil_position_id_c80404d5_fk_profile_p` ON `profile_workerprofile_position` (`position_id`);

CREATE INDEX `idx_service_category` ON `service_service` (`category_id`);

ALTER TABLE `appointment_appointment` ADD CONSTRAINT `appointment_appointm_client_id_9829a0eb_fk_profile_c` FOREIGN KEY (`client_id`) REFERENCES `profile_clientprofile` (`id`);

ALTER TABLE `appointment_appointment` ADD CONSTRAINT `appointment_appointm_service_id_c235daf3_fk_service_s` FOREIGN KEY (`service_id`) REFERENCES `service_service` (`id`);

ALTER TABLE `appointment_appointment` ADD CONSTRAINT `appointment_appointm_worker_id_7bec2fd1_fk_profile_w` FOREIGN KEY (`worker_id`) REFERENCES `profile_workerprofile` (`id`);

ALTER TABLE `appointment_review` ADD CONSTRAINT `appointment_review_appointment_id_84e5c896_fk_appointme` FOREIGN KEY (`appointment_id`) REFERENCES `appointment_appointment` (`id`);

ALTER TABLE `appointment_review` ADD CONSTRAINT `appointment_review_client_id_9ded1104_fk_profile_c` FOREIGN KEY (`client_id`) REFERENCES `profile_clientprofile` (`id`);

ALTER TABLE `appointment_review` ADD CONSTRAINT `appointment_review_worker_id_2e40d9e1_fk_profile_w` FOREIGN KEY (`worker_id`) REFERENCES `profile_workerprofile` (`id`);

ALTER TABLE `payment_payment` ADD CONSTRAINT `payment_payment_worker_id_a9644289_fk_profile_workerprofile_id` FOREIGN KEY (`worker_id`) REFERENCES `profile_workerprofile` (`id`);

ALTER TABLE `profile_workerprofile_position` ADD CONSTRAINT `profile_workerprofil_position_id_c80404d5_fk_profile_p` FOREIGN KEY (`position_id`) REFERENCES `profile_position` (`id`);

ALTER TABLE `profile_workerprofile_position` ADD CONSTRAINT `profile_workerprofil_workerprofile_id_4ed408de_fk_profile_w` FOREIGN KEY (`workerprofile_id`) REFERENCES `profile_workerprofile` (`id`);

ALTER TABLE `service_service` ADD CONSTRAINT `service_service_category_id_1cbf2f9f_fk_service_s` FOREIGN KEY (`category_id`) REFERENCES `service_servicecategory` (`id`);
