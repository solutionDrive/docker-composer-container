#!/usr/bin/env bash

set -e

# Build "composer2"
if [ "$COMPOSER2" = "1" ]; then
  docker build \
      --build-arg PHP_VERSION=$PHP_VERSION \
      --build-arg COMPOSER_VERSION=$COMPOSER_VERSION \
      -t solutiondrive/docker-composer2-container:php$PHP_VERSION \
      .

  # Tag also as solutiondrive/php-composer
  docker tag \
      solutiondrive/docker-composer2-container:php$PHP_VERSION \
      solutiondrive/php-composer2:php$PHP_VERSION

  # Tag "latest"
  if [ "$LATEST" = "1" ]; then
      docker tag \
          solutiondrive/docker-composer2-container:php$PHP_VERSION \
          solutiondrive/docker-composer2-container:latest
      docker tag \
          solutiondrive/docker-composer2-container:php$PHP_VERSION \
          solutiondrive/php-composer2:latest
  fi
else
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
fi
