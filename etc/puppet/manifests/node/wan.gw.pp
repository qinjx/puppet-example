node /^wan\d*\.gw/ inherits default {
	gateway::conf {
		"nat_rule_for_internet_gateway":
			lan_interface => "eth0",
			wan_interface => "eth1",
	}

	include role_vip_holder, role_load_balancer, role_gateway
}
