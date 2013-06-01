class pptp::server::install {
	package {
		["ppp", "pptpd"]:
			ensure => present,
			require => Yum::Repo::Conf["pptp"],
	}

	exec {
		"enable_ip_forward_now":
			command => "/bin/echo 1 > /proc/sys/net/ipv4/ip_forward",
	}

	augeas {
		"enable_ip_forward_forever":
			context => "/files/etc/sysctl.conf",
			changes => "set net.ipv4.ip_forward 1",
	}

	iptables {
		"nat_rule_for_vpn_server":
			table       => nat,
			outiface    => eth0,
			chain		=> POSTROUTING,
			jump        => MASQUERADE,
			proto       => all,
			source      => "192.168.1.0/24",
	}

	firewall::filter::allow {
		"1723"
	}
}