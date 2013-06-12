class haproxy::service {
	service {
		"haproxy":
			require => Class["haproxy::install"],
	}
}