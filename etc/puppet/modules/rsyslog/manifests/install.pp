class rsyslog::install {
	package {
		"rsyslog":
	}

	firewall::filter::allow {
		"514":
			proto => "tcp";
		"udp_514":
			port => "514",
			proto => "udp";
	}
}
