#!/bin/sh
mkdir -p /tmp/nfs
mount nfs.vip:/opt/nfs/softbin /tmp/nfs

#fastdfs bin
rsync -rp /tmp/nfs/fastdfs/etc/init.d/fdfs_storaged /etc/init.d/
rsync -rp /tmp/nfs/fastdfs/etc/fdfs /etc/
rsync -rp /tmp/nfs/fastdfs/usr/local/bin/* /usr/local/bin/
rsync -rp /tmp/nfs/fastdfs/usr/local/lib/* /usr/lib64/
ln -s /usr/lib64/libfastcommon.so.1 /usr/lib64/libfastcommon.so
ln -s /usr/lib64/libfdfsclient.so.1 /usr/lib64/libfdfsclient.so

#nginx bin
rsync -rp /tmp/nfs/nginx/etc/init.d/nginx /etc/init.d/
rsync -rp /tmp/nfs/nginx/usr/local/nginx /usr/local/
mv /usr/local/nginx/conf/mod_fastdfs.conf /etc/fdfs/

#umount and clean
umount nfs.vip:/opt/nfs/softbin
rm -rf /tmp/nfs

#config storage
mkdir -p /mnt/fastdfs/{storage,client,upload_files}

############## /etc/fdfs/storage.conf ##############
sed -i -e 's/base_path=.*/base_path=\/mnt\/fastdfs\/storage/' /etc/fdfs/storage.conf
sed -i -e 's/store_path0=.*/store_path0=\/mnt\/fastdfs\/upload_files/' /etc/fdfs/storage.conf
sed -i -e '/^tracker_server=/d' /etc/fdfs/storage.conf
echo "tracker_server=tracker1.dfs:22122
tracker_server=tracker2.dfs:22122" >> /etc/fdfs/storage.conf

############## /usr/local/nginx/conf/mod_fastdfs.conf ##############
sed -i -e 's/base_path=.*/base_path=\/mnt\/fastdfs\/storage/' /etc/fdfs/mod_fastdfs.conf
sed -i -e 's/store_path0=.*/store_path0=\/mnt\/fastdfs\/upload_files/' /etc/fdfs/mod_fastdfs.conf
sed -i -e '/^tracker_server=/d' /etc/fdfs/mod_fastdfs.conf
echo "tracker_server=tracker.dfs.vip:22122" >> /etc/fdfs/mod_fastdfs.conf

############## /usr/local/nginx/conf/nginx.conf ##############
sed -i -e 'N;s#location / {\s*root   html;#location /M00 {\n            root   /mnt/fastdfs/storage/upload_files/data;\n            ngx_fastdfs_module;#' /usr/local/nginx/conf/nginx.conf

############## /etc/fdfs/client.conf ##############
sed -i -e 's/base_path=.*/base_path=\/mnt\/fastdfs\/client/' /etc/fdfs/client.conf
sed -i -e '/^tracker_server=/d' /etc/fdfs/client.conf
echo "tracker_server=tracker.dfs.vip:22122" >> /etc/fdfs/client.conf