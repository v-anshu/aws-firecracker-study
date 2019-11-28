#!/usr/bin/env bash
make
./open_close 1000 makefile > open_close_disk_1000.txt
./open_close 10000 makefile > open_close_disk_10000.txt
./open_close 100000 makefile > open_close_disk_100000.txt
./open_close 1000000 makefile > open_close_disk_1000000.txt

sudo mkdir /mnt/tmpfs1
mount -t tmpfs -o size=512m tmpfs /mnt/tmpfs1
touch /mnt/tmpfs1/test
./open_close 1000 /mnt/tmpfs1/test > open_close_tmpfs_1000.txt
./open_close 10000 /mnt/tmpfs1/test > open_close_tmpfs_10000.txt
./open_close 100000 /mnt/tmpfs1/test > open_close_tmpfs_100000.txt
./open_close 1000000 /mnt/tmpfs1/test > open_close_tmpfs_1000000.txt

touch /mnt/test
./open_close 1000 /mnt/test > open_close_ext_tmpfs_1000.txt
./open_close 10000 /mnt/test > open_close_ext_tmpfs_10000.txt
./open_close 100000 /mnt/test > open_close_ext_tmpfs_100000.txt
./open_close 1000000 /mnt/test > open_close_ext_tmpfs_1000000.txt
make clean
