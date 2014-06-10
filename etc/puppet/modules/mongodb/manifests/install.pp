class mongodb::install {
	package {
		"mongodb":
      require => Yum::Repo::Conf["epel"],
	}

	firewall::filter::allow {
		"27017":
	}
}