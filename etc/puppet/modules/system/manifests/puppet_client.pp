class puppet_client {
	
	define puppet::conf ($ensure) 
	{
		augeas
		{
			"puppet.conf_${name}" :
				changes => "set /files/etc/puppet/puppet.conf/${name} ${ensure}";
		}
	}

	service
	{
		"puppet_client":
			name => "puppet",
			enable => true,
			ensure => running,
			hasrestart => true,
			hasstatus => true,
	}
}
