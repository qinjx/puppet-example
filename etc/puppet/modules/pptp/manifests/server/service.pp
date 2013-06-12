class pptp::server::service {
	service {
		"pptpd":
			require => Class["pptp::server::install"],
	}
}
