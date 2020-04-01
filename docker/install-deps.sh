#!/usr/bin/env bash

set -eu

printf "\n\n...Installing Deps...\n\n"

rm -rf vendor/ \
    && mkdir -p vendor/ \
    && /usr/bin/composer self-update \
    && /usr/bin/composer clearcache \
    && /usr/bin/composer install --prefer-source --no-interaction --no-dev -o \
    && /usr/bin/composer dump-autoload \
    && php artisan key:generate \
    && rm -rf ~/.composer

chown -R Duran:www-data . \
    && find . -type d -print0 | xargs -0 chmod 0750 \
    && find . -type f ! -path '*/vendor/*' ! -path '*/.git/*' -print0 | xargs -0 chmod 0640 \
    && chmod +x artisan boot.sh docker/install-deps.sh \
    && chmod -R og+rw bootstrap/ vendor/

printf "\n\n...Ready...\n\n"
