#!/bin/sh
#仅适用于3.2.14版本
ver="3.2.14"
coreseek_src_dir="coreseek-${ver}"
if [ ! -d $coreseek_src_dir ]; then
	tar zxf coreseek*.tar.gz
fi
cd $coreseek_src_dir

cd mmseg-${ver}
./bootstrap
./configure --prefix=/usr
make && make install

cd ../
cd csft-${ver}
sh buildconf.sh
./configure --prefix=/usr --without-unixodbc --with-mmseg --with-mysql
make && make install

cd ../
mkdir dist
cd dist

#mmseg
mkdir lib bin etc
cp /usr/lib/libmmseg.a		lib/
cp /usr/lib/libmmseg.la		lib/
cp /usr/bin/mmseg		bin/
cp /usr/etc/uni.lib		etc/
cp /usr/etc/unigram.txt		etc/
cp /usr/etc/mmseg.ini		etc/

#coreseek
mkdir var var/log var/data
cp /usr/bin/indexer		bin/
cp /usr/bin/indextool		bin/
cp /usr/bin/search		bin/
cp /usr/bin/searchd		bin/
cp /usr/bin/spelldump		bin/


