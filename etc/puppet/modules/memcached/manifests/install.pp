class memcached::install {
	package {
		"memcached":
      require => Yum::Repo::Conf["remi"],
	}

	firewall::filter::allow {
		"11211":
	}
}