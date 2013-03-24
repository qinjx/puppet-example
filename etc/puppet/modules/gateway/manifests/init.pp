class gateway
{
	augeas
	{
		"enable_ip_forward_for_gateway":
			context => "/files/etc/sysctl.conf",
			changes => [
				"set net.ipv4.ip_forward 1",
			],
	}

	define gateway::conf($lan_interface, $wan_interface)
	{
		iptables
		{
			"gateway_lan_forward-$name":
				iniface     => $lan_interface,
				chain		=> "FORWARD",
				jump        => "ACCEPT",
				proto       => "all",
		}

		iptables
		{
			"gateway_wan_nat-$name":
				table       => "nat",
				outiface    => $wan_interface,
				chain		=> "POSTROUTING",
				jump        => "MASQUERADE",
				proto       => "all",
		}
	}
}