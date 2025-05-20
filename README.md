

# Запуск приложения локально без docker
для запуска нужно будет:
1. иметь сервер MySQL
2. импортировать дамп БД из папки dumps через какой-нибудь менеджер(hedisql или phpmyqdmin)
3. переименовать .env.local в .env
4. прописать данные БД в .env
3. создать виртуальнео окружение в корне проекта командо `python -m venv .vevn` и активировать `source .venv/Scripts/activate`(для Windows) или `source .venv/bin/activate`(для Linuxt/Mac)
4. зайти в папку `cd app`
5. установить зависимости `pip install -r requirements.txt`
6. запустить `python manage.py runserver 0.0.0.0:8000`
7. сайт-crm будет работать в браузере на поту `localhost:8000`

# Запуск приложения локально с docker
1. переименовать .env.local в .env
2. поднять контейнеры
```bash
# Сборка и запуск
docker-compose up -d db phpmyadmin
```
3. потом зайти в phpMyAdmin на порту `localhost:8080` через данные из .env
4. импортировать дамп БД из папки dumps
5. создать виртуальнео окружение в корне проекта командо `python -m venv .vevn` и активировать `source .venv/Scripts/activate`(для Windows) или `source .venv/bin/activate`(для Linuxt/Mac)
6. зайти в папку `cd app`
7. установить зависимости `pip install -r requirements.txt`
8. запустить `python manage.py runserver 0.0.0.0:8000`
9. сайт-crm будет работать в браузере на поту `localhost:8000`

# Прочие полезные команды
## Выполнение команд в контейнере
```bash
docker-compose exec web python manage.py migrate
docker-compose exec web python manage.py createsuperuser
```
В артефакте также есть пример простой модели для тестирования базы данных и настройки админки Django.
После запуска сервера, вы сможете открыть админ-панель по адресу http://localhost:8000/admin/ и убедиться, что всё настроено правильно и работает с MySQL.

## Создание приложений и миграций
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
Создание суперпользователя для доступа к админке:
bashpython manage.py createsuperuser

Запуск сервера разработки:
bash# Локально
python manage.py runserver