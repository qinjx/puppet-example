class role_vip_holder
{
	class
	{
		"keepalived":
			email => "root@example.com"; # array also allowed
	}

	include common #keepalived reqires common module
	include keepalived
	
	keepalived::vrrp_instance {
		"vrrp_instance_$virtual_router_id":
			virtual_router_id => $virtual_router_id,
			password          => "a_dummy_pass",
			virtual_addresses => $vips;
	}
}
