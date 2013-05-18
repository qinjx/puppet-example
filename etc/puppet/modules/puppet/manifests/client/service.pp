class puppet::client::service {
	package {
		"puppet":
			ensure => installed,
	}

	service {
		"puppet":
			enable => true,
			ensure => running,
	}
}
