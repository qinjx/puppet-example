class role_secure_web_server
{
	iptables
	{
		"https_443":
			proto       => "tcp",
			dport       => "443",
			jump        => "ACCEPT",
	}
}
