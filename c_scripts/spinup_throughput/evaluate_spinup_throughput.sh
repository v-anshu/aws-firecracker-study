#!/bin/bash

# Usage
## bash evaluate_spinup_throughput.sh

DATA_DIR="fc_logs"
DEST="$PWD/data.log"

# rm -f $DEST

pushd $DATA_DIR > /dev/null

COUNT=`ls fc-sb* | sort -V | tail -1 | cut -d '-' -f 2 | cut -f 2 -d 'b'`

total_time=0
for i in `seq 0 $COUNT`
do
  boot_time=`grep Guest-boot fc-sb${i}-log | cut -f 2 -d '=' | cut -f 4 -d ' '`
  total_time=$((total_time + boot_time))
  # echo "$i boot $boot_time ms"
done

echo "Total microVMs = $((COUNT+1))"
echo "Total Time = $total_time ms"
echo -n "Throughput (microVM per sec) = "
echo "scale=2 ; ($COUNT+1)*1000 / $total_time" | bc

popd > /dev/null
