#!/bin/sh
dev=$1
mnt=$2
#echo -e "o\nn\np\n1\n\n\nw" | fdisk $dev
mkfs -t ext4 $dev
echo "$dev	$mnt	ext4	defaults	1	1" >> /etc/fstab
mount -a
