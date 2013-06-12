class svn::service {
	service {
		"subversion":
			require => Class["svn::install"],
	}
}