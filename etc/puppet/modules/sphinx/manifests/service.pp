class sphinx::service {
	service {
		"searchd":
		require => Class["sphinx::install"],
	}
}