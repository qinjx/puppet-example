class role_ntp_server {
	firewall::filter::allow {
		"123":
		proto => "udp",
	}

	include ntp::service, ntp::install
}
