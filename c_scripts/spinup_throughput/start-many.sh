#!/bin/bash

#Usage
## bash start-many.sh 0 2
## Will start VM#0 to VM#2.

start="${1:-0}"
upperlim="${2:-1}"

for ((i=start; i<upperlim; i++)); do
  bash start-firecracker.sh "$i"
done
