class nfs::service {
	service {
		"nfs":
			require => Class["nfs::install"],
	}
}