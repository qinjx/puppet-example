node /^puppet-server\d*/ inherits default {
	$virtual_router_id = 10
	$vips = [
				"$host_puppet_server_ip/24",
	]
	include role_vip_holder

	include role_puppet_master
	include role_internet_enduser
}
