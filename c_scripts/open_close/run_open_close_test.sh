#!/usr/bin/env bash
make
./open_close 1000 makefile > open_close_disk_1000.txt
./open_close 10000 makefile > open_close_disk_10000.txt
./open_close 100000 makefile > open_close_disk_100000.txt
./open_close 1000000 makefile > open_close_disk_1000000.txt

touch /mnt/tmpfs1/test
./open_close 1000 /mnt/tmpfs1/test > open_close_tmpfs_1000.txt
./open_close 10000 /mnt/tmpfs1/test > open_close_tmpfs_10000.txt
./open_close 100000 /mnt/tmpfs1/test > open_close_tmpfs_100000.txt
./open_close 1000000 /mnt/tmpfs1/test > open_close_tmpfs_1000000.txt
make clean
