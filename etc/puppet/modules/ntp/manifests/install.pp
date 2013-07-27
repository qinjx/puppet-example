class ntp::install {
	package {
		["ntp", "rdate"]:
	}

	firewall::filter::allow {
		"123":
			proto => "udp",
	}
}
