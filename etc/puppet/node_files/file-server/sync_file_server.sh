#!/bin/sh
. ./sync_file_server.ini

mkdir -p /mnt/file-server/{nfs,yum_mirror}
mount $source_host:/opt/nfs /mnt/file-server/nfs
mount $source_host:/opt/yum_mirror /mnt/file-server/yum_mirror

rsync -arp /mnt/file-server/nfs/* /opt/nfs/
rsync -arp /mnt/file-server/yum_mirror/* /opt/yum_mirror/

umount $source_host:/opt/nfs
umount $source_host:/opt/yum_mirror
rm /mnt/file-server/{nfs,yum_mirror} -rf
