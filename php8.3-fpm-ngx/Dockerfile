FROM alpine:3.20

LABEL MAINTAINER="raoyc <raoyc@foxmail.com>"
LABEL Description="runtime:raw version for php8.3fpm + nginx"

RUN set -x \
  && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk update \
  && apk add --no-cache tzdata vim openssl openssh openssl-dev curl \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && apk del tzdata

RUN set -x \
  && apk update \
  && adduser -u 82 -D -S -G www-data www-data \
  && apk add --no-cache php83 php83-fpm php83-bcmath \
  php83-ctype php83-curl php83-json php83-fileinfo php83-iconv \
  php83-mbstring php83-openssl php83-pcntl php83-pdo php83-pdo_mysql \
  php83-posix php83-session php83-gd php83-dom \
  php83-mysqli php83-shmop php83-simplexml \
  php83-sodium php83-sqlite3 php83-sysvmsg php83-sysvsem php83-sysvshm \
  php83-tidy php83-tokenizer php83-xml php83-xmlreader php83-xmlwriter \
  php83-xsl php83-zip php83-exif php83-opcache

COPY start.sh /start.sh
COPY config/http.d /etc/nginx/http.d
COPY config/supervisor.d /etc/supervisor.d
COPY config/php-fpm.d /etc/php83/php-fpm.d
COPY app /var/www/app

RUN set -x \
  && apk add --no-cache nginx supervisor \
  && chmod +x /start.sh \
  && chown -R www-data:www-data /var/www/app && chmod 755 -R /var/www/app/storage \
  && ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log

# Expose the port nginx is reachable on
EXPOSE 8080

WORKDIR /var/www/app

STOPSIGNAL SIGQUIT

CMD ["/start.sh"]
