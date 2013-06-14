class fastdfs::storage::service {
	service {
		"fdfs_storaged":
		    require => Class["fastdfs::storage::install"],
	}
}