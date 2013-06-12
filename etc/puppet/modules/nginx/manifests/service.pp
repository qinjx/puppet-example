class nginx::service {
	service {
		"nginx":
			require => Class["nginx::install"],
	}
}
