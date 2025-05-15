-- Схема базы данных для CRM салона красоты на Django + MySQL
-- Примечание: Django будет использовать нативную систему авторизации (auth_user и связанные таблицы)

-- 1. Создание базы данных
CREATE DATABASE IF NOT EXISTS beauty_salon_crm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE beauty_salon_crm;

-- 2. Профили пользователей, расширение стандартной модели User из Django
CREATE TABLE user_profile (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,  -- Будет внешним ключом к auth_user (создаётся Django)
    role VARCHAR(20) NOT NULL CHECK (role IN ('admin', 'master', 'client')),
    phone VARCHAR(20),
    avatar VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_user_profile_user FOREIGN KEY (user_id) REFERENCES auth_user(id) ON DELETE CASCADE
);

-- 3. Дополнительная информация о клиентах
CREATE TABLE client_info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_profile_id INT UNIQUE NOT NULL,
    birthdate DATE,
    loyalty_points INT DEFAULT 0,
    notes TEXT,
    last_visit DATE,
    CONSTRAINT fk_client_info_profile FOREIGN KEY (user_profile_id) REFERENCES user_profile(id) ON DELETE CASCADE
);

-- 4. Дополнительная информация о мастерах
CREATE TABLE master_info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_profile_id INT UNIQUE NOT NULL,
    specialization VARCHAR(255),
    experience VARCHAR(255),
    description TEXT,
    commission_percent DECIMAL(5,2) DEFAULT 40.00, -- Процент от выручки (по умолчанию 40%)
    schedule_start TIME DEFAULT '09:00:00',
    schedule_end TIME DEFAULT '20:00:00',
    working_days VARCHAR(20) DEFAULT '1,2,3,4,5', -- Рабочие дни (1-7, где 1 - понедельник)
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_master_info_profile FOREIGN KEY (user_profile_id) REFERENCES user_profile(id) ON DELETE CASCADE
);

-- 5. Категории услуг
CREATE TABLE service_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE
);

-- 6. Услуги
CREATE TABLE service (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    duration INT NOT NULL, -- в минутах
    price DECIMAL(10,2) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_service_category FOREIGN KEY (category_id) REFERENCES service_category(id) ON DELETE RESTRICT
);

-- 7. Связь мастеров с услугами (какие услуги выполняет каждый мастер)
CREATE TABLE master_service (
    id INT AUTO_INCREMENT PRIMARY KEY,
    master_id INT NOT NULL,
    service_id INT NOT NULL,
    custom_price DECIMAL(10,2) NULL, -- Если у мастера своя цена на услугу
    custom_duration INT NULL, -- Если у мастера своя длительность услуги
    CONSTRAINT fk_master_service_master FOREIGN KEY (master_id) REFERENCES master_info(id) ON DELETE CASCADE,
    CONSTRAINT fk_master_service_service FOREIGN KEY (service_id) REFERENCES service(id) ON DELETE CASCADE,
    CONSTRAINT uq_master_service UNIQUE (master_id, service_id)
);

-- 8. Записи клиентов
CREATE TABLE appointment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    master_id INT NOT NULL,
    service_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'booked' CHECK (status IN ('booked', 'completed', 'cancelled', 'no_show')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    notes TEXT,
    reminder_sent BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_appointment_client FOREIGN KEY (client_id) REFERENCES client_info(id) ON DELETE RESTRICT,
    CONSTRAINT fk_appointment_master FOREIGN KEY (master_id) REFERENCES master_info(id) ON DELETE RESTRICT,
    CONSTRAINT fk_appointment_service FOREIGN KEY (service_id) REFERENCES service(id) ON DELETE RESTRICT
);

-- 9. Финансовые операции (оплаты)
CREATE TABLE payment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) DEFAULT 'cash',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'paid' CHECK (status IN ('paid', 'refunded', 'pending')),
    notes TEXT,
    created_by INT NOT NULL, -- ID пользователя (мастера или администратора), который внес запись об оплате
    CONSTRAINT fk_payment_appointment FOREIGN KEY (appointment_id) REFERENCES appointment(id) ON DELETE RESTRICT,
    CONSTRAINT fk_payment_created_by FOREIGN KEY (created_by) REFERENCES user_profile(id) ON DELETE RESTRICT
);

