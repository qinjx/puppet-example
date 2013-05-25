class php::install {
	package {
		"php-fpm":
			ensure => present,
	}

	iptables {
		"tcp_9000_for_phpfcgi":
			proto       => "tcp",
			dport       => "9000",
			jump        => "ACCEPT",
	}

	user {
		"apache":
			ensure => present,
	}
}
