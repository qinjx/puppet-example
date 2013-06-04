class puppet::master::service {
	service {
		"puppetmaster":
			ensure     => running,
			enable     => true,
			require    => Class["puppet::server::install"],
	}
}