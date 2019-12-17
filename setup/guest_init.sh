#!/bin/sh

apt update

# Install vim (No editor in gVisor Container)
Y | apt install vim
echo "Installed vim"

# Install GCC
apt install build-essential
Y | apt-get install manpages-dev
echo "Installed GCC"

# Install curl (Network)
Y | apt-get install curl
echo "Installed curl"

Y | apt-get install wget
echo "Installed wget"
