node /^wan\d*\.gw/ inherits default {
	gateway::conf {
		"nat_rule_for_internet_gateway":
			lan_interface => "eth0",
			wan_interface => "eth1",
	}

	router::port::forward {
		"tcp_80":
		    wan_interface => "eth1",
		    proto => "tcp",
		    port => 80,
		    ip => $config::wan::ip,
		    dest_ip => $config::hosts::ip_list[user_wan_lb_vip],
			dest_port => 80
	}

	include role_vip_holder, role_load_balancer, role_gateway
}
