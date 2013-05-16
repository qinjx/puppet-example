define yum::repo::conf {
	yumrepo {
		$name:
		baseurl => $config::repo::urls[$name],
		gpgcheck => 1,
		gpgkey => $config::repo::keys[$name];
	}
}