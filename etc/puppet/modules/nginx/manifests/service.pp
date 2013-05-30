class nginx::service {
	service {
		"nginx":
			ensure => running,
			enable => true,
			require => Class["nginx::install"],
	}
}
