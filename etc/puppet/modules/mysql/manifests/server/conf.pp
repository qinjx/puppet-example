define mysql::server::conf($ensure) {
	augeas {
		"change_mysqld_setting_${name}":
			context => "/files/etc/my.cnf/target[ . = 'mysqld' ]",
			changes => "set ${name} ${ensure}",
			require => Package["mysql-community-server"],
			notify => Service["mysqld"],
	}
}

