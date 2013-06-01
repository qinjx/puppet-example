class svn::install {
	package {
		"subversion":
			ensure => installed,
	}

	file {
		"/etc/init.d/subversion":
			mode => 755,
			source => "puppet:///modules/svn/init.d/subversion";
		"/etc/subversion/subversion.conf":
			source => "puppet:///modules/svn/subversion.conf";
		"/var/lib/svn":
			ensure => directory;
	}

	firewall::filter::allow {
		"3690":
	}
}