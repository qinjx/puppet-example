node /^nfs\d*\.sys/ inherits default {
  keepalived::vrrp::instance {
    "${config::hosts::ip_list[nfs_sys_vip]}":
      vip_add => "${config::global::ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}/24",
  }

  nfs::export {
    "/opt/nfs/upload":
    client => "${config::global::ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}/24",
    permission => "rw",
    require => File["/opt/nfs/upload"],
  }

  file {
    "/opt/nfs/upload":
      ensure => directory,
  }

	include role_vip_holder, role_nfs_server
}