#!/bin/bash

sudo apt update
sudo apt upgrade -y

read -p "Enter DNS 01 : "  DNS1
read -p "Enter DNS 02 : "  DNS2

echo -e "nameserver $DNS1 \nnameserver $DNS2" > /etc/resolv.conf

read -p "Enter Username : " username
read -s -p "Enter Password : " password

sudo useradd -m $username
sudo usermod -aG sudo $username
echo "$username:$password" | sudo chpasswd


sudo usermod -s /bin/bash $username
