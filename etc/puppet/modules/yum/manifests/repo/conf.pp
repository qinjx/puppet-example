define yum::repo::conf {
	if (true == $config::yum::use_local_yum_mirror) {
		$url_prefix = "http://$config::yum::local_yum_mirror_prefix/"
	} else {
		$url_prefix = "http://"
	}

	yumrepo {
		$name:
			descr => $name,
			baseurl => "${url_prefix}${config::yum::urls[$name]}",
			gpgcheck => 1,
			gpgkey => "${url_prefix}${config::yum::keys[$name]}",
	}
}
