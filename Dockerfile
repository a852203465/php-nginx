FROM alpine:3.15

MAINTAINER Rong.Jia 852203465@qq.com

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache \
    curl \
    nginx \
    php8 \
    php8-ctype \
    php8-curl \
    php8-dom \
    php8-fpm \
    php8-gd \
    php8-intl \
    php8-mbstring \
    php8-mysqli \
    php8-opcache \
    php8-openssl \
    php8-phar \
    php8-session \
    php8-xml \
    php8-xmlreader \
    php8-zlib \
    php8-json \
    php8-simplexml \
    php8-zip \
    php8-pdo_mysql \
    php8-fileinfo \
    php8-bcmath \
    php8-xmlwriter \
    supervisor

RUN ln -s /usr/bin/php8 /usr/bin/php
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/fpm-pool.conf /etc/php8/php-fpm.d/www.conf
COPY conf/php.ini /etc/php8/conf.d/custom.ini
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

WORKDIR /var/www/html

RUN chown -R nobody.nobody /var/www/html /run /var/lib/nginx /var/log/nginx
USER nobody

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping




























