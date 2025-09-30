FROM alpine:3.22

LABEL MAINTAINER="raoyc <raoyc@foxmail.com>"
LABEL Description="runtime:raw version for php8.4fpm + nginx"

RUN set -x \
  && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk update \
  && apk add --no-cache tzdata vim openssl openssh openssl-dev curl \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && apk del tzdata

RUN set -x \
  && apk update \
  && adduser -u 82 -D -S -G www-data www-data \
  && apk add --no-cache php84 php84-fpm php84-bcmath \
  php84-ctype php84-curl php84-json php84-fileinfo php84-iconv \
  php84-mbstring php84-openssl php84-pcntl php84-pdo php84-pdo_mysql \
  php84-posix php84-session php84-gd php84-dom \
  php84-mysqli php84-shmop php84-simplexml \
  php84-sodium php84-sqlite3 php84-sysvmsg php84-sysvsem php84-sysvshm \
  php84-tidy php84-tokenizer php84-xml php84-xmlreader php84-xmlwriter \
  php84-xsl php84-zip php84-exif php84-opcache

COPY start.sh /start.sh
COPY app /var/www/app

RUN set -x \
  && apk add --no-cache nginx supervisor \
  && chmod +x /start.sh \
  # apk add php84 之后，似乎没有软链接 php
  && cd /usr/bin && ln -s php84 php \
  && chown -R www-data:www-data /var/www/app && chmod 755 -R /var/www/app/storage \
  && ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log

COPY config/http.d /etc/nginx/http.d
COPY config/supervisor.d /etc/supervisor.d
COPY config/php-fpm.d /etc/php84/php-fpm.d


# Expose the port nginx is reachable on
EXPOSE 8080

WORKDIR /var/www/app

STOPSIGNAL SIGQUIT

CMD ["/start.sh"]
