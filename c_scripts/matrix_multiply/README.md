# Matrix Multiplication

## gVisor: Instructions to run

* Start a Docker container on gVisor with Ubuntu and 2g memory and 1 vCPU:
```
sudo docker run --runtime=runsc -m 2g --cpus="1.0" --rm -it ubuntu:18.04
```

* Assumes installation of gcc. Check guest_init.sh for details

* Execution:
```
sh run_matrix.sh
```


## Firecracker: Instructions to run

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

* Assumes installation of gcc. Check guest_init.sh for details

* Execution:
```
sh run_matrix.sh
```