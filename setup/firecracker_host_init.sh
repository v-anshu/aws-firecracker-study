#!/bin/sh

# Install acl
sudo apt-get update
Y | sudo apt-get install acl
echo "Installed acl"

# Install firectl
curl -Lo firectl https://firectl-release.s3.amazonaws.com/firectl-v0.1.0
curl -Lo firectl.sha256 https://firectl-release.s3.amazonaws.com/firectl-v0.1.0.sha256
sha256sum -c firectl.sha256
chmod +x firectl
sudo cp firectl /usr/bin/
echo "Installed firectl"

# Install Firecracker
latest=$(basename $(curl -fsSLI -o /dev/null -w  %{url_effective}  https://github.com/firecracker-microvm/firecracker/releases/latest))
curl -LOJ https://github.com/firecracker-microvm/firecracker/releases/download/${latest}/firecracker-${latest}
mv firecracker-${latest} firecracker
chmod +x firecracker
sudo cp firecracker /usr/bin/
echo "Installed Firecracker"

# Set read/write access to KVM
sudo setfacl -m u:${USER}:rw /dev/kvm
echo "Provided read/write access to KVM"

# Download kernel and root filesystem
curl -fsSL -o hello-vmlinux.bin https://s3.amazonaws.com/spec.ccfc.min/img/hello/kernel/hello-vmlinux.bin
curl -fsSL -o hello-rootfs.ext4 https://s3.amazonaws.com/spec.ccfc.min/img/hello/fsfiles/hello-rootfs.ext4
echo "Downloaded kernel and root filesystem"

# Create a microVM
firectl \
  --kernel=hello-vmlinux.bin \
  --root-drive=hello-rootfs.ext4
