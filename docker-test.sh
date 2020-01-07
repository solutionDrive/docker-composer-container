#!/usr/bin/env bash

set -e

ATTRIBUTES_TEMPLATE_FILE="tests/inspec/composer-container/attributes.yml.template"
ATTRIBUTES_FILE="tests/inspec/composer-container/attributes.yml"
cp ${ATTRIBUTES_TEMPLATE_FILE} ${ATTRIBUTES_FILE}
printf '%s\n' ",s~{{ composer_version }}~${COMPOSER_VERSION}~g" w q | ed -s "${ATTRIBUTES_FILE}"
printf '%s\n' ",s~{{ php_version }}~${PHP_VERSION}~g" w q | ed -s "${ATTRIBUTES_FILE}"

DOCKER_CONTAINER_ID=`docker run -d solutiondrive/docker-composer-container:php$PHP_VERSION`
bundle exec inspec exec tests/inspec/composer-container --attrs tests/inspec/composer-container/attributes.yml -t docker://${DOCKER_CONTAINER_ID}
docker stop ${DOCKER_CONTAINER_ID}
