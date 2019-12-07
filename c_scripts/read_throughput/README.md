# Read Throughput

## gVisor: Instructions to run

* Creating external tmpfs:
```
sudo mkdir /mnt/tmpfs
sudo mount -t tmpfs -o size=512m tmpfs /mnt/tmpfs
```
* Start a Docker container on gVisor with Ubuntu and 2g memory and 1 vCPU with external tmpfs:
```
sudo docker run --rm -it --runtime=runsc --cpus="1.0" -m 2g --name gvisorExtTmp --mount type=tmpfs,destination=/mnt/tmpfs ubuntu:18.04
```

* Start a Docker container on gVisor with Ubuntu and 2g memory and 1 vCPU:
```
sudo docker run --runtime=runsc -m 2g --cpus="1.0" --rm -it ubuntu:18.04
```

* Assumes installation of gcc. Check guest_init.sh for details

* Execute:
```
sh run_read_disk.sh
sh run_read_external_tmpfs_FC.sh
sh run_read_external_tmpfs_gVisor.sh
sh run_read_internal_tmpfs_FC.sh

```


## Firecracker: Instructions to run


* Start a FC microVM with 2g memory and 1 vCPU with external tmpfs:
```
sudo mkdir /mnt/tmpfs
sudo mount -t tmpfs -o size=1G tmpfs /mnt/tmpfs
truncate -s 1G /mnt/tmpfs/file.qcow2
sudo mkfs.ext4 /mnt/tmpfs/file.qcow2
firectl --kernel=hello-vmlinux.bin --root-drive=rootfs.ext4 --kernel-opts="console=ttyS0 noapic reboot=k panic=1 pci=off nomodules rw" --tap-device=tap0/$MAC --add-drive=/mnt/tmpfs/file.qcow2:rw -m=2048 -c=1
mount /dev/vdb /mnt

```

* Start a FC microVM with 2g memory and 1 vCPU:
```
firectl --kernel=hello-vmlinux.bin --root-drive=rootfs.ext4 --kernel-opts="console=ttyS0 noapic reboot=k panic=1 pci=off nomodules rw" --tap-device=tap0/$MAC -m=2048 -c=1
```

* Network Setup:
(Assuming network setup has been done for the host)
```
ifconfig eth0 up && ip addr add dev eth0 172.20.0.2/24
ip route add default via 172.20.0.1 && echo "nameserver 8.8.8.8" > /etc/resolv.conf
```

* Internal tmpfs (inside guest):
```
mkdir /mnt/tmpfs
mount -t tmpfs -o size=1G tmpfs /mnt/tmpfs
```

* Assumes installation of gcc. Check guest_init.sh for details

* Execute:
```
sh run_read_disk.sh
sh run_read_external_tmpfs_FC.sh
sh run_read_external_tmpfs_gVisor.sh
sh run_read_internal_tmpfs_FC.sh
```