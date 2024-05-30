#!/bin/bash

color_off='\033[0m'
Cyan='\033[0;36m'
BPurple='\033[1;35m'

echo -e "$BPurple\n***************** Initializing the Process *********************\n$color_off"


ver=$(php -v | head -1 | awk '{print $2}' | cut -d. -f1,2)

cd /root/

echo -e "$Cyan\n============== Downloading Ioncube =================\n$color_off"
wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.zip
sleep 2

echo -e "$Cyan\n================ Extracting Ioncube ================\n$color_off"
unzip ioncube_loaders_lin_x86-64.zip
sleep 2

echo -e "$Cyan\n=============== Copying Files =================\n$color_off"
cd /root/ioncube
scp loader-wizard.php /var/www/html/
scp ioncube_loader_lin_$ver.so /usr/lib64/php/modules/
echo "zend_extension = /usr/lib64/php/modules/ioncube_loader_lin_$ver.so" > /etc/php.d/00-ioncube.ini
sleep 2

echo -e "$Cyan\n=============== Giving Permissions =================\n$color_off"
chmod -R 777 /var/www/html/loader-wizard.php
chmod -R 777 /usr/lib64/php/modules/ioncube_loader_lin_$ver.so
chmod -R 777 /etc/php.d/00-ioncube.ini
sleep 1

echo -e "$Cyan\n=============== Restarting the Web Services =================\n$color_off"
sleep 1
echo "service httpd restart"
service httpd restart
sleep 2
echo -e "$BPurple\n     Ioncube configuration Completed. Please reload the Page       \n$color_off"



