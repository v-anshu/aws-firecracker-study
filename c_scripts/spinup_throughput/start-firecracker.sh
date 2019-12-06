#!/bin/bash -e
SB_ID="${1:-0}" # Default to sb_id=0

RO_DRIVE="$PWD/hello-rootfs.ext4"

KERNEL="$PWD/hello-vmlinux.bin"
TAP_DEV="fc-${SB_ID}-tap0"

KERNEL_BOOT_ARGS="panic=1 pci=off reboot=k tsc=reliable quiet 8250.nr_uarts=0 ipv6.disable=1"

API_SOCKET="/tmp/firecracker-sb${SB_ID}.sock"
CURL=(curl --silent --show-error --header Content-Type:application/json --unix-socket "${API_SOCKET}" --write-out "HTTP %{http_code}")

curl_put() {
    local URL_PATH="$1"
    local OUTPUT RC
    OUTPUT="$("${CURL[@]}" -X PUT --data @- "http://localhost/${URL_PATH#/}" 2>&1)"
    RC="$?"
    if [ "$RC" -ne 0 ]; then
        echo "Error: curl PUT ${URL_PATH} failed with exit code $RC, output:"
        echo "$OUTPUT"
        return 1
    fi
    # Error if output doesn't end with "HTTP 2xx"
    if [[ "$OUTPUT" != *HTTP\ 2[0-9][0-9] ]]; then
        echo "Error: curl PUT ${URL_PATH} failed with non-2xx HTTP status code, output:"
        echo "$OUTPUT"
        return 1
    fi
}

logfile="$PWD/fc_logs/fc-sb${SB_ID}-log"
metricsfile="/dev/null"

touch $logfile

# Start Firecracker API server
rm -f "$API_SOCKET"

./firecracker --api-sock "$API_SOCKET" --id "${SB_ID}" &>/dev/null &

sleep 0.015s

# Wait for API server to start
while [ ! -e "$API_SOCKET" ]; do
    echo "FC $SB_ID still not ready..."
    sleep 0.01s
done

curl_put '/logger' <<EOF
{
  "log_fifo": "$logfile",
  "metrics_fifo": "$metricsfile",
  "level": "Info",
  "show_level": false,
  "show_log_origin": false
}
EOF

#curl_put '/machine-config' <<EOF
#{
#  "vcpu_count": 1,
#  "mem_size_mib": 128
#}
#EOF

curl_put '/boot-source' <<EOF
{
  "kernel_image_path": "$KERNEL",
  "boot_args": "$KERNEL_BOOT_ARGS"
}
EOF

curl_put '/drives/1' <<EOF
{
  "drive_id": "1",
  "path_on_host": "$RO_DRIVE",
  "is_root_device": true,
  "is_read_only": false
}
EOF

curl_put '/actions' <<EOF
{
  "action_type": "InstanceStart"
}
EOF
