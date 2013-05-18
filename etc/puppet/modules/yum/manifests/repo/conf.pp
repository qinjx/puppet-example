define yum::repo::conf {
	if ($config::yum::use_local_yum_mirror) {
		$url_prefix = "http://$config::yum::local_yum_mirror_prefix/"
	} else {
		$url_prefix = "http://"
	}

	yumrepo {
		$name:
		baseurl => $config::yum::urls[$name],
		gpgcheck => 1,
		gpgkey => $config::yum::keys[$name],
	}
}
