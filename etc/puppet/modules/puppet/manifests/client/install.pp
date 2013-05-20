class puppet::client::install {
	package {
		"puppet":
			ensure => installed,
	}
}