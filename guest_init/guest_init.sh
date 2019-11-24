#!/bin/sh

# Install GCC
apt update
apt install build-essential
apt-get install manpages-dev
echo "Installed GCC"

# Install curl
apt-get install curl
echo "Installed curl"
