#!/bin/sh
for db in shop;
do
        time=`date "+%Y-%m-%d_%H-%M"`
        mysqldump $db > "${db}_$time.sql"
done