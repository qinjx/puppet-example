class nfs::install {
	package {
		"nfs-utils":
			ensure => installed,
	}

	firewall::filter::allow {
		"2049":
	}
}