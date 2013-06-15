#!/bin/sh
if [ ! -d FastDFS ]; then
	tar zxf FastDFS*.tar.gz
fi

cd FastDFS/php_client
phpize
./configure
make
make install