#!/bin/bash

# Update package lists and install MySQL Server
sudo apt update -y
sudo apt install mysql-server -y

# Start MySQL service and enable it to start on boot
sudo systemctl start mysql.service
sudo systemctl enable mysql.service

# Access MySQL and execute commands to create database and user
sudo mysql << EOF
CREATE DATABASE wordpress;
CREATE USER 'wordpressuser'@'%' IDENTIFIED BY 'Paula123@';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'%';
FLUSH PRIVILEGES;
EOF

# Allow remote connections to MySQL server by modifying bind-address
sudo sed -i 's/^bind-address\s*=.*$/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Restart MySQL service to apply changes
sudo systemctl restart mysql
