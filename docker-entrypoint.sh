#!/bin/sh
set -e

sed "s/@GROUP_ID@/${GROUP_ID}/g" -i /etc/group
sed "s/@USER_ID@/${USER_ID}/g" -i /etc/passwd
sed "s/@GROUP_ID@/${GROUP_ID}/g" -i /etc/passwd

chown -R magento:magento /home/magento

if [ "${XDEBUG}" = "0" ]; then
  mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini-back
# else
#   rm -f /etc/php-7.2.d/99-xdebug.ini
fi

exec "$@"
