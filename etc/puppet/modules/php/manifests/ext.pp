define php::ext {
	package {
		"php-${name}":
		    require => Yum::Repo::Conf["remi"],
	}
}