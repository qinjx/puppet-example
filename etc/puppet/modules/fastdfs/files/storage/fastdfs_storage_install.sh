#!/bin/sh
#fastdfs bin
rsync -rp /tmp/fastdfs/etc/init.d/fdfs_storaged /etc/init.d/
rsync -rp /tmp/fastdfs/etc/fdfs /etc/
rsync -rp /tmp/fastdfs/usr/local/bin/* /usr/local/bin/
rsync -rp /tmp/fastdfs/usr/local/lib/* /usr/lib64/
ln -s /usr/lib64/libfastcommon.so.1 /usr/lib64/libfastcommon.so
ln -s /usr/lib64/libfdfsclient.so.1 /usr/lib64/libfdfsclient.so

#config storage
mkdir -p /mnt/fastdfs/{storage,client,upload_files}

############## /etc/fdfs/storage.conf ##############
sed -i -e 's/base_path=.*/base_path=\/mnt\/fastdfs\/storage/' /etc/fdfs/storage.conf
sed -i -e 's/store_path0=.*/store_path0=\/mnt\/fastdfs\/upload_files/' /etc/fdfs/storage.conf
sed -i -e '/^tracker_server=/d' /etc/fdfs/storage.conf

############## please make sure ALL tracker server are online ##############
echo "tracker_server=tracker1.dfs:22122
tracker_server=tracker2.dfs:22122" >> /etc/fdfs/storage.conf

############## /etc/fdfs/client.conf ##############
sed -i -e 's/base_path=.*/base_path=\/mnt\/fastdfs\/client/' /etc/fdfs/client.conf
sed -i -e '/^tracker_server=/d' /etc/fdfs/client.conf
echo "tracker_server=tracker.dfs.vip:22122" >> /etc/fdfs/client.conf
