node /^user\d*\.wan\.lb/ inherits default {
	$virtual_router_id = 2
	$vips = [
				"$ip_prefix.2/24",
			]
	include role_vip_holder

	include role_load_balancer

	file {
		"wan_lb_haproxy_config":
			path => "/etc/haproxy/haproxy.cfg",
			source => "puppet:///node_files/user.wan.lb/haproxy.cfg",
			require => Package["haproxy"]
	}
	
	iptables
	{
		"web_http_80":
		proto       => "tcp",
		dport       => "80",
		jump        => "ACCEPT",
	}
	
	iptables
	{
		"web_https_443":
		proto       => "tcp",
		dport       => "443",
		jump        => "ACCEPT",
	}
}

