class sphinx::service {
	service {
		"searchd":
		ensure => running,
		enable => true,
	}
}