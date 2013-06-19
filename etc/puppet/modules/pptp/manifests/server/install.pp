class pptp::server::install {
	package {
		["ppp", "pptpd"]:
			require => Yum::Repo::Conf["pptp"],
	}

	iptables {
		"nat_rule_for_vpn_server":
			table       => nat,
			outiface    => eth0,
			chain		=> POSTROUTING,
			jump        => MASQUERADE,
			proto       => all,
			source      => "192.168.1.0/24";
		"gre_for_vpn_server":
			proto => "gre";
	}

	firewall::filter::allow {
		"1723":
	}
}
