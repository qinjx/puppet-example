#!/bin/sh

rsync -rp /tmp/fastdfs/etc/init.d/fdfs_trackerd /etc/init.d/fdfs_trackerd
rsync -rp /tmp/fastdfs/etc/fdfs /etc/
rsync -rp /tmp/fastdfs/usr/local/bin/* /usr/local/bin/

mkdir -p /var/fastdfs/tracker

sed -i -e 's/base_path=.*/base_path=\/var\/fastdfs\/tracker/' /etc/fdfs/tracker.conf
sed -i -e 's/reserved_storage_space *=.*/reserved_storage_space=2GB/' /etc/fdfs/tracker.conf
#the end