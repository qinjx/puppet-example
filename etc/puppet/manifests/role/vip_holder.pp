class role_vip_holder {
	class {
		"keepalived":
			email => "root@example.com", # array also allowed
	}

	include common, keepalived #keepalived requires common module
}

define vip::holder($router_id, $vip_array) {
	keepalived::vrrp_instance {
		"vrrp_instance_$virtual_router_id":
			virtual_router_id => $router_id,
			password          => "a_dummy_pass",
			virtual_addresses => $vip_array,
	}
}