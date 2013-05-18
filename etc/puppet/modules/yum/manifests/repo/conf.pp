define yum::repo::conf {
	yumrepo {
		$name:
		baseurl => $config::yum::urls[$name],
		gpgcheck => 1,
		gpgkey => $config::yum::keys[$name],
	}
}
