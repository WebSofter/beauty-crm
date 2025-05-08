FROM python:3.13-slim

# Установка зависимостей, включая netcat
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    gcc \
    pkg-config \
    netcat-traditional \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Установка рабочей директории
WORKDIR /app

# Установка переменных окружения
# Установка переменных окружения
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DEBUG=True

# Копирование кода приложения
COPY app/ /app/

# Установка зависимостей Python
# COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Копирование скрипта entrypoint
# COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

COPY .env.example /.env

# Порт для работы приложения
EXPOSE 8000

# Запуск entrypoint скрипта
ENTRYPOINT ["/app/entrypoint.sh"]