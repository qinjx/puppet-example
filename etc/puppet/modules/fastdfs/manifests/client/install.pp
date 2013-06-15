class fastdfs::client::install {
	file {
		"/root/fastdfs_client_install.sh":
			source => "puppet:///modules/fastdfs/client/fastdfs_client_install.sh",
	}

	exec {
		"/root/fastdfs_client_install.sh":
			require => File["/root/fastdfs_client_install.sh"],
			unless => "/bin/ls /etc | /bin/grep fdfs 2>/dev/null",
	}
}