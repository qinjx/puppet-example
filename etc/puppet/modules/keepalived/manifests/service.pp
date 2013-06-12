class keepalived::service {
	service {
		"keepalived":
			require    => Class["keepalived::install"],
	}
}
