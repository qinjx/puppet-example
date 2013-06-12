#!/bin/sh
tar zxf FastDFS*.tar.gz
cd FastDFS

./make.sh
./make.sh install

rm dist/ -rf
mkdir -p dist/usr/local/{bin,include,lib}
mkdir -p dist/etc/{init.d,fdfs}
rsync -rp init.d/* dist/etc/init.d/
rsync -rp /etc/fdfs/*.conf dist/etc/fdfs/
rsync -rp /usr/local/bin/fdfs_* dist/usr/local/bin/
rsync -rp /usr/local/bin/{restart.sh,stop.sh} dist/usr/local/bin/
rsync -rp /usr/local/include/{fastcommon,fastdfs} dist/usr/local/include/
rsync -rp /usr/local/lib/libf* dist/usr/local/lib/
