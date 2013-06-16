node /^storage\d*\.dfs/ inherits default {
	keepalived::vrrp::instance {
		"${config::hosts::ip_list[nfs_sys_vip]}":
		vip_add => "${config::global::ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}/24",
	}

	nfs::export {
		"/mnt/fastdfs/upload_files":
	}

	include role_fastdfs_storage, role_nfs_server, role_vip_holder, role_svn_server, role_internet_enduser
}
