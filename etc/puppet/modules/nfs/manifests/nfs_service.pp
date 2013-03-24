class nfs_service
{	
	package
	{
		"nfs-utils":
			ensure => present;
	}

	service
	{
		"nfs":
			ensure => running,
			enable => true,
			require => Package["nfs-utils"]
	}
	
	iptables
	{
		"nfs_2049":
			proto       => "tcp",
			dport       => "2049",
			jump        => "ACCEPT",
	}
}
