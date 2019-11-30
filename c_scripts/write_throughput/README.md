# System Calls Tests

## gVisor: Instructions to run

* Start a Docker container on gVisor with Ubuntu and 2g memory and 1 vCPU:
```
sudo docker run --runtime=runsc -m 2g --cpus="1.0" --rm -it ubuntu:18.04
```

* Assumes installation of gcc. Check guest_init.sh for details


## Firecracker: Instructions to run

* Start a FC microVM with 2g memory and 1 vCPU:
```
firectl --kernel=hello-vmlinux.bin --root-drive=rootfs.ext4 --kernel-opts="console=ttyS0 noapic reboot=k panic=1 pci=off nomodules rw" --tap-device=tap0/$MAC -m=2048 -c=1
```

* Start a microVM with 2g memory, 1 vCPU and tmpfs:
```
firectl --kernel=hello-vmlinux.bin --root-drive=rootfs.ext4 --kernel-opts="console=ttyS0 noapic reboot=k panic=1 pci=off nomodules rw" --tap-device=tap0/$MAC --add-drive=/mnt/tmpfs1/file.qcow2:rw -m=2048 -c=1
```

# Mount tmpfs
```
sudo mkdir /mnt/tmpfs
mount -t tmpfs -o size=512m tmpfs /mnt/tmpfs
```

# Tests
1. Run it on disk
2. Run it on internal tmpfs
3. Run it on external tmpfs
