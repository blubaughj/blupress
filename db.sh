#!/bin/bash
source /tmp/variables.sh 
sudo apt-get update
sudo apt-get upgrade -y
sudo apt install mariadb-server -y

sudo mysql -e "UPDATE mysql.user SET Password=PASSWORD('password123') WHERE User='root';"
sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -e "DROP DATABASE test;" || true
sudo mysql -e "FLUSH PRIVILEGES;"

sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

sudo systemctl restart mysql
sudo ufw allow mysql

export DB_PASSWORD="${DB_PASSWORD:-123}"
export DB_USER="${DB_USER:-abc}"
export DB_NAME="${DB_NAME:-def}"


sudo mysql -e "CREATE DATABASE ${DB_NAME};"
sudo mysql -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
sudo mysql -e "FLUSH PRIVILEGES;"
