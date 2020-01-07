ARG PHP_VERSION
ARG COMPOSER_VERSION

FROM solutiondrive/php:php$PHP_VERSION

ARG COMPOSER_VERSION

ENV PATH "/composer/vendor/bin:$PATH"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer

COPY config/memory-limit.ini $PHP_INI_DIR/conf.d/

RUN apk add --no-cache \
    tini \
    patch

RUN EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)" \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('SHA384', 'composer-setup.php');")" \
    sh composer-check.sh \
 && php composer-setup.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
 && rm composer-setup.php \
 && composer --ansi --version --no-interaction
