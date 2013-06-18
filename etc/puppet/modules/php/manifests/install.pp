class php::install {
	package {
		"php-fpm":
			require => Yum::Repo::Conf["remi"],
	}

	firewall::filter::allow {
		"9000":
	}

	user {
		"php":
			ensure => present,
	}
}
