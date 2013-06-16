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
			check_option => "httpchk HEAD /status.txt HTTP/1.0",
	}

	haproxy::conf::server {
		["nginx1.web", "nginx2.web", "nginx3.web"]:
			port => 80,
			cluster => "website",
	}

	firewall::nat::forward {
		"ssh_forward_1":
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => $config::wan::opened_port[ssh_1],
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[sys1_wan_lb]}",
			dest_port => 22;
		"ssh_forward_2":
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => $config::wan::opened_port[ssh_2],
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[sys2_wan_lb]}",
			dest_port => 22;
		"vpn_forward_1":
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => $config::wan::opened_port[vpn_1],
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[sys1_wan_lb]}",
			dest_port => 1723;
		"vpn_forward_2":
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => $config::wan::opened_port[vpn_2],
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[sys2_wan_lb]}",
			dest_port => 1723;
		"vnc_forward_1":
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => $config::wan::opened_port[vnc_1],
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[vnc1_sys]}",
			dest_port => 5901;
		"vnc_forward_2":
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => $config::wan::opened_port[vnc_2],
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[vnc2_sys]}",
			dest_port => 5901;
		"svn_forward":
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => $config::wan::opened_port[svn],
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}",
			dest_port => 3690;
	}

	augeas {
		"wan_config":
			context => "/files/etc/sysconfig/network-scripts/ifcfg-eth1",
			changes => [
				"set DEVICE eth1",
				"set TYPE Ethernet",
				"set ONBOOT YES",
				"set BOOTPROTO static",
				"set PREFIX ${config::wan::prefix}",
				"set GATEWAY ${config::wan::gateway}"
			],
	}

	include role_vip_holder, role_load_balancer, role_gateway
}
