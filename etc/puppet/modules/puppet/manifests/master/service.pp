class puppet::master::service {
	service {
		"puppetmaster":
			require => Class["puppet::master::install"],
	}
}
