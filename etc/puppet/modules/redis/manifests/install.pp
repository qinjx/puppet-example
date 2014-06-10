class redis::install {
	package {
		"redis":
      require => Yum::Repo::Conf["remi"],
	}

	firewall::filter::allow {
		"6379":
	}
}