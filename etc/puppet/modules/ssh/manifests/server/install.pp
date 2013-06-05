class ssh::server::install {
	package {
		"openssh-server":
	}

	firewall::filter::allow {
		"22":
	}

	ssh::server::conf {
		"ListenAddress":
			ensure => $ipaddress,
	}
}
