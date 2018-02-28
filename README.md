# Dru.io - drupal docker

## Если у вас линукс и установленны docker и docker-compose
 * Устанавливаем docker и docker-compose https://docs.docker.com/install/linux/docker-ce/ubuntu/
 * клонируем `git clone https://github.com/politsin/druio-docker && cd druio-docker`
 * запускаем `docker-compose up -d`

## Первые шаги
 * Сайт кладём в `html`, он будет доступен по адресу http://localhost:80
 * Подключиться к базе `drupal:drupal@localhost/drupal`
 * Авторизоваться в php-контейнер: `ssh -p 2022 www-data@localhost`, перед этим нужно записать свой паблик ключ в `./assets/www-home/.ssh/authorized_keys`
 
## Одновременно 2 проекта
Проще всего разнести их по портам, для этого в файле docker-compose.yml:
  * "80:80" меняем на "81:80" и смотрим на сайт по адресу http://localhost:81
  * "2022:22" меняем на "2023:22" и авторизовываемся в контейнер через ssh по адресу 2023

# Что где лежит
  * Друпал кладём в `./html`
  * Конфигурация php/mysql тут: `./assets/etc`
  * MySQL сложит файлы своей базы сюда: `./assets/db`
  * Подключиться к MySQL из контейнера PHP - `drupal:drupal@localhost/drupal`
  * Если нужно подключиться к MySQL с рутовой машины - Unix Socket тут: `./assets/run/mysqld`
  * На сервер PHP можно подключиться через SSH на порту 2022 под `root` и `www-data`
  * Основная работа происходит под пользователем www-data, чтобы авторизоваться в контейнер нужно записать свои ключи в файл `./assets/www-home/.ssh/authorized_keys`. Директория `./assets/www-home` будет для пользователя внутри контейнера домашней, и будет располагаться по адресу `/var/www`.
  * Внутри php-контейнера запущены: `supervisor`, `php`, `ssh`, `cron`. Приложения запускает supervisor, отключить лишнее можно в файле `./assets/etc/supervisor/supervisord.conf`
  * В момент запуска php-контейнера происходит попытка поправить права на файлы, если где-то сбилось. Это делает файл `./assets/etc/start.sh` - С этого файла начинается работа контейнера, он в конце запускает supervisord, который запускает остальные приложения.
  * Установленный софт в php-контейнере можно посмотреть тут: https://github.com/politsin/docker-php/blob/master/Dockerfile
  * Под root на php-контейнер может понадобиться попасть для установки софта, для этого в файл `./assets/root/.ssh/authorized_keys` нужно записать свои ключи.
  * Логи ngxin и php-fpm лежат в домашней директории пользователя `www-data` `./assets/www-home/log`

