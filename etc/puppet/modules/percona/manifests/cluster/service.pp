class percona::cluster::service {
	service {
		"mysql":
			restart => "/sbin/service mysql reload",
			require => Class["percona::cluster::install"];
		"xinetd":
			require => Class["percona::cluster::install"];
	}

	 percona::cluster::conf {
    "user":
      ensure => "mysql";
		"binlog_format":
			ensure => "row";
		"wsrep_provider":
			ensure => "/usr/lib64/libgalera_smm.so";
		"wsrep_salve)threads":
			ensure => 2;
		"wsrep_cluster_name":
			ensure => "the_percona_galera_db_cluster";
		"wsrep_sst_method":
			ensure => "rsync";
		"wsrep_node_name":
			ensure => $hostname;
		"innodb_locks_unsafe_for_binlog":
			ensure => 1;
		"innodb_autoinc_lock_mode":
			ensure => 2;
  }
}
