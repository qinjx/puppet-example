node /^file-server\d*/ inherits default {
	$yum_mirror_www_root = "/opt/yum_mirror"
	$nfs_root = "/opt/nfs"

	$virtual_router_id = 11
	$vips = [
		"$ip_prefix.11/24",
		"$ip_prefix.12/24",
	]
	include role_vip_holder

	include role_nfs_server
	include role_yum_mirror
	include role_web_server
	include role_internet_enduser

	if ($hostname == "file-server1") {
		$source_host  = "file-server2"
	} else {
		$source_host  = "file-server1"
	}

	nginx::resource::vhost {
		"$host_yum_mirror":
			ensure   => present,
			www_root => "$yum_mirror_www_root",
	}

	cron
	{
		"update_php_code_from_nfs":
			ensure => absent,
			command => "svn up /opt/nfs/php_from_svn/hkec; svn up /opt/nfs/php_from_svn/lotusphp;",
			minute => "*/3",
			require => Package["cronie"],
	}

	augeas
	{
		"export_yum_mirror" : 
			context => "/files/etc/exports",
			changes => [ 
				"set dir[. = \"$yum_mirror_www_root\"] $yum_mirror_www_root",
				"set dir[. = \"$yum_mirror_www_root\"]/client $ip_prefix.0/24",
				"set dir[. = \"$yum_mirror_www_root\"]/client/option[1] ro",
				"set dir[. = \"$yum_mirror_www_root\"]/client/option[2] all_squash",
		    ],
	}

	file
	{
		"/opt/sync_file_server.ini":
			content => "source_host='$source_host'",
	}

	file
	{
		"/opt/sync_file_server.sh":
			mode => 755,
			source => "puppet:///node_files/file-server/sync_file_server.sh",
			require => File["/opt/sync_file_server.ini"],
	}
	
	cron
	{
		"sync_file_server":
			command => "/opt/sync_file_server.sh",
			require => File["/opt/sync_file_server.sh"],
			minute => 0,
			hour => 5,
	}
}
