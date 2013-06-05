class role_internet_enduser {
	augeas {
		"set_gateway":
			context => "/files/etc/sysconfig/network",
			changes => "set GATEWAY ${config::global::ip_prefix}.${config::hosts::ip_list[wan_gw_vip]}";
		"set_dns":
			context => "/files/etc/resolv.conf",
			changes => [
				"set nameserver[. = '8.8.8.8'] 8.8.8.8",
				"set nameserver[. = '8.8.4.4'] 8.8.4.4"
			];
	}
}
