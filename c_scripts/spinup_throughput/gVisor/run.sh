#!/bin/bash
#author		       :Arpit
#description     :Spinup multiple contianers for measuring throughput
#==============================================================================

make spinup

echo "Sample run to download alpine image"
./spinup 1 1 runsc 1 >> /dev/null

# Kill all cerated containers
sudo docker container kill $(sudo docker ps -q)
echo ""

thread_count="${1:-1}" # Default thread_count = 1
container_per_thread="${2:-1}" # Default container_per_thread = 1

spinup_containers() {

  echo `date`

  rm -f "$PWD/output/stats-t-$1-c-$2"
  touch "$PWD/output/stats-t-$1-c-$2"

  echo "Starting $(($1*$2)) containers with $1 threads; $2 containers per thread"
  echo "Starting $(($1*$2)) containers with $1 threads; $2 containers per thread" >> "$PWD/output/stats-t-$1-c-$2"
  echo "**********************************" >> "$PWD/output/stats-t-$1-c-$2"

  ./spinup $1 1 runsc $2 >> "$PWD/output/stats-t-$1-c-$2"

  # Kill all cerated containers
  sudo docker container kill $(sudo docker ps -q) >> /dev/null
  echo "**********************************" >> "$PWD/output/stats-t-$1-c-$2"
  echo ""

  cat "$PWD/output/stats-t-$1-c-$2"
}

spinup_containers $thread_count $container_per_thread
