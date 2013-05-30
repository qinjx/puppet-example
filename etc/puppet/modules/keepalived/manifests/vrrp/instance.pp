define keepalived::vrrp::instance($vip_add, $routes=nil) {
	$instance_id = $name
	if (nil == $routes) {
		$virtual_routes = ""
	} else {
		$virtual_routes = "virtual_routes {
		$routes
	}"
	}

	file {
		"/etc/keepalived/conf.d/vrrp_vi_${instance_id}.conf":
			content => "vrrp_instance vrrp_instance_${instance_id} {
	state SLAVE
	interface eth0
	virtual_router_id ${instance_id}
	priority 100
	advert_int 1
	authentication {
		auth_type pass
		auth_pass a_dummy_pass
	}
	
	virtual_ipaddress {
		$vip_add
	}
	$virtual_routes
}",
			require => File["/etc/keepalived/conf.d"],
	}
}
