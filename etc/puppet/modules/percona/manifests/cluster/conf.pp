define percona::cluster::conf($ensure) {
	augeas {
		"change_mysqld_setting_${name}":
			changes => "set /files/etc/my.cnf/target[. = 'mysqld']/${name} ${ensure}",
			notify => Service["mysql"],
	}
}