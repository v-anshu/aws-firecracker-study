#!/bin/sh

make net

echo "Downloading 1 GB"
rm -f results_1GB.txt
touch results_1GB.txt
./net 100 1GB >> results_1GB.txt

make clean
