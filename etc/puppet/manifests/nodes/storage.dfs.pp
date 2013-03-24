node /^storage\d*\.dfs/ inherits default {
	include role_dfs_storage
	include role_internet_enduser

	file
	{
		"/root/fasdfs_storage-up.sh":
			source => "puppet:///node_files/storage.dfs/fasdfs_storage-up.sh",
	}

	if ($domain =~ /raw/)
	{
		exec
		{
			"install_storage":
				command => "/bin/sh /root/fasdfs_storage-up.sh",
				require => File["/root/fasdfs_storage-up.sh"],
		}
	}
	else
	{
		service
		{		
			"fdfs_storaged":
				ensure => running,
				enable => true,
		}

		service
		{		
			"nginx":
				ensure => running,
				enable => true,
		}
	}
}
