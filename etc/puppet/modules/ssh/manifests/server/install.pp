class ssh::server::install {
	firewall::filter::allow {
		"22":
	}

	ssh::server::conf {
		"ListenAddress":
			ensure => $ipaddress,
	}
}
