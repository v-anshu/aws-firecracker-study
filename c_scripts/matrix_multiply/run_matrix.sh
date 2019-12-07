#!/bin/sh

make matrix
mkdir results

echo "Computing a 1000x1000 matrix multiplication for 10 iterations"
rm -f ./results/results_matrix_1k_10.txt
touch ./results/results_matrix_1k_10.txt
./matrix 1000 10 >> ./results/results_matrix_1k_10.txt

echo "Computing a 1000x1000 matrix multiplication for 50 iterations"
rm -f ./results/results_matrix_1k_50.txt
touch ./results/results_matrix_1k_50.txt
./matrix 1000 50 >> ./results/results_matrix_1k_50.txt

echo "Computing a 1000x1000 matrix multiplication for 100 iterations"
rm -f ./results/results_matrix_1k_100.txt
touch ./results/results_matrix_1k_100.txt
./matrix 1000 100 >> ./results/results_matrix_1k_100.txt

make clean