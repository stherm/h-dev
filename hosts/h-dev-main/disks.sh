#!/usr/bin/env bash
set -e
SSD='/dev/sda'
MNT='/mnt'
SWAP_GB=4

wait_for_device() {
  while [[ ! -e $1 ]]; do sleep 0.1; done
}

swapoff --all || true
udevadm settle
wait_for_device $SSD

wipefs -a $SSD

fdisk $SSD << EOF
g
n
1

+512M
t
1
n
2

+${SWAP_GB}G
t
2
19
n
3


w
EOF

partprobe -s $SSD
udevadm settle
wait_for_device "${SSD}1"
wait_for_device "${SSD}2"
wait_for_device "${SSD}3"

mkfs.vfat -F 32 -n BOOT "${SSD}1"
mkswap -L SWAP "${SSD}2"
mkfs.ext4 -L ROOT "${SSD}3"

mount -o X-mount.mkdir "${SSD}3" "$MNT"
mkdir -p "$MNT/boot"
mount "${SSD}1" "$MNT/boot"
swapon "${SSD}2"

lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL
