node /^wan\d*\.gw/ inherits default {
	gateway::conf {
		"nat_rule_for_gateway":
			lan_interface => "eth0",
			wan_interface => "eth1",
	}

	keepalived::vrrp::instance {
		"${config::hosts::ip_list[wan_gw_vip]}":
			vip_add => "${config::global::ip_prefix}.${config::hosts::ip_list[wan_gw_vip]}/24
		${config::wan::ip_add}/27 dev eth1",
			routes => "${config::global::ip_prefix}/24 to 0.0.0.0/0 gw ${config::wan::gateway} dev eth1",
	}

	haproxy::conf::cluster {
		"website":
			port => 80,
	}

	haproxy::conf::server {
		["nginx1.web", "nginx2.web", "nginx3.web"]:
			port => 80,
			cluster => "website",
	}

	firewall::filter::allow {
		"80":
	}

	include role_vip_holder, role_load_balancer, role_gateway
}
