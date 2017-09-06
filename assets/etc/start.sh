#!/bin/bash

echo "Europe/Moscow" > /etc/timezone                     
cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime 

# www-data user
usermod -d /var/www/ www-data
chsh -s /bin/bash www-data
chown www-data.www-data /var/www/
chown www-data.www-data /var/www/.bash_profile
chown www-data.www-data /var/www/.bashrc
chown -Rf www-data.www-data /var/www/html
chown -Rf www-data.www-data /var/www/.drush
chown -Rf www-data.www-data /var/www/.console
chown -Rf www-data.www-data /var/www/.composer
chown -Rf www-data.www-data /var/www/.ssh

chmod 600 /var/www/.ssh/authorized_keys

# cron
chown www-data.www-data /var/spool/cron/crontabs/www-data
chmod 0777 /var/spool/cron/crontabs
chmod 0600 /var/spool/cron/crontabs/www-data

# php-fpm socket
mkdir -p /run/php/
chmod -R 0755 /run/php/
chown -R www-data.www-data /var/run/php
# mysql socket
chmod -R 0777 /var/run/mysqld

# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisord.conf
