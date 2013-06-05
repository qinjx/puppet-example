class ssh::server::install {
	package {
		"openssh-server":
		    ensure => installed,
	}

	firewall::filter::allow {
		"22":
	}

	ssh::server::conf {
		"ListenAddress":
			ensure => $ipaddress,
	}
}
