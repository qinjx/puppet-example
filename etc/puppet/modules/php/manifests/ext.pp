define php::ext {
	package {
		"php-${name}":
			require => Yum::Repo::Conf["remi"],
			notify => Service["php-fpm"]
	}
}
