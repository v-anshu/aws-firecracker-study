#!/usr/bin/env bash
make malloc_free
./malloc_free 100000 1 > malloc_free_1KB.txt
./malloc_free 100000 2 > malloc_free_2KB.txt
./malloc_free 100000 4 > malloc_free_4KB.txt
./malloc_free 100000 8 > malloc_free_8KB.txt
./malloc_free 100000 512 > malloc_free_512KB.txt
./malloc_free 100000 1024 > malloc_free_1MB.txt
make malloc_without_free
./malloc_without_free 100000 1 > malloc_without_free_1KB.txt
./malloc_without_free 100000 2 > malloc_without_free_2KB.txt
./malloc_without_free 100000 4 > malloc_without_free_4KB.txt
./malloc_without_free 100000 8 > malloc_without_free_8KB.txt
./malloc_without_free 100000 512 > malloc_without_free_512KB.txt
./malloc_without_free 100000 1024 > malloc_without_free_1MB.txt