# Open Close

## Environment Details
* 2 GB RAM
* 1 Core (vCPU)

## Firecracker

* Run Firecracker microVM with 2GB memory and 1 vCPU.
* Assuming network has been setup in Firecracker microVM
```
firectl --kernel=hello-vmlinux.bin --root-drive=rootfs.ext4 --kernel-opts="console=ttyS0 noapic reboot=k panic=1 pci=off nomodules rw" --tap-device=tap0/$MAC -m=2048 -c=1
```

## gVisor

* Default memory is 2 GB. Limit CPU to 1.
```
sudo docker run --runtime=runsc --cpus="1.0" --rm -it ubuntu:18.04
```

## Creating External tmpfs
```
sudo mkdir /mnt/tmpfs
mount -t tmpfs -o size=512m tmpfs /mnt/tmpfs
 docker run  --rm -it  --runtime=runsc --cpus="1.0" --name gvisorExtTmp --mount type=tmpfs,destination=/mnt/tmpfs  ubuntu:18.04
```
## Creating internal tmpfs in Firecracker
```
firectl --kernel=hello-vmlinux.bin --root-drive=rootfs.ext4 --kernel-opts="console=ttyS0 noapic reboot=k panic=1 pci=off nomodules rw" --tap-device=tap0/$MAC -m=2048 -c=1

sudo mkdir /mnt/tmpfs

mount -t tmpfs -o size=512m tmpfs /mnt/tmpfs
```
