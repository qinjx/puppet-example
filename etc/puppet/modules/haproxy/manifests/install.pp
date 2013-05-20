class haproxy::install {
	package {
		"haproxy":
			ensure => installed,
		    require => Yum::Repo::Conf["epel"],
	}
}