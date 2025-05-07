Команды для первой миграции и запуска Django
Создание и настройка проекта

Создайте новый проект и приложение:
bash# Создание проекта
django-admin startproject config .

# Создание приложения
python manage.py startapp core

Добавьте приложение в INSTALLED_APPS в settings.py:
```python
pythonINSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    # ... другие встроенные приложения
    'core',  # Ваше приложение
]
```

Миграции базы данных

Создание миграций:
```bash
# Для встроенных приложений Django
python manage.py makemigrations

# Для вашего приложения (если есть модели)
python manage.py makemigrations core
```
Применение миграций:
`bashpython manage.py migrate`

Проверка статуса миграций:
```bash
python manage.py showmigrations
```


Запуск приложения

Создание суперпользователя для доступа к админке:
bashpython manage.py createsuperuser

Запуск сервера разработки:
bash# Локально
python manage.py runserver

# Для доступа извне
`python manage.py runserver 0.0.0.0:8000`


В Docker-окружении
Если используете Docker из предыдущего примера:
```bash
# Сборка и запуск
docker-compose build
docker-compose up -d
```

# Выполнение команд в контейнере
```bash
docker-compose exec web python manage.py migrate
docker-compose exec web python manage.py createsuperuser
```
В артефакте также есть пример простой модели для тестирования базы данных и настройки админки Django.
После запуска сервера, вы сможете открыть админ-панель по адресу http://localhost:8000/admin/ и убедиться, что всё настроено правильно и работает с MySQL.