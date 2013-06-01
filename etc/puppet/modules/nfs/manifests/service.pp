class nfs::service {
	service {
		"nfs":
			ensure => running,
			enable => true,
			require => Class["nfs::install"],
	}
}