# Drupal docker

## Запуск
 * Устанавливаем docker и docker-compose https://docs.docker.com/install/linux/docker-ce/ubuntu/
 * `git clone https://github.com/politsin/drupal-docker` - клонируем репозиторий
 * `cd drupal-docker` - переходим в скачанную директорию
 * `docker-compose up -d` - запускаем контейнеры (nginx, mysql, php-fpm)
 * `cd site` - переходим в директорию сайт
 * `wget https://druio.s3.amazonaws.com/druio.tar.gz` - качаем билд проекта
 * `tar xvfz druio.tar.gz -C ./` - распаковываем

## Первые шаги
 * Сайт будет доступен по адресу http://localhost:80
 * Подключиться к базе `drupal:drupal@localhost/drupal`

## Решим вопросы с правами www-data
 * `groupadd -r -g 33 www-data` - создаём группу www-data
 * `usermod -a -G www-data $(id -un)` - добавляем себя в группу
 
# Что где лежит
  * файл index.php должен находится в `./site/web`
  * Конфигурация php/mysql тут: `./assets/etc`
  * MySQL сложит файлы своей базы сюда: `./assets/db`
  * Подключиться к MySQL из контейнера PHP - `drupal:drupal@localhost/drupal`
  * Если нужно подключиться к MySQL с рутовой машины - Unix Socket тут: `./assets/run/mysqld`
  * Логи ngxin и php-fpm лежат в `./assets/www-home/log`
  
## Одновременно 2 проекта - сложно, по очереди проще
 * останавливаем и удаляем контейнеры `stop-rm.sh`
```sh
docker stop drupal-mysql
docker stop drupal-phpfpm
docker stop drupal-nginx

docker rm drupal-mysql
docker rm drupal-phpfpm
docker rm drupal-nginx
```
 * запускаем новые `docker-compose up -d` внутри другой директории
 
