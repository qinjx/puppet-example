class fastdfs::tracker::service {
	service {
		"fdfs_trackerd":
		    require => Class["fastdfs::tracker::install"],
	}
}