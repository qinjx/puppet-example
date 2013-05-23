node /^wan\d*\.gw/ inherits default {
	vip::holder {
    	"wan_ip":
			router_id => 1,
			vip_array => [$config::wan::ip],
	}

	gateway::conf {
		"nat_rule_for_internet_gateway":
			lan_interface => "eth0",
			wan_interface => "eth1",
	}

	include role_vip_holder, role_load_balancer, role_gateway
	import "../config/wan.pp"
}
