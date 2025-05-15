-- Создание базы данных (если еще не создана)
CREATE DATABASE IF NOT EXISTS beauty_salon CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE beauty_salon;

-- Таблица ролей пользователей
CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
) ENGINE=InnoDB;

-- Таблица пользователей
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    is_active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
) ENGINE=InnoDB;

-- Таблица мастеров (расширяет пользователей с ролью "Мастер")
CREATE TABLE masters (
    master_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    specialization VARCHAR(100),
    bio TEXT,
    photo_url VARCHAR(255),
    hire_date DATE NOT NULL,
    salary_percentage DECIMAL(5,2) DEFAULT 50.00, -- процент от выручки
    is_available TINYINT(1) DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB;

-- Таблица клиентов (расширяет пользователей с ролью "Клиент")
CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE, -- может быть NULL для клиентов без учетной записи
    notes TEXT,
    source VARCHAR(50), -- откуда пришел клиент
    birthday DATE,
    total_visits INT DEFAULT 0,
    total_spent DECIMAL(10,2) DEFAULT 0.00,
    last_visit_date TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB;

-- Категории услуг
CREATE TABLE service_categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
) ENGINE=InnoDB;

-- Таблица услуг
CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    duration INT NOT NULL, -- в минутах
    is_active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (category_id) REFERENCES service_categories(category_id)
) ENGINE=InnoDB;

-- Связь мастеров и услуг (какие услуги может выполнять мастер)
CREATE TABLE master_services (
    master_service_id INT AUTO_INCREMENT PRIMARY KEY,
    master_id INT NOT NULL,
    service_id INT NOT NULL,
    custom_price DECIMAL(10,2), -- индивидуальная цена мастера (если отличается)
    UNIQUE(master_id, service_id),
    FOREIGN KEY (master_id) REFERENCES masters(master_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
) ENGINE=InnoDB;

-- Расписание мастеров
CREATE TABLE master_schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    master_id INT NOT NULL,
    day_of_week INT NOT NULL, -- 1-7 (пн-вс)
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_working TINYINT(1) DEFAULT 1,
    FOREIGN KEY (master_id) REFERENCES masters(master_id)
) ENGINE=InnoDB;

-- Выходные и особые дни мастеров
CREATE TABLE master_days_off (
    day_off_id INT AUTO_INCREMENT PRIMARY KEY,
    master_id INT NOT NULL,
    date DATE NOT NULL,
    reason VARCHAR(255),
    UNIQUE(master_id, date),
    FOREIGN KEY (master_id) REFERENCES masters(master_id)
) ENGINE=InnoDB;

-- Таблица записей (appointments)
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    master_id INT NOT NULL,
    service_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'scheduled', -- scheduled, completed, cancelled, no_show
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    notes TEXT,
    price_paid DECIMAL(10,2), -- фактическая оплата
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (master_id) REFERENCES masters(master_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
) ENGINE=InnoDB;

-- Таблица email-уведомлений
CREATE TABLE email_notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    email_to VARCHAR(100) NOT NULL,
    email_type VARCHAR(50) NOT NULL, -- confirmation, reminder, cancellation
    sent_at TIMESTAMP NULL,
    status VARCHAR(20) DEFAULT 'pending', -- pending, sent, failed
    error_message TEXT,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
) ENGINE=InnoDB;

-- Таблица платежей
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL, -- cash, card, online
    payment_status VARCHAR(20) DEFAULT 'completed', -- completed, refunded, partially_refunded
    transaction_id VARCHAR(100),
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
) ENGINE=InnoDB;

-- Таблица зарплат мастеров
CREATE TABLE master_salaries (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    master_id INT NOT NULL,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    base_salary DECIMAL(10,2) DEFAULT 0.00,
    commission DECIMAL(10,2) DEFAULT 0.00, -- сумма комиссии от услуг
    bonus DECIMAL(10,2) DEFAULT 0.00,
    tax_amount DECIMAL(10,2) DEFAULT 0.00,
    total_amount DECIMAL(10,2) NOT NULL, -- итоговая сумма
    payment_date DATE,
    payment_status VARCHAR(20) DEFAULT 'pending', -- pending, paid, cancelled
    notes TEXT,
    FOREIGN KEY (master_id) REFERENCES masters(master_id)
) ENGINE=InnoDB;

-- Таблица для отчётов и аналитики
CREATE TABLE analytics (
    analytics_id INT AUTO_INCREMENT PRIMARY KEY,
    report_type VARCHAR(50) NOT NULL, -- daily, weekly, monthly, custom
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    total_appointments INT NOT NULL,
    total_revenue DECIMAL(12,2) NOT NULL,
    total_clients INT NOT NULL,
    new_clients INT NOT NULL,
    cancelled_appointments INT NOT NULL,
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    report_data JSON -- для хранения детальных данных в JSON формате
) ENGINE=InnoDB;

-- Начальное заполнение таблицы ролей
INSERT INTO roles (role_name, description) VALUES
('Администратор', 'Полный доступ ко всем функциям системы'),
('Мастер', 'Доступ к расписанию и клиентам'),
('Клиент', 'Онлайн-запись, просмотр истории');