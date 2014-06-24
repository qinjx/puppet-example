node /^tracker\d*\.dfs/ inherits default {
	include fastdfs::tracker::install, fastdfs::tracker::service
}
