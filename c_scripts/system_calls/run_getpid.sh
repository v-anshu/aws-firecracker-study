#!/bin/sh

make getpid

echo "Invoking system call: getpid for 1k iterations"
rm -f ./results/results_getpid_1k.txt
touch ./results/results_getpid_1k.txt
./getpid 1000 >> ./results/results_getpid_1k.txt

echo "Invoking system call: getpid for 10k iterations"
rm -f ./results/results_getpid_10k.txt
touch ./results/results_getpid_10k.txt
./getpid 10000 >> ./results/results_getpid_10k.txt

echo "Invoking system call: getpid for 100k iterations"
rm -f ./results/results_getpid_100k.txt
touch ./results/results_getpid_100k.txt
./getpid 100000 >> ./results/results_getpid_100k.txt

echo "Invoking system call: getpid for 1m iterations"
rm -f ./results/results_getpid_1m.txt
touch ./results/results_getpid_1m.txt
./getpid 1000000 >> ./results/results_getpid_1m.txt

echo "Invoking system call: getpid for 10m iterations"
rm -f ./results/results_getpid_10m.txt
touch ./results/results_getpid_10m.txt
./getpid 10000000 >> ./results/results_getpid_10m.txt

echo "Invoking system call: getpid for 100m iterations"
rm -f ./results/results_getpid_100m.txt
touch ./results/results_getpid_100m.txt
./getpid 100000000 >> ./results/results_getpid_100m.txt

make clean