class puppet::client::service {
	service {
		"puppet":
		    require => Class["puppet::client::install"],
	}
}
