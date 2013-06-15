#!/bin/sh
#fastdfs client bin
mkdir /etc/fdfs
rm /tmp/fastdfs/usr/local/bin/{fdfs_storaged, fdfs_trackerd}

rsync -rp /tmp/fastdfs/etc/fdfs/client.conf /etc/fdfs/
rsync -rp /tmp/fastdfs/usr/local/bin/* /usr/local/bin/
rsync -rp /tmp/fastdfs/usr/local/lib/* /usr/lib64/
ln -s /usr/lib64/libfastcommon.so.1 /usr/lib64/libfastcommon.so
ln -s /usr/lib64/libfdfsclient.so.1 /usr/lib64/libfdfsclient.so

mkdir -p /var/fastdfs/client

############## /etc/fdfs/client.conf ##############
sed -i -e 's/base_path=.*/base_path=\/var\/fastdfs\/client/' /etc/fdfs/client.conf
sed -i -e '/^tracker_server=/d' /etc/fdfs/client.conf
echo "tracker_server=tracker.dfs.vip:22122" >> /etc/fdfs/client.conf
