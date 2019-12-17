#!/bin/sh

make net

echo "Downloading 512 MB"
rm -f results_512MB.txt
touch results_512MB.txt
./net 100 512MB >> results_512MB.txt

make clean
