class puppet::master::install {
	firewall::filter::allow {
		"8140":
			proto => "tcp";
		"udp_8140":
			proto => "udp",
			port => "8140";
	}
}
