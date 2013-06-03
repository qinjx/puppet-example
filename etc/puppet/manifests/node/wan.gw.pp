node /^wan\d*\.gw/ inherits default {
	gateway::conf {
		[
			"eth1", #allow LAN access internet via eth0 -> eth1, NAT
			"eth0" #allow internet access LAN via eth1 -> eth0, port forward
		]:
	}

	keepalived::vrrp::instance {
		"${config::hosts::ip_list[wan_gw_vip]}":
			vip_add => "${config::global::ip_prefix}.${config::hosts::ip_list[wan_gw_vip]}/24
		${config::wan::ip_add}/${config::wan::prefix} dev eth1",
			routes => "${config::global::ip_prefix}/24 to 0.0.0.0/0 gw ${config::wan::gateway} dev eth1",
	}

	haproxy::conf::cluster {
		"website":
			port => 80,
			bind_ip => $config::wan::ip_add,
		    check_option => "httpchk HEAD /status.txt HTTP/1.0",
	}

	haproxy::conf::server {
		["nginx1.web", "nginx2.web", "nginx3.web"]:
			port => 80,
			cluster => "website",
	}

	firewall::nat::forward {
		"ssh_forward":
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => $config::wan::opened_port[ssh],
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[sys_wan_lb_vip]}",
			dest_port => 22;
		"vpn_forward":
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => $config::wan::opened_port[vpn],
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[sys_wan_lb_vip]}",
			dest_port => 1723;
		"vnc_forward":
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => $config::wan::opened_port[vnc],
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[vnc_sys_vip]}",
			dest_port => 5901;
		"svn_forward":
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => $config::wan::opened_port[svn],
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[sys_wan_lb_vip]}",
			dest_port => 3690;
	}

	include role_vip_holder, role_load_balancer, role_gateway
}
