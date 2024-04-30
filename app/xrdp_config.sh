#!/bin/bash

# Install server with GUI
yum grouplist
yum group install "Server with GUI" -y --nobest

# Install TigerVNC"
yum install tigervnc-server -y


# Download & install latest epel package 
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
sudo yum install epel-release-latest-9.noarch.rpm

# Update yum & reboot
yum -y update
sudo reboot

# Install & start xrdp
yum install xrdp -y
systemctl start xrdp.service
systemctl status xrdp.service

# Check xrdp service port
netstat -tnlp

# Add port to firewall
firewall-cmd --permanent --add-port=3389/tcp
firewall-cmd --reload
systemctl status firewalld
sudo firewall-cmd --zone=public --list-ports | grep 3389

# Set the root password
passwd root


