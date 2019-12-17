#!/bin/bash
#author		       :Arpit
#description     :Spinup multiple microVMs for measuring throughput
#==============================================================================

thread_count="${1:-1}" # Default thread_count = 1

echo "Thread Count = $thread_count"
echo ""

spinup_microvms() {

  rm -f $PWD/hello-vmlinux.bin
  rm -f $PWD/hello-rootfs.ext4

  curl -fsSL -o hello-vmlinux.bin https://s3.amazonaws.com/spec.ccfc.min/img/hello/kernel/hello-vmlinux.bin
  curl -fsSL -o hello-rootfs.ext4 https://s3.amazonaws.com/spec.ccfc.min/img/hello/fsfiles/hello-rootfs.ext4

  echo "Starting $1 microVMs with $thread_count thread"
  echo "**********************************"

  # Remove existings logs and create log directory
  rm -f $PWD/data.log

  bash parallel-start-many.sh 0 $1 $thread_count
  bash evaluate_spinup_throughput.sh

  # Kill all microVMs
  ps -ef | grep -i firecracker | grep -v grep | awk '{print $2}' | xargs kill -9
  echo "**********************************"
  echo ""
}

spinup_microvms 10
spinup_microvms 100
spinup_microvms 1000
