node /^storage\d*\.dfs/ inherits default {
	keepalived::vrrp::instance {
		"${config::hosts::ip_list[nfs_sys_vip]}":
			vip_add => "${config::global::ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}/24",
	}

	nfs::export {
		"/mnt/fastdfs/upload_files":
			client => "${config::global::ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}/24",
    		permission => "ro",
	}

	include fastdfs::storage::install, fastdfs::storage::service
	include keepalived::install, keepalived::service
}
