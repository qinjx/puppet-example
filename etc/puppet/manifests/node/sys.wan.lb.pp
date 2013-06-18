node /^sys\d*\.wan\.lb/ inherits default {
	yum::repo::conf {
		"pptp":
	}

	ssh::server::conf {
		"PermitRootLogin":
		    ensure => no,
	}

	augeas {
		"sshd_listen_all":
			context => "/files/etc/ssh/sshd_config",
			changes => "rm ListenAddress",
			require => Class["ssh::server::install"],
	}

	package {
		"zsh":
	}

	include role_pptp_server, role_ip_forwarder
}
