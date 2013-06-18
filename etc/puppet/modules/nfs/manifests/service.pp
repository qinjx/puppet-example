class nfs::service {
	service {
		"rpcbind":
			restart => "/sbin/service rpcbind reload",
			notify => Service["nfs"],
			require => Class["nfs::install"];
		"nfs":
			restart => "/sbin/service nfs reload";
	}

	firewall::filter::allow {
		"2049":
	}
}