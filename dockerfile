FROM ubuntu:16.04

MAINTAINER sambit@tier1agritech.co

#Update Repository
RUN apt-get update -y

#Install Apache2
RUN apt-get install -y apache2
RUN apt-get update -y \
    && apt-get install -y sed \
    && apt-get install -y nano \
    && apt-get install -y curl

#Install PHP Modules
RUN apt-get -y install software-properties-common \
    && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && apt-get -y update \
    && apt-get -y install php7.3 && apt-get -y install php7.3 libapache2-mod-php7.3 \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


#Copy Application Files
RUN rm -rf /var/www/html/* \
    && mkdir /var/www/html/D8-multisite
COPY ./ /var/www/html/D8-multisite/

WORKDIR /var/www/html/D8-multisite

RUN mv /var/www/html/D8-multisite/php.ini /etc/php/7.3/cli/php.ini \
    && apt-get --purge remove php-common -y && apt-get install php-common php-mysql php-cli -y \
    && apt-get install php7.3-xml -y && apt-get install php7.3-gd -y && apt-get install php7.3-mbstring -y \
    && apt-get install php7.3-curl -y && a2dismod mpm_event && a2enmod mpm_prefork \
    && mv /var/www/html/D8-multisite/apache2.conf /etc/apache2/apache2.conf \
    && mv /var/www/html/D8-multisite/d8-multisite.localhost.com.conf /etc/apache2/sites-available/ \
    && a2ensite d8-multisite.localhost.com.conf 

#Open Ports 80
EXPOSE 80


#ENV MYSQL_USER=root \
    #MYSQL_ROOT_PASSWORD=root \
    #MYSQL_VERSION=5.7 \
    #MYSQL_DATA_DIR=/var/lib/mysql \
    #MYSQL_RUN_DIR=/run/mysqld \
    #MYSQL_LOG_DIR=/var/log/mysql
#RUN apt-get update \
 #&& DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server=${MYSQL_VERSION}* \
 #&& rm -rf ${MYSQL_DATA_DIR} \
 #&& rm -rf /var/lib/apt/lists/*

#EXPOSE 3306/tcp

#RUN sed -i '4 i 127.0.0.1      d8multisite.localhost.com' /etc/hosts

