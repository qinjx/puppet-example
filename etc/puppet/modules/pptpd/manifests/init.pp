class pptpd
{
	package
	{
		["ppp", "pptpd"]:
			ensure => present,
			require => Yumrepo["pptp"],
	}

	augeas
	{
		"enable_ip_forward_for_vpn_server":
			context => "/files/etc/sysctl.conf",
			changes => [
				"set net.ipv4.ip_forward 1",
			],
	}

	service
	{
		"pptpd":
			ensure => running,
			enable => true,
			require => Package["pptpd"],
	}

	iptables
	{
		"nat_rule_for_vpn_server":
			table       => nat,
			outiface    => eth0,
			chain		=> POSTROUTING,
			jump        => MASQUERADE,
			proto       => all,
			source      => "192.168.1.0/24",
	}
	
	iptables
	{
		"vpn_pptp_1723":
			proto       => "tcp",
			dport       => "1723",
			jump        => "ACCEPT",
	}
}