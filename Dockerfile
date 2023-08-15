FROM ubuntu:latest

# INSTALL PHP5.6

RUN apt update \
    && apt install -y software-properties-common \
    && add-apt-repository -y ppa:ondrej/php

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y php5.6 \
    && apt install -y php5.6-curl php5.6-mbstring php5.6-xml php5.6-gd php5.6-zip

# INSTALL COMPOSER

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');"

RUN mv composer.phar /usr/local/bin/composer

RUN composer self-update --1

# INSTALL OTHER PACKAGES

RUN apt install -y sudo zip unzip