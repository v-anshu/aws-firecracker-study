#!/usr/bin/env bash
make openclose
./openclose 1000 > openclose_1000.txt
./openclose 10000 > openclose_10000.txt
./openclose 100000 > openclose_100000.txt
./openclose 1000000 > openclose_1000000.txt
make clean
