class coreseek::service {
	service {
		"searchd":
			require => Class["coreseek::install"],
	}
}
