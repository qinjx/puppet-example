class nfs::install {
	package {
		"nfs-utils":
	}

	firewall::filter::allow {
		"2049":
	}
}