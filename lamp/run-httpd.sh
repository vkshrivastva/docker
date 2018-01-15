#!/bin/bash

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/* /tmp/httpd*

cd /var/www/html/ipan-web/

composer install

cp .env.example .env

php artisan key:generate

mkdir /var/www/html/ipan-web/public/temp_storage
mkdir /var/www/html/ipan-web/public/email_attachment
mkdir /var/www/html/ipan-web/public/documents

chown -R apache:apache /var/www/html/

chmod -R 755 /var/www/html/ipan-web/storage/
chmod -R 755 /var/www/html/ipan-web/bootstrap/cache/
chmod -R 755 /var/www/html/ipan-web/public/temp_storage
chmod -R 755 /var/www/html/ipan-web/public/email_attachment
chmod -R 755 /var/www/html/ipan-web/public/documents

exec /usr/sbin/apachectl -DFOREGROUND
