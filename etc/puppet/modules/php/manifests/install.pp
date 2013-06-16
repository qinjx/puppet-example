class php::install {
	package {
		"php-fpm":
			require => Yum::Repo::Conf["remi"],
	}

	firewall::filter::allow {
		"9000":
	}

	php::conf::fpm {
		"user":
			pool => "www",
			section => "www",
			ensure => "php";
		"group":
			pool => "www",
			section => "www",
			ensure => "php";
		"listen":
			pool => "www",
			section => "www",
			ensure => "0.0.0.0:9000";
	}

	user {
		"php":
			ensure => present,
	}
}
