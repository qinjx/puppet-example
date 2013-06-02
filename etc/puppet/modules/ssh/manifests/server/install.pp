class ssh::server::install {
	firewall::filter::allow {
		"22":
	}

	augeas {
		"listen_local_ip":
			context => "/files/etc/ssh/sshd_config",
			changes => "set ListenAddress $ipaddress",
	}
}
