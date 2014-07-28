class nginx::install {
	package {
		"nginx":
	}

	firewall::filter::allow {
		"80":
	}
}
