define yum::repo::conf {
	if (true == $config::yum::use_local_yum_mirror) {
		$url_prefix = "http://$config::yum::local_yum_mirror_prefix/"
	} else {
		$url_prefix = "http://"
	}

	if ($config::yum::keys[$name] == nil) {
		$gpgcheck = 0
	} else {
		$gpgcheck = 1
	}

	yumrepo {
		$name:
			descr => $name,
			baseurl => "${url_prefix}${config::yum::urls[$name]}",
			gpgcheck => $gpgcheck,
			gpgkey => "${url_prefix}${config::yum::keys[$name]}",
	}
}
