node /^sys\d*\.wan\.lb/ inherits default {
	yum::repo::conf {
		"pptp":
	}

	ssh::server::conf {
		"PermitRootLogin":
		    ensure => no,
	}

	package {
		"zsh":
	}

	include role_pptp_server, role_ip_forwarder
}
