node /^sys\d*\.wan\.lb/ inherits default {
	$virtual_router_id = 1
	$vips = [
				"$ip_prefix.1/24",
	]
	include role_vip_holder

	include role_load_balancer
	include role_ssh_term
	include role_internet_enduser
	include role_vpn_server

	package
	{
		["expect"]:
			ensure => present,
			require => Yumrepo["centos_base"],
	}
}
