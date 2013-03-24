class role_puppet_master
{
	include puppet_master
	cron
	{
		"restart_puppet_master":
			command => "/etc/init.d/puppetmaster restart",
			user => root,
			minute => "*/15",
			require => Package["cronie"],
	}
}
