class sphinx::service {
	service {
		"searchd":
		ensure => running,
		enable => true,
		require => Class["sphinx::install"],
	}
}