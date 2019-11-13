#!/bin/bash

# TODO: Take number of fc param as input.
# TODO: Allow user to run this in quiet mode.

arch=`uname -m`
kernel_path="hello-vmlinux.bin"
rootfs_path="hello-rootfs.ext4"

metricsfile="/dev/null"

x86_64_kernel_boot_args="reboot=k panic=1 pci=off"
aarch64_kernel_boot_args="keep_bootcon reboot=k panic=1 pci=off"

for ((i=20; i<22; i++)); do

  rm -f /tmp/firecracker-$i.socket

  ./firecracker --api-sock /tmp/firecracker-$i.socket &

  logfile="fc-vm$i-log"
  rm -rf $logfile
  touch $logfile

  curl --unix-socket /tmp/firecracker-$i.socket -i \
    -X PUT 'http://localhost/logger' \
    -H 'Accept: application/json'           \
    -H 'Content-Type: application/json'     \
    -d "{
          \"log_fifo\": \"$logfile\",
          \"metrics_fifo\": \"$metricsfile\",
          \"level\": \"Info\",
          \"show_level\": false,
          \"show_log_origin\": false
     }"

  if [ ${arch} = "x86_64" ]; then
    curl --unix-socket /tmp/firecracker-$i.socket -i \
        -X PUT 'http://localhost/boot-source'   \
        -H 'Accept: application/json'           \
        -H 'Content-Type: application/json'     \
        -d "{
              \"kernel_image_path\": \"${kernel_path}\",
              \"boot_args\": \"${x86_64_kernel_boot_args}\"
         }"
  elif [ ${arch} = "aarch64" ]; then
      curl --unix-socket /tmp/firecracker-$i.socket -i \
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

  curl --unix-socket /tmp/firecracker-$i.socket -i \
    -X PUT 'http://localhost/drives/rootfs' \
    -H 'Accept: application/json'           \
    -H 'Content-Type: application/json'     \
    -d "{
          \"drive_id\": \"rootfs\",
          \"path_on_host\": \"${rootfs_path}\",
          \"is_root_device\": true,
          \"is_read_only\": false
     }"

   curl --unix-socket /tmp/firecracker-$i.socket -i \
       -X PUT 'http://localhost/actions'       \
       -H  'Accept: application/json'          \
       -H  'Content-Type: application/json'    \
       -d '{
           "action_type": "InstanceStart"
        }'
done

