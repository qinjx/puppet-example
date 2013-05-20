class role_load_balancer
{
	include haproxy

	iptables
	{
		"haproxy_stats_1936":
			proto       => "tcp",
			dport       => "1936",
			jump        => "ACCEPT",
	}
}
