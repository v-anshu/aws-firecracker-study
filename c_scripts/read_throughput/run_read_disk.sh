#!/bin/sh

make read
mkdir results

echo "Reading a file from disk for 100k iterations, read size = 4KB"
rm -f ./results/results_read_4KB.txt
touch ./results/results_read_4KB.txt
./read  100000 4000 ./file >> ./results/results_read_4KB.txt

echo "Reading a file from disk for 100k iterations, read size = 16KB"
rm -f ./results/results_read_16KB.txt
touch ./results/results_read_16KB.txt
./read  100000 16000 ./file >> ./results/results_read_16KB.txt

echo "Reading a file from disk for 100k iterations, read size = 64KB"
rm -f ./results/results_read_64KB.txt
touch ./results/results_read_64KB.txt
./read  100000 64000 ./file >> ./results/results_read_64KB.txt

echo "Reading a file from disk for 100k iterations, read size = 256KB"
rm -f ./results/results_read_256KB.txt
touch ./results/results_read_256KB.txt
./read  100000 256000 ./file >> ./results/results_read_256KB.txt

echo "Reading a file from disk for 100k iterations, read size = 1MB"
rm -f ./results/results_read_1MB.txt
touch ./results/results_read_1MB.txt
./read  100000 1000000 ./file >> ./results/results_read_1MB.txt

make clean