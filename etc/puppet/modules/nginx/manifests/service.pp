class nginx::service {
	service {
		"nginx":
			restart => "/sbin/service nginx reload",
			require => Class["nginx::install"],
	}
}
