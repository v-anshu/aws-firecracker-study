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

make clean
