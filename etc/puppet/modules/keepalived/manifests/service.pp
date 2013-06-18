class keepalived::service {
	service {
		"keepalived":
			restart => "/sbin/service keepalived reload",
			require => Class["keepalived::install"],
	}
}
