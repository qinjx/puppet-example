class role_load_balancer {
	include haproxy::install, haproxy::service

	yum::repo::conf {
		"epel":
	}
}
