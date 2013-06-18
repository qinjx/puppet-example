class php::service {
	service {
		"php-fpm":
			restart => "/sbin/service php-fpm reload",
		    require => Class["php::install"],
	}

	php::conf::fpm {
		"user":
			pool => "www",
			ensure => "php";
		"group":
			pool => "www",
			ensure => "php";
		"listen":
			pool => "www",
			ensure => "0.0.0.0:9000";
	}
}