FROM php:7.4-fpm
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
COPY ioncube_loader_lin_7.4.so /usr/local/lib/php/extensions/no-debug-non-zts-20190902/ioncube_loader_lin_7.4.so 
COPY ixed.7.4.lin /usr/local/lib/php/extensions/no-debug-non-zts-20190902/ixed.7.4.lin
COPY 01-extensions.conf /usr/local/etc/php/conf.d/01-extensions.ini
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions json pdo pdo-mysql zip gd mbstring curl xml bcmath soap intl
RUN docker-php-ext-install mysqli pdo pdo_mysql opcache
RUN useradd -d /srv/magento -M -s /usr/sbin/nologin -G www-data magento && \
    sed -i "s/user = www-data/user = magento/ig" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i "s/group = www-data/group = magento/ig" /usr/local/etc/php-fpm.d/www.conf
