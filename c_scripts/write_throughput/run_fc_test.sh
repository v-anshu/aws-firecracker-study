#!/usr/bin/env bash
host="host-test.txt"
make write
./write 100000 4 ${host} > write_host_4KB.txt
./write 100000 16 ${host} > write_host_16KB.txt
./write 100000 64 ${host} > write_host_64KB.txt
./write 100000 256 ${host} > write_host_256KB.txt
./write 100000 512 ${host} > write_host_512KB.txt
./write 100000 1024 ${host} > write_host_1MB.txt

mount -t tmpfs -o size=512m tmpfs /mnt/tmpfs
int_tmpfs="/mnt/tmpfs/int-tmpfs-test.txt"
./write 100000 4 ${int_tmpfs} > write_inttmpfs_4KB.txt
./write 100000 16 ${int_tmpfs} > write_inttmpfs_16KB.txt
./write 100000 64 ${int_tmpfs} > write_inttmpfs_64KB.txt
./write 100000 256 ${int_tmpfs} > write_inttmpfs_256KB.txt
./write 100000 512 ${int_tmpfs} > write_inttmpfs_512KB.txt
./write 100000 1024 ${int_tmpfs} > write_inttmpfs_1MB.txt

ext_tmpfs="/mnt/ext-tmpfs-test.txt"
/write 100000 4 ${ext_tmpfs} > write_exttmpfs_4KB.txt
./write 100000 16 ${ext_tmpfs} > write_exttmpfs_16KB.txt
./write 100000 64 ${ext_tmpfs} > write_exttmpfs_64KB.txt
./write 100000 256 ${ext_tmpfs} > write_exttmpfs_256KB.txt
./write 100000 512 ${ext_tmpfs} > write_exttmpfs_512KB.txt
./write 100000 1024 ${ext_tmpfs} > write_exttmpfs_1MB.txt
make clean
