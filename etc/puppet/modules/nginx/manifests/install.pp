class nginx::install {
	package {
		"nginx":
		    ensure => installed,
	}

	iptables {
		"tcp_80_for_nginx":
			proto       => "tcp",
			dport       => "80",
			jump        => "ACCEPT",
	}
}