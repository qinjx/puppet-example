class php::install {
	package {
		"php-fpm":
			ensure => present,
	}

	firewall::filter::allow {
		"9000":
	}
}
