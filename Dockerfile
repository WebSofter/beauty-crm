FROM python:3.13-slim

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    gcc \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Установка рабочей директории
WORKDIR /app

# Установка переменных окружения
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Установка зависимостей Python
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Копирование скрипта entrypoint
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

# Копирование кода приложения
COPY app/ /app/

# Запуск entrypoint скрипта
ENTRYPOINT ["/app/entrypoint.sh"]