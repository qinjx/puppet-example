class hhvm::install {
	package {
		"hiphop-php":
			require => Yum::Repo::Conf["hop5"],
	}

	file {
		"/etc/init.d/hhvm":
			mode => 755,
			source => "puppet:///modules/hhvm/init.d/hhvm",
			require => Package["hiphop-php"];
		"/etc/hhvm/hhvm.hdf":
			source => "puppet:///modules/hhvm/hhvm/hhvm.hdf",
			require => Package["hiphop-php"];
		"/var/lib/hhvm":
			ensure => directory;
	}

	firewall::filter::allow {
		"80":
	}
}