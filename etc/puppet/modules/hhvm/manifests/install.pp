class hhvm::install {
	package {
		"hiphop-php":
			require => Yum::Repo::Conf["hop5"],
	}

	file {
		"/etc/init.d/hhvm":
			mode => 755,
			source => "puppet:///modules/hhvm/init.d/hhvm";
		"/etc/hhvm/hhvm.hdf":
			source => "puppet:///modules/hhvm/hhvm/hhvm.hdf";
		"/var/lib/hhvm":
			ensure => directory;
		"/var/log/hhvm":
			ensure => directory;
		"/etc/hhvm":
			ensure => directory;
	}

	firewall::filter::allow {
		"80":
	}
}
