class role_internet_enduser {
	$wan_gw_vip = $config::hosts::ip_list[wan_gw_vip]

	augeas {
		"set_gateway":
			context => "/files/etc/sysconfig/network",
			changes => [
				"set GATEWAY ${config::global::ip_prefix}.$wan_gw_vip"
			];

		"set_dns":
			context => "/files/etc/resolv.conf",
			changes => [
				"set nameserver[. = '8.8.8.8'] 8.8.8.8",
				"set nameserver[. = '8.8.4.4'] 8.8.4.4"
			];
	}
}
