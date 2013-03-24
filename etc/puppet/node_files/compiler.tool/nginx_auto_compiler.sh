#!/bin/sh
src_root="/root/src/nginx"
mkdir -p $src_root
cd $src_root
rm -rf nginx*.tar.gz

#download nginx source from nfs
mkdir -p /tmp/nfs
mount nfs.vip:/opt/nfs/ /tmp/nfs
rsync -rp /tmp/nfs/downloads/{nginx*.tar.gz,fastdfs-nginx-module*.tar.gz} .
umount nfs.vip:/opt/nfs/
rm -rf /tmp/nfs

tar zxf nginx*.tar.gz
tar zxf fastdfs-nginx-module*.tar.gz
cd nginx-1.2.1

./configure --add-module="$src_root/fastdfs-nginx-module/src"
make
make install

rm dist/ -rf
mkdir -p dist/usr/local
mkdir -p dist/etc/init.d

rsync -rp /etc/init.d/nginx dist/etc/init.d/
rsync -rp /usr/local/nginx dist/usr/local/
rsync -rp "$src_root/fastdfs-nginx-module/src/mod_fastdfs.conf" dist/usr/local/nginx/conf/

rsync -rp --delete dist/{etc,usr} nfs.vip:/opt/nfs/softbin/nginx/