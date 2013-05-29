class php::install {
	package {
		"php-fpm":
			ensure => installed,
	}

	firewall::filter::allow {
		"9000":
	}
}
