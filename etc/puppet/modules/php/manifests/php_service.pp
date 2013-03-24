class php_service
{
	package
	{
		["php-fpm"]:
			ensure => present,
	}

	service
	{
		"php-fpm":
			ensure => running,
			enable => true,
			require => Package["php-fpm"]
	}
	
	iptables
	{
		"php_fcgi_9000":
			proto       => "tcp",
			dport       => "9000",
			jump        => "ACCEPT",
	}
}
