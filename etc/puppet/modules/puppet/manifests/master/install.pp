class puppet::master::install {
	package {
		["puppet-server", "augeas"]:
			require => Yum::Repo::Conf["epel"],
	}

	firewall::filter::allow {
		"8140":
			proto => "tcp";
		"udp_8140":
			proto => "udp",
			port => "8140";
	}
}
