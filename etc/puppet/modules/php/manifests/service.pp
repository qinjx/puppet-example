class php::service {
	service {
		"php-fpm":
			enable => true,
			ensure => running,
		    require => Class["php::install"],
	}
}