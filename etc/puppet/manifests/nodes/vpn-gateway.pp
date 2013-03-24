node /^vpn-gateway\d*/ inherits default {
	$virtual_router_id = 253
	$vips = [
				"$ip_prefix.253/24",
			]
	include role_vip_holder

	include role_internet_enduser
	include role_vpn_dialer
	include role_gateway

	gateway::gateway::conf
	{
		"forward_to_ppp0":
			lan_interface => "eth0",
			wan_interface => "ppp0",
	}
}
