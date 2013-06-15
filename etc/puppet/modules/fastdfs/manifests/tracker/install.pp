class fastdfs::tracker::install {
	package {
		"libevent":
	}

	firewall::filter::allow {
		"22122":
	}

	file {
		"/root/fastdfs_tracker_install.sh":
		    source => "puppet:///modules/fastdfs/tracker/fastdfs_tracker_install.sh",
	}

	exec {
		"/root/fastdfs_tracker_install.sh":
		    require => File["/root/fastdfs_tracker_install.sh"],
		    unless => "/sbin/chkconfig | /bin/grep fdfs 2>/dev/null",
	}
}
