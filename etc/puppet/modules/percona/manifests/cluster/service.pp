class percona::cluster::service {
	service {
		"mysql":
		    require => Class["percona::cluster::install"],
	}
}