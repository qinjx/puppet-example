define keepalived::vrrp::instance($vip_add) {
	$instance_id = $name

	file {
		"/etc/keepalived/keepalive.conf.d/vrrp_vi_${instance_id}.conf":
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
}",
			require => File["/etc/keepalived/keepalive.conf.d"],
	}
}
