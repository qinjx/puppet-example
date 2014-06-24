class svn::install {
	package {
		"subversion":
	}

	file {
		"/etc/sysconfig/svnserve":
			source => "puppet:///modules/svn/subversion.conf",
			require => Package["subversion"];
		"/var/lib/svn":
			ensure => directory;
	}

	firewall::filter::allow {
		"3690":
	}
}
