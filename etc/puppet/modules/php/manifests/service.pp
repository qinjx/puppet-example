class php::service {
	service {
		"php-fpm":
		    require => Class["php::install"],
	}
}