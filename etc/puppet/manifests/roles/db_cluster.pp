class role_db_cluster
{
	include percona_cluster

	file
	{
		"/root/dump_db.sh":
			mode => 755,
			source => "puppet:///node_files/shop.db/dump_db.sh",
	}

	if ($domain =~ /raw/)
	{
		exec
		{
			"disable_selinux_now":
				command => "/usr/sbin/setenforce 0",
		}

		file
		{
			"/etc/my.cnf":
				content => "[mysqld]
user=mysql
binlog_format=row
wsrep_provider=/usr/lib64/libgalera_smm.so
wsrep_cluster_address=gcomm://
wsrep_slave_threads=2
wsrep_cluster_name=trimethylxanthine
wsrep_sst_method=rsync
wsrep_node_name=$fqdn
innodb_locks_unsafe_for_binlog=1
innodb_autoinc_lock_mode=2",
		}
	}
	else
	{
		augeas
		{
			"change_my_cnf_setting":
				changes => [
					"set /files/etc/my.cnf/target[. = 'mysqld']/user mysql",
					"set /files/etc/my.cnf/target[. = 'mysqld']/binlog_format row",
					"set /files/etc/my.cnf/target[. = 'mysqld']/wsrep_provider /usr/lib64/libgalera_smm.so",
					"set /files/etc/my.cnf/target[. = 'mysqld']/wsrep_slave_threads 2",
					"set /files/etc/my.cnf/target[. = 'mysqld']/wsrep_cluster_name trimethylxanthine",
					"set /files/etc/my.cnf/target[. = 'mysqld']/wsrep_sst_method rsync",
					"set /files/etc/my.cnf/target[. = 'mysqld']/wsrep_node_name $hostname",
					"set /files/etc/my.cnf/target[. = 'mysqld']/innodb_locks_unsafe_for_binlog 1",
					"set /files/etc/my.cnf/target[. = 'mysqld']/innodb_autoinc_lock_mode 2",
				],
		}
		
		# the first node has an empty "wsrep_cluster_address", because there is no other running node
		# after your whole cluster running successfully, change this "wsrep_cluster_address" setting to any running node, then restart mysql manually
		if ($fqdn == "$first_node.$root_domain_name") {
			augeas
			{
				"my_cnf_wsrep_cluster_address" :
					changes => [
						"set /files/etc/my.cnf/target[. = 'mysqld']/wsrep_node_name $hostname",
					],
			}

			cron
			{
				"dump_db":
					command => "/bin/sh /root/dump_db.sh",
					minute => "*/30",
					require => File["/root/dump_db.sh"],
			}
		} else {
			augeas
			{
				"my_cnf_wsrep_cluster_address" :
					changes => [
						"set /files/etc/my.cnf/target[. = 'mysqld']/wsrep_cluster_address gcomm://$first_node"
					],
			}
			
			service
			{
				"mysql":
					ensure => running,
					enable => true,
					require => Package["Percona-XtraDB-Cluster-server"],
					subscribe => Augeas["change_my_cnf_setting","my_cnf_wsrep_cluster_address"],
			}
		}		
	}
}

