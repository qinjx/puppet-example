class svn::service {
	service {
		"svnserve":
			require => Class["svn::install"],
	}
}
