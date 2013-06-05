class php::install {
	package {
		"php-fpm":
			ensure => installed,
			require => Yum::Repo::Conf["remi"],
	}

	firewall::filter::allow {
		"9000":
	}

	php::conf::fpm {
		"user":
			pool => "www",
			section => "www",
			ensure => "php",
			require => Package["php-fpm"];
		"group":
			pool => "www",
			section => "www",
			ensure => "php",
      require => Package["php-fpm"];
		"listen":
			pool => "www",
			section => "www",
			ensure => "0.0.0.0:9000",
      require => Package["php-fpm"];
		"listen.allowed_clients":
			pool => "www",
			section => "www",
			ensure => "$ipaddress/24",
      require => Package["php-fpm"];
	}

	user {
		"php":
			ensure => present,
	}
}
