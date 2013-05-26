node /^wan\d*\.gw/ inherits default {
	gateway::conf {
		"nat_rule_for_internet_gateway":
			lan_interface => "eth0",
			wan_interface => "eth1",
	}

	firewall::nat::forward {
		"tcp_80":
			wan_interface => "eth1",
			proto => "tcp",
			ip => $config::global::wan_ip,
			port => 80,
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[user_wan_lb_vip]}",
			dest_port => 80,
	}

	include role_vip_holder, role_load_balancer, role_gateway
}
