node /^svn\d*/ inherits default {
	$virtual_router_id = 14
	$vips = [
		"$ip_prefix.14/24",
	]
	include role_vip_holder
	include role_svn_server
}
