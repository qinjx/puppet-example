define gateway::conf($lan_interface, $wan_interface)
{
	iptables
	{
		"gateway_lan_forward-$name":
			iniface     => $lan_interface,
			chain		=> "FORWARD",
			jump        => "ACCEPT",
			proto       => "all";
		"gateway_wan_nat-$name":
			table       => "nat",
			outiface    => $wan_interface,
			chain		=> "POSTROUTING",
			jump        => "MASQUERADE",
			proto       => "all";
	}
}