FROM php:5-apache

# To docker-php-ext-install gd, we need to apt-get install zlib1g-dev libpng-dev
# To docker-php-ext-install intl, we need to apt-get install zlib1g-dev libicu-dev
# To docker-php-ext-install xmlrpc, we need to apt-get install libxml2-dev
# docker-php-ext-install soap - apt-get install libxml2-dev
# docker-php-ext-install zip - apt-get install zlib1g-dev
# docker-php-ext-install opcache, not sure if I need to run docker-php-ext-enable opcache

#RUN apt-get update && apt-get install -y php5-intl php5-mysql php5-xmlrpc php5-gd \

# RUN apt-get update \
#     && apt-get install -y libicu-dev libpng-dev libxml2-dev zlib1g-dev php5-gd php5-intl --no-install-recommends && rm -rf /var/lib/apt/lists/* \
#     && docker-php-ext-install -j$(nproc) gd intl mysqli opcache soap xmlrpc zip \
#     && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false libicu-dev libpng-dev libxml2-dev zlib1g-dev
#     && apt-get purge

# Install Moodle PHP dependency

RUN set -xe \
        && installDeps=" \
                         libicu-dev \
                         libpng-dev \
                         libxml2-dev \
                         zlib1g-dev \
                       " \
        && apt-get update && apt-get install -y $installDeps php5-gd php5-intl --no-install-recommends && rm -rf /var/lib/apt/lists/* \
        && docker-php-ext-install -j$(nproc) gd intl mysqli opcache soap xmlrpc zip \
        && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $installDeps
