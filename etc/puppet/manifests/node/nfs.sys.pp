node /^nfs\d*\.sys/ inherits default {
  keepalived::vrrp::instance {
    "${config::hosts::ip_list[nfs_sys_vip]}":
      vip_add => "${config::global::ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}/24",
  }
	include role_vip_holder, role_nfs_server
}