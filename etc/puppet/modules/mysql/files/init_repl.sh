#!/bin/bash

#default config
master_root_pass=""
master_port="3306"
local_root_pass=""
local_port="3306"
repl_user="repl"
repl_pass=""
this_host=`hostname`
my_cnf_file="/etc/my.cnf"

#read the user config, overwrite the default
if [ -z $1 ]; then
	echo "Usage: $0 repl_sample.ini"
else
	source ./$1
fi

if [ "$master_root_pass" == "" ]; then
	master_pass_string=""
else
	master_pass_string=" --password=$master_root_pass "
fi

if [ "$local_root_pass" == "" ]; then
	local_pass_string=""
else
	local_pass_string=" --password=$local_root_pass "
fi


if [ "$repl_pass" == "" ]; then
	repl_pass_grant=""
	repl_pass_change_master=""
else
	repl_pass_grant=" IDENTIFIED BY '$repl_pass' "
	repl_pass_change_master=", MASTER_PASSWORD='$repl_pass' "
fi

# create repl user
mysql -h $master_host -uroot -P $master_port $master_pass_string -e "
GRANT REPLICATION SLAVE ON *.* TO '$repl_user'@'$this_host' $repl_pass_grant;
FLUSH PRIVILEGES;
FLUSH TABLES WITH READ LOCK;
"

#dump sql
mysqldump --databases $repl_db_list -h $master_host -uroot -P $master_port $master_pass_string --master-data > $dump_out_sql

#realse read lock
mysql -h $master_host -uroot -P $master_port $master_pass_string -e "
UNLOCK TABLES;
"

#import sql from master

mysql -P $local_port -uroot $local_pass_string -e "STOP SLAVE;"
mysql -P $local_port -uroot $local_pass_string < $dump_out_sql
mysql -P $local_port -uroot $local_pass_string -e "
CHANGE MASTER TO
MASTER_USER='$repl_user' $repl_pass_change_master;
"

#config replicate-do-db
for db in $repl_db_list; do
	grep "replicate-do-db=$db *\$" $my_cnf_file
	if [ $? -gt 0 ]; then
		sed -i "/\[mysqld\]/ a\
replicate-do-db=$db" $my_cnf_file
	fi
	
done

#restart
service mysqld restart
