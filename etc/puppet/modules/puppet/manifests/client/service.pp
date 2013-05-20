class puppet::client::service {
	service {
		"puppet":
			enable => true,
			ensure => running,
		    require => Class["puppet::client::install"],
	}
}
