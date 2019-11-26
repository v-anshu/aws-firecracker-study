#!/bin/sh

make net

echo "Downloading 5 MB"
rm -f results_5MB.txt
touch results_5MB.txt
./net 100 5MB >> results_5MB.txt

echo "Downloading 10 MB"
rm -f results_10MB.txt
touch results_10MB.txt
./net 100 10MB >> results_10MB.txt

echo "Downloading 100 MB"
rm -f results_100MB.txt
touch results_100MB.txt
./net 100 100MB >> results_100MB.txt

echo "Downloading 512 MB"
rm -f results_512MB.txt
touch results_512MB.txt
./net 100 512MB >> results_512MB.txt

echo "Downloading 1 GB"
rm -f results_1GB.txt
touch results_1GB.txt
./net 100 1GB >> results_1GB.txt

make clean
