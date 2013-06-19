class role_pptp_server {
	yum::repo::conf {
		"pptp":
	}

	include pptp::server::install, pptp::server::service
}
