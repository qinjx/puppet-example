class fastdfs::storage::install {
	firewall::filter::allow {
		"23000":
	}

	file {
		"/root/fastdfs_storage_install.sh":
		source => "puppet:///modules/fastdfs/storage/fastdfs_storage_install.sh",
	}

	exec {
		"/root/fastdfs_storage_install.sh":
		require => File["/root/fastdfs_storage_install.sh"],
		unless => "/sbin/chkconfig | /bin/grep fdfs 2>/dev/null",
	}
}