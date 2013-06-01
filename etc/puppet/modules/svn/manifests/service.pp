class svn::service {
	service {
		"subversion":
			enable => true,
			ensure => running,
			require => Class["svn::install"],
	}
}