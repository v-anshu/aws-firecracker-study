#!/bin/bash

# Single Threaded Run
# time parallel bash startup_time_benchmark.sh ::: 1234 > /dev/null 2>&1
# Multi Threaded Run
# time parallel bash startup_time_benchmark.sh ::: 1001 2101 3201 4301 5401 6501 7601 8701 9801 10901 > /dev/null 2>&1
# Non Parallel Run
# time bash startup_time_benchmark.sh 1 > /dev/null 2>&1

start=$1
end=$start+10
for ((i=$start; i<$end; i++)); do
  docker run --name MyContainer-$i --runtime=runsc --rm -it -d alpine
done

for ((i=$start; i<$end; i++)); do
  docker stop MyContainer-$i
done

docker stop $(docker ps -a -q)
