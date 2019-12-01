#!/bin/sh

make gettimeofday
mkdir results

echo "Invoking system call: gettimeofday for 1k iterations"
rm -f ./results/results_gettimeofday_1k.txt
touch ./results/results_gettimeofday_1k.txt
./gettimeofday 1000 >> ./results/results_gettimeofday_1k.txt

echo "Invoking system call: gettimeofday for 10k iterations"
rm -f ./results/results_gettimeofday_10k.txt
touch ./results/results_gettimeofday_10k.txt
./gettimeofday 10000 >> ./results/results_gettimeofday_10k.txt

echo "Invoking system call: gettimeofday for 100k iterations"
rm -f ./results/results_gettimeofday_100k.txt
touch ./results/results_gettimeofday_100k.txt
./gettimeofday 100000 >> ./results/results_gettimeofday_100k.txt

echo "Invoking system call: gettimeofday for 1m iterations"
rm -f ./results/results_gettimeofday_1m.txt
touch ./results/results_gettimeofday_1m.txt
./gettimeofday 1000000 >> ./results/results_gettimeofday_1m.txt

echo "Invoking system call: gettimeofday for 10m iterations"
rm -f ./results/results_gettimeofday_10m.txt
touch ./results/results_gettimeofday_10m.txt
./gettimeofday 10000000 >> ./results/results_gettimeofday_10m.txt

echo "Invoking system call: gettimeofday for 100m iterations"
rm -f ./results/results_gettimeofday_100m.txt
touch ./results/results_gettimeofday_100m.txt
./gettimeofday 100000000 >> ./results/results_gettimeofday_100m.txt

make clean