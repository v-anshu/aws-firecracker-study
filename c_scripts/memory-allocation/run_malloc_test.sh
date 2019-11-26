#!/usr/bin/env bash
make clean
make malloc_free
./malloc_free 100000 1 > malloc_free_1KB.txt
echo "Malloc with free 1KB done..."
./malloc_free 100000 2 > malloc_free_2KB.txt
echo "Malloc with free 2KB done..."
./malloc_free 100000 4 > malloc_free_4KB.txt
echo "Malloc with free 4KB done..."
./malloc_free 100000 8 > malloc_free_8KB.txt
echo "Malloc with free 8KB done..."
./malloc_free 100000 512 > malloc_free_512KB.txt
echo "Malloc with free 512KB done..."
./malloc_free 100000 1024 > malloc_free_1MB.txt
echo "Malloc with free 1MB done..."
make clean
make malloc_without_free
./malloc_without_free 100000 1 > malloc_free_1KB.txt
echo "Malloc without free 1KB done..."
./malloc_without_free 100000 2 > malloc_free_2KB.txt
echo "Malloc without free 2KB done..."
./malloc_without_free 100000 4 > malloc_free_4KB.txt
echo "Malloc without free 4KB done..."
./malloc_without_free 100000 8 > malloc_free_8KB.txt
echo "Malloc without free 8KB done..."
./malloc_without_free 100000 512 > malloc_free_512KB.txt
echo "Malloc without free 512KB done..."
./malloc_without_free 100000 1024 > malloc_free_1MB.txt
echo "Malloc without free 1MB done..."
