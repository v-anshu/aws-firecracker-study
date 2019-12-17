#!/bin/sh

make matrix
mkdir results

echo "Computing a 100 matrix multiplication for 10 iterations"
./matrix 100 10 > ./results/results_matrix_100_10.txt

echo "Computing a 100 matrix multiplication for 50 iterations"
./matrix 100 50 > ./results/results_matrix_100_50.txt

echo "Computing a 100 matrix multiplication for 100 iterations"
./matrix 100 100 > ./results/results_matrix_100_100.txt

echo "Computing a 250 matrix multiplication for 10 iterations"
./matrix 250 10 > ./results/results_matrix_250_10.txt

echo "Computing a 250 matrix multiplication for 50 iterations"
./matrix 250 50 > ./results/results_matrix_250_50.txt

echo "Computing a 250 matrix multiplication for 100 iterations"
./matrix 250 100 > ./results/results_matrix_250_100.txt

echo "Computing a 500 matrix multiplication for 10 iterations"
./matrix 500 10 > ./results/results_matrix_500_10.txt

echo "Computing a 500 matrix multiplication for 50 iterations"
./matrix 500 50 > ./results/results_matrix_500_50.txt

echo "Computing a 500 matrix multiplication for 100 iterations"
./matrix 500 100 > ./results/results_matrix_500_100.txt

echo "Computing a 1000 matrix multiplication for 10 iterations"
./matrix 1000 10 > ./results/results_matrix_1000_10.txt

echo "Computing a 1000 matrix multiplication for 50 iterations"
./matrix 1000 50 > ./results/results_matrix_1000_50.txt

echo "Computing a 1000 matrix multiplication for 100 iterations"
./matrix 1000 100 > ./results/results_matrix_1000_100.txt
make clean
