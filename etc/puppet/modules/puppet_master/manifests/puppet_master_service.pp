class puppet_master_service
{
	package
	{
		["puppet-server"]:
			ensure => present,
			require => Yumrepo["epel"],
	}

	service
	{
		"puppetmaster":
			ensure     => running,
			enable     => true,
			require    => Package["puppet-server"],
	}
	
	iptables
	{
		"puppetmaster_8140":
			proto       => "tcp",
			dport       => "8140",
			jump        => "ACCEPT",
	}

	iptables
	{
		"puppetmaster_8140_udp":
			proto       => "udp",
			dport       => "8140",
			jump        => "ACCEPT",
	}	
}
