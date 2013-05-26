class php::install {
	package {
		"php-fpm":
			ensure => present,
	}

	firewall::filter::allow {
		"9000":
	}

	user {
		"apache":
			ensure => present,
	}
}
