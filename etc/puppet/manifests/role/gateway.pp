class role_gateway
{
	include gateway
	if ($domain =~ /raw/)
	{
		exec
		{
			"enable_ip_forward_now_for_gateway":
				command => "/bin/echo 1 > /proc/sys/net/ipv4/ip_forward",
		}
	}
}
