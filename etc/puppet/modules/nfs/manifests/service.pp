class nfs::service {
	service {
		"rpcbind":
			require => Class["nfs::install"];
		"nfs":
			require => Service["rpcbind"];
	}
}