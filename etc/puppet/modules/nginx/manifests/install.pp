class nginx::install {
	package {
		"nginx":
		    ensure => installed,
	}

	firewall::filter::allow {
		"80":
	}
}