class sphinx::install {
	package {
		["Percona-Server-shared-compat", "postgresql-libs", "sphinx"]:
			ensure => installed,
			require => Yum::Repo::Conf["percona"],
	}

	firewall::filter::allow {
		"9312":
	}

	exec {
		"build_sphinx_index":
			command => "/usr/bin/indexer --rotate --all",
			unless => "/sbin/service searchd status | grep running 2>/dev/null",
			require => File["/etc/sphinx/sphinx.conf"],
	}
}