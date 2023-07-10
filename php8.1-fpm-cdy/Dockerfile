FROM alpine:3.18

LABEL MAINTAINER="raoyc <raoyc@foxmail.com>"
LABEL Description="runtime:raw version for php8.1fpm + caddy"

RUN set -x \
  && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk update \
  && apk add --no-cache tzdata vim openssl openssh openssl-dev curl \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && apk del tzdata

RUN set -x \
  && apk update \
  && adduser -u 82 -D -S -G www-data www-data \
  && apk add --no-cache php81 php81-fpm php81-bcmath \
  php81-ctype php81-curl php81-json php81-fileinfo php81-iconv \
  php81-mbstring php81-openssl php81-pcntl php81-pdo php81-pdo_mysql \
  php81-posix php81-session php81-gd php81-dom \
  php81-mysqli php81-shmop php81-simplexml \
  php81-sodium php81-sqlite3 php81-sysvmsg php81-sysvsem php81-sysvshm \
  php81-tidy php81-tokenizer php81-xml php81-xmlreader php81-xmlwriter \
  php81-xsl php81-zip php81-exif php81-opcache

COPY start.sh /start.sh
COPY config/Caddyfile /etc/caddy/Caddyfile
COPY config/supervisor.d /etc/supervisor.d
COPY config/php-fpm.d /etc/php81/php-fpm.d
COPY app /var/www/app

RUN set -x \
  && apk add --no-cache caddy supervisor \
  && chmod +x /start.sh \
  && chown -R www-data:caddy /var/www/app && chmod 755 -R /var/www/app/storage

# Expose the port nginx is reachable on
EXPOSE 8080

WORKDIR /var/www/app

STOPSIGNAL SIGQUIT

CMD ["/start.sh"]