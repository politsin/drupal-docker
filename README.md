# docker4drupal

## Если у вас линукс и установленны docker и docker-compose
 * клонируем git clone https://github.com/politsin/docker4drupal && cd docker4drupal
 * запускаем docker-compose up -d

# Что где лежит
  * Друпал кладём в ./html
  * Конфигурация php/mysql тут: ./assets/etc
  * MySQL сложит файлы своей базы сюда: ./assets/db
  * Подключиться к MySQL из контейнера PHP - drupal:drupal@localhost/drupal
  * Если нужно подключиться к MySQL с рутовой машины - Unix Socket тут: ./assets/run/mysqld
  * На сервер PHP можно подключиться через SSH на порту 2022 под root и www-data
  * Основная работа происходит под пользователем www-data, чтобы авторизоваться в контейнер нужно записать свои ключи в файл ./assets/www-home/.ssh/authorized_keys. Директория ./assets/www-home будет для пользователя внутри контейнера домашней, и будет располагаться по адресу /var/www.
  * Внутри php-контейнера запущены: supervisor, php, ssh, cron. Приложения запускает supervisor, отключить лишнее можно в файле ./assets/etc/supervisor/supervisord.conf
  * В момент запуска php-контейнера происходит попытка поправить права на файлы, если где-то сбилось. Это делает файл ./assets/etc/start.sh - С этого файла начинается работа контейнера, он в конце запускает supervisord, который запускает остальные приложения.
  * Установленный софт в php-контейнере можно посмотреть тут: https://github.com/politsin/docker-php/blob/master/Dockerfile
  * Под root на php-контейнер может понадобиться попасть для установки софта, для этого в файл ./assets/root/.ssh/authorized_keys нужно записать свои ключи.
  * Логи ngxin и php-fpm лежат в домашней директории пользователя www-data ./assets/www-home/log

