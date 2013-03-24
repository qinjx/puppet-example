class role_nfs_server
{
	include nfs

	package
	{
		["subversion"]:
			ensure => present,
	}

	file
	{
		$nfs_root:
			ensure => directory,
	}

	augeas
	{
		"export_nfs" : 
			context => "/files/etc/exports",
			changes => [ 
				"set dir[. = \"$nfs_root\"] $nfs_root",
				"set dir[. = \"$nfs_root\"]/client $ip_prefix.0/24",
				"set dir[. = \"$nfs_root\"]/client/option[1] ro",
				"set dir[. = \"$nfs_root\"]/client/option[2] all_squash",
		    ],
	}
}
