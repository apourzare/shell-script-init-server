#!/bin/bash

sudo apt update
sudo apt upgrade -y

read -p "Enter DNS 01 :"  DNS1
read -p "Enter DNS 02 :"  DNS2

echo -e "nameserver " + DNS1 + "\nnameserver " + DNS2 > /etc/resolv.conf

read -p "Enter Username" username
read -s -p "Enter Password" password

sudo useradd -m $username
sudo usermod -aG sudo $username
echo "$username:$password" | sudo chpasswd

sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

apt-cache policy docker-ce

sudo apt install docker-ce

sudo systemctl status docker

sudo usermod -aG docker ${USER}
groups

sudo usermod -aG docker $username
