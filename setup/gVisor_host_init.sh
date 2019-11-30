#!/bin/sh

# Install acl
sudo apt-get update
Y | sudo apt-get install acl
echo "Installed acl"

# Install Docker
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
Y | sudo apt-get install docker-ce docker-ce-cli containerd.io
echo "Installed Docker"

# Download gVisor Binary
(
  set -e
  URL=https://storage.googleapis.com/gvisor/releases/nightly/latest
  wget ${URL}/runsc
  wget ${URL}/runsc.sha512
  sha512sum -c runsc.sha512
  rm -f runsc.sha512
  sudo mv runsc /usr/local/bin
  sudo chown root:root /usr/local/bin/runsc
  sudo chmod 0755 /usr/local/bin/runsc
)
echo "Downloaded gVisor Binary"

# Configure Docker
sudo runsc install
echo "Configured Docker"

# Restart Docker daemon
sudo systemctl restart docker
echo "Restarted Docker daemon"

# Run a container using runsc
docker run --runtime=runsc --rm hello-world
