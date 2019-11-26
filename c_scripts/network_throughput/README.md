# Network Throughput Tests

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

Default memory is 2 GB. Limit CPU to 1.
```
sudo docker run --runtime=runsc --cpus="1.0" --rm -it ubuntu:18.04
```
