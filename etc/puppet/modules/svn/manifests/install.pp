class svn::install {
	package {
		"subversion":
	}

	file {
		"/etc/init.d/subversion":
			mode => 755,
			source => "puppet:///modules/svn/init.d/subversion",
			require => Package["subversion"];
		"/etc/subversion/subversion.conf":
			source => "puppet:///modules/svn/subversion.conf",
			require => Package["subversion"];
		"/var/lib/svn":
			ensure => directory;
	}

	firewall::filter::allow {
		"3690":
	}
}