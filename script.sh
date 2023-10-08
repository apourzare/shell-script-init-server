#!/bin/bash

sudo apt update
sudo apt upgrade -y


read -p "لطفا رمز عبور را وارد کنید : " username
read -p -s "لطفا رمز عبور را وارد کنید : " password

sudo useradd -m $username
sudo usermod -aG sudo $username
echo "$username:$password" | sudo chpasswd

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo usermod -aG docker $username

sudo systemctl start docker

cat <<EOF | sudo tee /etc/systemd/system/docker-autostart.service
[Unit]
Description=Autostart Docker on system boot

[Service]
ExecStart=/usr/bin/dockerd
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable docker-autostart.service
