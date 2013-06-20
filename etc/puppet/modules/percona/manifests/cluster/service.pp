class percona::cluster::service {
	service {
		"mysql":
			restart => "/sbin/service mysql reload",
		    require => Class["percona::cluster::install"];
		"xinetd":
			require => Class["percona::cluster::install"];
	}
}