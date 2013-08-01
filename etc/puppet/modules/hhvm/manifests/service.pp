class svn::service {
	service {
		"hhvm":
		require => Class["hhvm::install"],
	}
}