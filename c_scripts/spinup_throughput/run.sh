#!/bin/bash

echo "Starting 10 microVMs with 1 thread"
echo "**********************************"

# Remove existings logs and create log directory
rm -f $PWD/data.log

bash parallel-start-many.sh 0 10 1
bash evaluate_spinup_throughput.sh

# Kill all microVMs
ps -ef | grep -i firecracker | grep -v grep | awk '{print $2}' | xargs kill -9
echo "**********************************"
echo ""

echo "Starting 100 microVMs with 1 thread"
echo "**********************************"

# Remove existings logs and create log directory
rm -f $PWD/data.log

bash parallel-start-many.sh 0 100 1
bash evaluate_spinup_throughput.sh

# Kill all microVMs
ps -ef | grep -i firecracker | grep -v grep | awk '{print $2}' | xargs kill -9
echo "**********************************"
echo ""

echo "Starting 1000 microVMs with 1 thread"
echo "**********************************"

# Remove existings logs and create log directory
rm -f $PWD/data.log

bash parallel-start-many.sh 0 1000 1
bash evaluate_spinup_throughput.sh

# Kill all microVMs
ps -ef | grep -i firecracker | grep -v grep | awk '{print $2}' | xargs kill -9
echo "**********************************"
echo ""
