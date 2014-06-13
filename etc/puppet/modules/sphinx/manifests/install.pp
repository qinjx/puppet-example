class sphinx::install {
	package {
		["mysql-community-libs", "postgresql-libs", "sphinx"]:
			require => Yum::Repo::Conf["mysql"],
	}

	firewall::filter::allow {
		"9312":
	}

	exec {
		"build_sphinx_index":
			command => "/usr/bin/indexer --rotate --all",
			unless => "/sbin/service searchd status | grep running 2>/dev/null",
			require => [File["/etc/sphinx/sphinx.conf"], Package["sphinx"]]
	}
}
