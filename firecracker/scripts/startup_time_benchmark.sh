#!/bin/bash

# Single Threaded Run
# time parallel bash startup_time_benchmark.sh ::: 1234 > /dev/null 2>&1
# Multi Threaded Run
# time parallel bash startup_time_benchmark.sh ::: 1001 2101 3201 4301 5401 6501 7601 8701 9801 10901 > /dev/null 2>&1
# Non Parallel Run
# time bash startup_time_benchmark.sh 1 > /dev/null 2>&1

arch=`uname -m`
kernel_path="hello-vmlinux.bin"
rootfs_path="hello-rootfs.ext4"

metricsfile="/dev/null"

x86_64_kernel_boot_args="reboot=k panic=1 pci=off"
aarch64_kernel_boot_args="keep_bootcon reboot=k panic=1 pci=off"

start=$1
end=$start+100

for ((i=$start; i<$end; i++)); do

  rm -f /tmp/firecracker-$i.socket

  ./firecracker --api-sock /tmp/firecracker-$i.socket &

  # Uncomment this to start vm logging
  # logfile="fc-vm$i-log"
  # rm -rf $logfile
  # touch $logfile
  #
  # curl --silent --unix-socket /tmp/firecracker-$i.socket -i \
  #   -X PUT 'http://localhost/logger' \
  #   -H 'Accept: application/json'           \
  #   -H 'Content-Type: application/json'     \
  #   -d "{
  #         \"log_fifo\": \"$logfile\",
  #         \"metrics_fifo\": \"$metricsfile\",
  #         \"level\": \"Info\",
  #         \"show_level\": false,
  #         \"show_log_origin\": false
  #    }"

  if [ ${arch} = "x86_64" ]; then
    curl --silent --unix-socket /tmp/firecracker-$i.socket -i \
        -X PUT 'http://localhost/boot-source'   \
        -H 'Accept: application/json'           \
        -H 'Content-Type: application/json'     \
        -d "{
              \"kernel_image_path\": \"${kernel_path}\",
              \"boot_args\": \"${x86_64_kernel_boot_args}\"
         }"
  elif [ ${arch} = "aarch64" ]; then
      curl --silent --unix-socket /tmp/firecracker-$i.socket -i \
        -X PUT 'http://localhost/boot-source'   \
        -H 'Accept: application/json'           \
        -H 'Content-Type: application/json'     \
        -d "{
              \"kernel_image_path\": \"${kernel_path}\",
              \"boot_args\": \"${aarch64_kernel_boot_args}\"
         }"
  else
      echo "Cannot run firecracker on $arch architecture!"
      exit 1
  fi

  curl --silent --unix-socket /tmp/firecracker-$i.socket -i \
    -X PUT 'http://localhost/drives/rootfs' \
    -H 'Accept: application/json'           \
    -H 'Content-Type: application/json'     \
    -d "{
          \"drive_id\": \"rootfs\",
          \"path_on_host\": \"${rootfs_path}\",
          \"is_root_device\": true,
          \"is_read_only\": false
     }"

   curl --silent --unix-socket /tmp/firecracker-$i.socket -i \
       -X PUT 'http://localhost/actions'       \
       -H  'Accept: application/json'          \
       -H  'Content-Type: application/json'    \
       -d '{
           "action_type": "InstanceStart"
        }'

  pkill -f "firecracker\-$i\.socket"
done
