#!/bin/bash

#update packages
sudo apt-get update -y
sudo apt-get upgrade -y

#install a bunch of new software
sudo apt-get install nginx -y
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install nodejs -y 
sudo apt-get install npm -y
sudo apt-get install python-software-properties -y
sudo npm install pm2 -g -y

#set up reverse proxy
rm -rf /etc/nginx/sites-available/default
cp ~/default /etc/nginx/sites-available/

sudo systemctl restart nginx

cd ~/app

sudo npm install -y

pm2 kill
pm2 init
pm2 start app.js
