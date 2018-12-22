#!/bin/bash
source /tmp/variables.sh
sudo apt-get update
sudo apt-get upgrade -y
sudo apt install apache2 mysql-client php7.2 libapache2-mod-php7.2 php-mysql php-curl php-json php-cgi -y
sudo sed -i 's/^KeepAlive .*/KeepAlive On/' /etc/apache2/apache2.conf
sudo sed -i 's/^MaxKeepAliveRequests.*/MaxKeepAliveRequests 50/' /etc/apache2/apache2.conf
sudo sed -i 's/^KeepAliveTimeout.*/KeepAliveTimeout 5/' /etc/apache2/apache2.conf
sudo sed -i 's/^StartServers.*/StartServers  4/' /etc/apache2/mods-available/mpm_prefork.conf
sudo sed -i 's/^MinSpareServers.*/MinSpareServers  3/' /etc/apache2/mods-available/mpm_prefork.conf
sudo sed -i 's/^MaxSpareServers.*/MaxSpareServers  40/' /etc/apache2/mods-available/mpm_prefork.conf
sudo sed -i 's/^MaxRequestWorkers.*/MaxRequestWorkers  200/' /etc/apache2/mods-available/mpm_prefork.conf
sudo sed -i 's/^MaxConnectionsPerChild.*/MaxConnectionsPerChild  10000/' /etc/apache2/mods-available/mpm_prefork.conf

export SITE_NAME="${SITE_NAME:blupress}"
