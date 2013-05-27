node /^sys\d*\.wan\.lb/ inherits default {
	keepalived::vrrp::instance {
		"${config::hosts::ip_list[sys_wan_lb_vip]}":
			vip_add => "${config::global::ip_prefix}.${config::hosts::ip_list[sys_wan_lb_vip]}/24",
	}

	include role_vip_holder
}
