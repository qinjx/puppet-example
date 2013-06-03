node /^vnc\d*\.sys/ inherits default {
	keepalived::vrrp::instance {
		"${config::hosts::ip_list[vnc_sys_vip]}":
		vip_add => "${config::global::ip_prefix}.${config::hosts::ip_list[vnc_sys_vip]}/24",
	}

	include role_vnc_server, role_vip_holder
}
