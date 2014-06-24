node /^nfs\d*\.sys/ inherits default {
	keepalived::vrrp::instance {
		"${config::hosts::ip_list[nfs_sys_vip]}":
			vip_add => "${config::global::ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}/24
			${config::global::phy_server_ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}/24",
	}

	nfs::export {
		"/opt/nfs/video":
			client => "${config::global::ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}/24",
			permission => "rw",
			require => File["/opt/nfs/video"];
		"/opt/nfs/upload":
			client => "${config::global::ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}/24",
			permission => "rw",
			require => File["/opt/nfs/upload"];
		"/opt/nfs/session":
			client => "${config::global::ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}/24",
			permission => "rw",
			require => File["/opt/nfs/session"];
		"/opt/nfs/iso":
			client => "${config::global::phy_server_ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}/24",
			permission => "ro",
			require => File["/opt/nfs/iso"];
	}

	file {
		"/opt/nfs":
			ensure => directory;
		"/opt/nfs/upload":
			ensure => directory;
		"/opt/nfs/video":
			ensure => directory;
		"/opt/nfs/session":
			ensure => directory;
		"/opt/nfs/iso":
			ensure => directory;
	}

	include nfs::install, nfs::service
	include keepalived::install, keepalived::service
}
