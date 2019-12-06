#!/bin/sh

make read
mkdir results

echo "Reading a file from disk for 100k iterations, read size = 4KB"
rm -f ./results/results_read_ext_tmpfs_4KB.txt
touch ./results/results_read_ext_tmpfs_4KB.txt
./read  100000 4000 /mnt/tmpfs/file >> ./results/results_read_ext_tmpfs_4KB.txt

echo "Reading a file from disk for 100k iterations, read size = 16KB"
rm -f ./results/results_read_ext_tmpfs_16KB.txt
touch ./results/results_read_ext_tmpfs_16KB.txt
./read  100000 16000 /mnt/tmpfs/file >> ./results/results_read_ext_tmpfs_16KB.txt

echo "Reading a file from disk for 100k iterations, read size = 64KB"
rm -f ./results/results_read_ext_tmpfs_64KB.txt
touch ./results/results_read_ext_tmpfs_64KB.txt
./read  100000 64000 /mnt/tmpfs/file >> ./results/results_read_ext_tmpfs_64KB.txt

echo "Reading a file from disk for 100k iterations, read size = 256KB"
rm -f ./results/results_read_ext_tmpfs_256KB.txt
touch ./results/results_read_ext_tmpfs_256KB.txt
./read  100000 256000 /mnt/tmpfs/file >> ./results/results_read_ext_tmpfs_256KB.txt

echo "Reading a file from disk for 100k iterations, read size = 1MB"
rm -f ./results/results_read_ext_tmpfs_1MB.txt
touch ./results/results_read_ext_tmpfs_1MB.txt
./read  100000 1000000 /mnt/tmpfs/file >> ./results/results_read_ext_tmpfs_1MB.txt

make clean