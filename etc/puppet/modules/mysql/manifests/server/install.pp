class mysql::server::install {
	package {
		["mysql-community-server"]:
			require => Yum::Repo::Conf["mysql"],
	}

	firewall::filter::allow {
		"3306":
	}
}
