class percona::cluster::service {
	service {
		"mysql":
			enable => true,
			ensure => running,
		    require => Class["percona::cluster::install"],
	}
}