class haproxy_service
{
	package
	{
		["haproxy"]:
			ensure => present;
	}	
	
	service
	{
		"haproxy":
			enable => true,
			ensure => running,
			require => Package["haproxy"],
	}	
}
