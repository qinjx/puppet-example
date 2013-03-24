node /^tracker\d*\.dfs/ inherits default {
	include role_dfs_tracker
	
	file
	{
		"/root/fasdfs_tracker-up.sh":
			source => "puppet:///node_files/tracker.dfs/fasdfs_tracker-up.sh",
	}

	if ($domain =~ /raw/)
	{
		exec
		{
			"install_tracker":
				command => "/bin/sh /root/fasdfs_tracker-up.sh",
				require => File["/root/fasdfs_tracker-up.sh"],
		}
	}
	else
	{
			service
			{
				"fdfs_trackerd":
					ensure => running,
					enable => true,
					require => Exec["install_tracker"]
			}
	}
}