class fastdfs::storage::install {
	firewall::filter::allow {
		"23000":
	}

	exec {
		"/root/fastdfs_storage_install.sh":
		require => File["/root/fastdfs_storage_install.sh"],
		unless => "/sbin/chkconfig | /bin/grep fdfs 2>/dev/null",
	}
}