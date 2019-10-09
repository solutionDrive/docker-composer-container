#!/usr/bin/env bash

set -e

docker build \
    --build-arg PHP_VERSION=$PHP_VERSION \
    --build-arg COMPOSER_VERSION=$COMPOSER_VERSION \
    -t solutiondrive/docker-composer-container:php$PHP_VERSION \
    .

# Tag also as solutiondrive/php-composer
docker tag \
    solutiondrive/docker-composer-container:php$PHP_VERSION \
    solutiondrive/php-composer:php$PHP_VERSION

# Tag "latest"
if [ "$LATEST" = "1" ]; then
    docker tag \
        solutiondrive/docker-composer-container:php$PHP_VERSION \
        solutiondrive/docker-composer-container:latest
    docker tag \
        solutiondrive/docker-composer-container:php$PHP_VERSION \
        solutiondrive/php-composer:latest
fi
