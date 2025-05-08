#!/bin/bash

# Ожидание доступности базы данных
echo "Waiting for MySQL..."
while ! nc -z $DB_HOST $DB_PORT; do
  sleep 0.1
done
echo "MySQL started"

# Выполнение миграций Django
python manage.py migrate

# Сбор статических файлов
python manage.py collectstatic --noinput

exec "$@"