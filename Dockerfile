FROM php:7.3-fpm

RUN apt-get update && apt-get install -y wget redis-tools mariadb-client nodejs npm

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
ADD https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 /usr/local/bin/mhsendmail
RUN chmod uga+x /usr/local/bin/mhsendmail

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && \
  install-php-extensions bcmath gd intl pdo_mysql soap xsl zip xdebug

ADD https://getcomposer.org/composer-stable.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

ADD https://files.magerun.net/n98-magerun2.phar /usr/local/bin/n98
RUN chmod 755 /usr/local/bin/n98

RUN echo "magento:x:@GROUP_ID@:" >> /etc/group \
  && echo "magento:x:@USER_ID@:@GROUP_ID@::/home/magento:/bin/bash" >> /etc/passwd \
  && echo "magento:*:16323:0:99999:7:::" >> /etc/shadow \
  && mkdir -p /home/magento /home/magento/.ssh /home/magento/.composer /var/www/magento \
  && chmod 700 /home/magento/.ssh

RUN npm install -g yarn grunt-cli

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

COPY docker-php-ext-config.ini /usr/local/etc/php/conf.d/docker-php-ext-config.ini

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "php-fpm" ]