class role_search_engine
{	
	class
	{
		"sphinx":
			sphinx_rpm_url => "${url_yum_mirror_prefix}rpm_beyond_yum/sphinx-2.0.4-1.rhel6.x86_64.rpm";
	}
	
	include sphinx
	
	file
	{
		"/etc/sphinx/sphinx.conf":
			require => Package["sphinx"],
			source => "puppet:///node_files/shop.se/sphinx.conf",
	}
	
	if ($domain =~ /raw/)
	{
	}
	else
	{
		service
		{
			"searchd":
				ensure => running,
				enable => true,
				require => Exec["build_index"],
		}
	}
}

