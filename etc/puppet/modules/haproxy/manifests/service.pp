class haproxy::service {
	service {
		"haproxy":
			enable => true,
			ensure => running,
			require => Class["haproxy::install"],
	}
}