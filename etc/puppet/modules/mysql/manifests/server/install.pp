class mysql::server::install {
	package {
		["mysql-community-server"]:
			require => Yum::Repo::Conf["mysql"],
	}

  file {
    "/opt/data/mysql":
      ensure => directory,
      require => Package["mysql-community-server"],
  }

  mysql::server::conf {
    "datadir":
      ensure => "/opt/data/mysql",
      require => File["/opt/data/mysql"],
  }

	firewall::filter::allow {
		"3306":
	}
}
