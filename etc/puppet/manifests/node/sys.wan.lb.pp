node /^sys\d*\.wan\.lb/ inherits default {
	keepalived::vrrp::instance {
		"${config::hosts::ip_list[sys_wan_lb_vip]}":
			vip_add => "${config::global::ip_prefix}.${config::hosts::ip_list[sys_wan_lb_vip]}/24",
	}

	haproxy::conf::cluster {
		"vnc_sys":
			port => 5901
	}

	haproxy::conf::server {
		"172.16.0.1":
			port => 5901,
			cluster => "vnc_sys"
	}

	yum::repo::conf {
		"pptp":
	}

	include role_load_balancer, role_vip_holder, role_pptp_server
}
