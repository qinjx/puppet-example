class pptp::server::service {
	service {
		"pptpd":
			ensure => running,
			enable => true,
			require => Class["pptp::server::install"],
	}
}
