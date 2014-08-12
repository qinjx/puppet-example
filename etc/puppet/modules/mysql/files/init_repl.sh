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
skip_dump=0

#read the user config, overwrite the default
if [ -z $1 ]; then
	echo "Usage: init_repl.sh repl_sample.ini"
else
	ini_real_path=`readlink -f $1`
	source $ini_real_path
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
"

#dump sql
if [ $skip_dump -eq 0 ]; then
	mysql -h $master_host -uroot -P $master_port $master_pass_string -e "FLUSH TABLES WITH READ LOCK;"
	mysqldump --databases $repl_db_list -h $master_host -uroot -P $master_port $master_pass_string --master-data > $dump_out_sql
	mysql -h $master_host -uroot -P $master_port $master_pass_string -e "UNLOCK TABLES;"
fi

#import sql from master
mysql -P $local_port -uroot $local_pass_string -e "
STOP SLAVE;
CHANGE MASTER TO MASTER_HOST='$master_host', MASTER_PORT=$master_port, MASTER_USER='$repl_user' $repl_pass_change_master;
"
mysql -P $local_port -uroot $local_pass_string < $dump_out_sql

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
