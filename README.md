# Env
- USER_ID
- GROUP_ID
- MYSQL_DATABASE
- MYSQL_USER
- MYSQL_PASSWORD
- MYSQL_ROOT_PASSWORD
- XDEBUG

# Docker compose example
```yml
  app:
    volumes:
      - .:/var/www/magento
    environment:
      - USER_ID=$USER_ID
      - GROUP_ID=$GROUP_ID
      - MYSQL_DATABASE=${MYSQL_DATABASE}
      - MYSQL_USER=${MYSQL_USER}
      - MYSQL_PASSWORD=${MYSQL_PASSWORD}
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
      - XDEBUG=${XDEBUG}
```
