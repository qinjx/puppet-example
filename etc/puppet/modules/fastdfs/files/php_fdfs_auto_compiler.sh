#!/bin/sh
if [ ! -d FastDFS ]; then
	tar zxf FastDFS*.tar.gz
fi

cd FastDFS/php_client
phpize
./configure
make
make install

rm -rf dist
cp -r ../dist ./
mkdir -p dist/usr/lib64/php/modules
mkdir -p dist/etc/php.d

cp /usr/lib64/php/modules/fastdfs_client.so dist/usr/lib64/php/modules/
cp fastdfs_client.ini dist/etc/php.d/fastdfs_client.ini
