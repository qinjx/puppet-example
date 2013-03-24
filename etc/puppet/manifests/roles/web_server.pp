class role_web_server
{
	include nginx

	iptables
	{
		"nginx_http_80":
			proto       => "tcp",
			dport       => "80",
			jump        => "ACCEPT",
	}
}
