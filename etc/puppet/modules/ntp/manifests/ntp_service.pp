class ntp_service
{
	package
	{
		"ntp":
			ensure => present,
	}

	iptables
	{
		"ntp_123":
			proto => "udp",
			dport => 123,
			jump => "ACCEPT",
	}
}