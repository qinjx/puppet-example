class role_vpn_enduser
{
	augeas
	{
		"set_vpn_gateway":
			context => "/files/etc/sysconfig/network",
			changes => [
				"set GATEWAY $ip_prefix.253"
			],
	}
}
