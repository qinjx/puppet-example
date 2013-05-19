define php::ext {
	package {
		$name:
		    ensure => installed,
		    require => Yum::Repo::Conf["remi"],
	}
}