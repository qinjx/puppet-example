node /^lan\d*\.lb/ inherits default {
	$virtual_router_id = 50
	$vips = [
				"$ip_prefix.50/24",
			]
	include role_vip_holder
	include role_load_balancer
	
	file {
		"wan_lb__haproxy_config":
			path => "/etc/haproxy/haproxy.cfg",
			source => "puppet:///node_files/lan.lb/haproxy.cfg",
			require => Package["haproxy"]
	}
	
	iptables
	{
		"mysql_3306":
		proto       => "tcp",
		dport       => "3306",
		jump        => "ACCEPT",
	}
	
	iptables
	{
		"sphinx_9312":
		proto       => "tcp",
		dport       => "9312",
		jump        => "ACCEPT",
	}
	
	iptables
	{
		"fastdfs_tracker":
		proto       => "tcp",
		dport       => "22122",
		jump        => "ACCEPT",
	}
}
