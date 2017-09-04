# docker4drupal

## 1. Скачаем файлы в /opt/docker4drupal
 * Команды в консоли: https://github.com/politsin/docker4drupal/blob/master/get.sh

## 2. Установим docker и docker-compose
 * Команды для Ubuntu: https://github.com/politsin/docker4drupal/blob/master/install-docker-ubuntu.sh

## 3. Запустим контейнеры через docker-compose
 * Команда: https://github.com/politsin/docker4drupal/blob/master/start.sh
 
# Что где лежит
  * Друпал кладём сюда /opt/docker4drupal/sites/0-default/www-home/html
  * Конфигурация php/mysql тут: /opt/docker4drupal/sites/0-default/etc
  * MySQL сложит файлы своей базы сюда: /opt/docker4drupal/sites/0-default/db
  * Подключиться к MySQL из контейнера PHP - drupal:drupal@localhost/drupal
  * Если охота подключиться к MySQL с рутовой машины - Unix Socket тут: /opt/docker4drupal/sites/0-default/run/mysqld
  * На сервер PHP можно подключиться через SSH на порту 2022 под root и www-data
  * Основная работа происходит под пользователем www-data, чтобы авторизоваться в контейнер нужно записать свои ключи в файл /opt/docker4drupal/sites/0-default/www-home/.ssh/authorized_keys. Директория /opt/docker4drupal/sites/0-default/www-home будет для пользователя внутри контейнера домашней, и будет располагаться по адресу /var/www.
  * Внутри php-контейнера запущены: supervisor, php, ssh, cron. Приложения запускает supervisor, отключить лишнее можно в файле /opt/docker4drupal/sites/0-default/etc/supervisor/supervisord.conf
  * В момент запуска php-контейнера происходит попытка поправить права на файлы, если где-то сбилось. Это делает файл /opt/docker4drupal/sites/0-default/etc/start.sh - С этого файла начинается работа контейнера, он в конце запускает supervisord, который запускает остальные приложения.
  * Установленный софт в php-контейнере можно посмотреть тут: https://github.com/politsin/docker-php/blob/master/Dockerfile
  * Под root на php-контейнер может понадобиться попасть для установки софта, для этого в файл /opt/docker4drupal/sites/0-default/root/.ssh/authorized_keys нужно записать свои ключи.
  * Логи ngxin и php-fpm лежат в домашней директории /opt/docker4drupal/sites/0-default/www-home/log
# Если нужен ещё сайт
  * Делаем копию директории /opt/docker4drupal/sites/0-default в /opt/docker4drupal/sites/1-mynewsite
  * Делаем копию директории /opt/docker4drupal/nginx/vhosts/0-default в /opt/docker4drupal/nginx/vhosts/1-mynewsite - внутри в конфигах правим пути для адресов и Unix-сокетов
  * В файле /opt/docker4drupal/docker-compose.yml добавляем 2 новых сервиса mysql и php
  * Поднимаем контейнеры: /opt/docker4drupal/start.sh
  * Перезагружаем nginx: docker exec -i nginx /usr/sbin/nginx -s reload
