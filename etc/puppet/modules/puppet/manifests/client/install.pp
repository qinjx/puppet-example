class puppet::client::install {
	package {
		"puppet":
			ensure => installed,
	}

	puppet::client::conf {
		"agent/runinterval":
			ensure => 1500;
		"agent/show_diff":
			ensure => "true";
		"agent/pluginsync":
			ensure => "true";
	}
}