-- 10. Выплаты зарплат мастерам
CREATE TABLE salary_payment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    master_id INT NOT NULL,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    base_amount DECIMAL(10,2) NOT NULL, -- Основная сумма (% от выручки)
    bonus_amount DECIMAL(10,2) DEFAULT 0.00, -- Премии/бонусы
    deduction_amount DECIMAL(10,2) DEFAULT 0.00, -- Удержания
    total_amount DECIMAL(10,2) NOT NULL, -- Итоговая сумма
    payment_date DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'paid')),
    notes TEXT,
    created_by INT NOT NULL, -- ID администратора, создавшего выплату
    CONSTRAINT fk_salary_master FOREIGN KEY (master_id) REFERENCES master_info(id) ON DELETE RESTRICT,
    CONSTRAINT fk_salary_created_by FOREIGN KEY (created_by) REFERENCES user_profile(id) ON DELETE RESTRICT
);

-- 11. Статьи и новости
CREATE TABLE article (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    image VARCHAR(255),
    is_published BOOLEAN DEFAULT TRUE,
    publication_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    author_id INT,
    views INT DEFAULT 0,
    CONSTRAINT fk_article_author FOREIGN KEY (author_id) REFERENCES user_profile(id) ON DELETE SET NULL
);

-- 12. Программы лояльности
CREATE TABLE loyalty_program (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    points_required INT NOT NULL,
    discount_percent DECIMAL(5,2) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 13. История начисления баллов лояльности
CREATE TABLE loyalty_points_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    points INT NOT NULL, -- Может быть отрицательным при списании
    operation_type VARCHAR(20) NOT NULL CHECK (operation_type IN ('earned', 'spent', 'bonus', 'expired')),
    appointment_id INT, -- Может быть NULL для бонусных начислений
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_loyalty_client FOREIGN KEY (client_id) REFERENCES client_info(id) ON DELETE CASCADE,
    CONSTRAINT fk_loyalty_appointment FOREIGN KEY (appointment_id) REFERENCES appointment(id) ON DELETE SET NULL
);

-- 14. Хранение токенов для сброса пароля и подтверждения email (дополнительно к Django)
CREATE TABLE email_confirmation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NOT NULL,
    is_used BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_email_confirmation_user FOREIGN KEY (user_id) REFERENCES auth_user(id) ON DELETE CASCADE
);

-- 15. Отзывы клиентов о мастерах и услугах
CREATE TABLE review (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_published BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_review_appointment FOREIGN KEY (appointment_id) REFERENCES appointment(id) ON DELETE CASCADE
);

-- 16. Недоступное время мастеров (выходные, отпуска и т.д.)
CREATE TABLE master_unavailability (
    id INT AUTO_INCREMENT PRIMARY KEY,
    master_id INT NOT NULL,
    start_datetime DATETIME NOT NULL,
    end_datetime DATETIME NOT NULL,
    reason VARCHAR(255),
    CONSTRAINT fk_unavailability_master FOREIGN KEY (master_id) REFERENCES master_info(id) ON DELETE CASCADE
);

-- 17. Настройки для email-уведомлений
CREATE TABLE notification_settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    appointment_confirmation BOOLEAN DEFAULT TRUE,
    appointment_reminder BOOLEAN DEFAULT TRUE,
    appointment_change BOOLEAN DEFAULT TRUE,
    news_and_promotions BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_notification_user FOREIGN KEY (user_id) REFERENCES auth_user(id) ON DELETE CASCADE
);

-- 18. История изменений записей
CREATE TABLE appointment_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    changed_by INT NOT NULL, -- ID пользователя, внесшего изменения
    change_type VARCHAR(20) NOT NULL CHECK (change_type IN ('created', 'rescheduled', 'cancelled', 'completed', 'other')),
    old_data JSON, -- Старые данные записи
    new_data JSON, -- Новые данные записи
    change_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_appointment_history_appointment FOREIGN KEY (appointment_id) REFERENCES appointment(id) ON DELETE CASCADE,
    CONSTRAINT fk_appointment_history_user FOREIGN KEY (changed_by) REFERENCES user_profile(id) ON DELETE RESTRICT
);

-- Создание индексов для оптимизации запросов
CREATE INDEX idx_appointment_date ON appointment(appointment_date);
CREATE INDEX idx_appointment_master_date ON appointment(master_id, appointment_date);
CREATE INDEX idx_appointment_client ON appointment(client_id);
CREATE INDEX idx_payment_date ON payment(payment_date);
CREATE INDEX idx_user_profile_role ON user_profile(role);
CREATE INDEX idx_master_service_master ON master_service(master_id);
CREATE INDEX idx_service_category ON service(category_id);

-- Примечание: Django автоматически создаст таблицы auth_user, auth_group, auth_permission и другие
-- для системы авторизации при выполнении миграций.
