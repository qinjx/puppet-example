node /^storage\d*\.dfs/ inherits default {
	include role_fastdfs_storage, role_nfs_server
}
