node /^internet\-gateway/ inherits default {
	include role_vpn_server

	#Acts as Physical Server network neighbor
	augeas
	{
		"set_eth0_net_mask":
			context => "/files/etc/sysconfig/network-scripts/ifcfg-eth0",
			changes => [
				"set NETMASK 255.255.0.0"
			],
	}

	#Acts as NAT server
	include role_gateway
	gateway::gateway::conf
	{
		"nat_rule_for_internet_gateway":
			lan_interface => "eth0",
			wan_interface => "eth1",
	}

	#Acts as global load balancer
	include role_load_balancer

	file {
		"wan_lb_haproxy_config":
			path => "/etc/haproxy/haproxy.cfg",
			source => "puppet:///node_files/internet-gateway/haproxy.cfg",
			require => Package["haproxy"]
	}
	
	iptables
	{
		"web_http_80":
			proto       => "tcp",
			dport       => "80",
			jump        => "ACCEPT";
		"web_https_443":
			proto       => "tcp",
			dport       => "443",
			jump        => "ACCEPT";
		"ssh_term_proxy":
			proto       => "tcp",
			dport       => "2034",
			jump        => "ACCEPT";
		"svn_proxy":
			proto       => "tcp",
			dport       => "3690",
			jump        => "ACCEPT";
		"local_ssh_9999":
			proto       => "tcp",
			dport       => "9999",
			jump        => "ACCEPT";
	}
}
