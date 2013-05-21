define php::ext {
	package {
		"php-${name}":
		    ensure => installed,
		    require => Yum::Repo::Conf["remi"],
	}
}