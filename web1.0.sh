#!/bin/bash
source /tmp/variables.sh
sudo a2dismod mpm_event
sudo a2enmod mpm_prefork


sudo sed -i 's/error_reporting .*/error_reporting E_COMPILE_ERROR | E_RECOVERABLE_ERROR | E_ERROR | E_CORE_ERROR/' /etc/php/7.2/apache2/php.ini
sudo sed -i 's/max_input_time .*/error_reporting 30/' /etc/php/7.2/apache2/php.ini
sudo sed -i 's/error_log .*/error_log /var/log/php/error.log/' /etc/php/7.2/apache2/php.ini

sudo systemctl restart apache2
