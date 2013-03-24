class role_internet_enduser
{
	augeas
	{
		"set_gateway":
			context => "/files/etc/sysconfig/network",
			changes => [
				"set GATEWAY $ip_prefix.254"
			],
	}

	augeas
	{
		"set_dns":
			context => "/files/etc/resolv.conf",
			changes => [
				"set nameserver[. = '8.8.8.8'] 8.8.8.8",
				"set nameserver[. = '8.8.4.4'] 8.8.4.4",
			],
	}
}
