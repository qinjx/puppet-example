class hhvm::service {
	service {
		"hhvm":
		require => Class["hhvm::install"],
	}
}
