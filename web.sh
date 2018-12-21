#!/bin/bash
source /tmp/variables.sh
sudo apt-get update
sudo apt-get upgrade -y
sudo apt install apache2 mysql-client php7.2 libapache2-mod-php7.2 php-mysql php-curl php-json php-cgi -y
