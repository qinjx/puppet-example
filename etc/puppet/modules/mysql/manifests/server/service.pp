class mysql::server::service {
	service {
		"mysqld":
			require => Class["mysql::server::install"],
	}
}
