FROM alpine:3.15

LABEL MAINTAINER="raoyc <raoyc@foxmail.com>"
LABEL Description="runtime:raw version for php7.4fpm + nginx"

RUN set -x \
  && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk update \
  && apk add --no-cache tzdata vim openssl openssh openssl-dev curl \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && apk del tzdata

RUN set -x \
  && apk update \
  && adduser -u 82 -D -S -G www-data www-data \
  && apk add --no-cache php7 php7-fpm php7-bcmath \
  php7-ctype php7-curl php7-json php7-fileinfo php7-iconv \
  php7-mbstring php7-openssl php7-pcntl php7-pdo php7-pdo_mysql \
  php7-posix php7-session php7-gd php7-dom \
  php7-mysqli php7-shmop php7-simplexml \
  php7-sodium php7-sqlite3 php7-sysvmsg php7-sysvsem php7-sysvshm \
  php7-tidy php7-tokenizer php7-xml php7-xmlreader php7-xmlrpc php7-xmlwriter \
  php7-xsl php7-zip php7-exif php7-opcache

COPY start.sh /start.sh
COPY config/http.d /etc/nginx/http.d
COPY config/supervisor.d /etc/supervisor.d
COPY config/php-fpm.d /etc/php7/php-fpm.d
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
