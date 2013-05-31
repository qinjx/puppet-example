node /^wan\d*\.gw/ inherits default {
	gateway::conf {
		[
			"eth1", #allow LAN access internet via eth0 -> eth1, NAT
			"eth0", #allow internet access LAN via eth1 -> eth0, port forward
		]:
	}

	keepalived::vrrp::instance {
		"${config::hosts::ip_list[wan_gw_vip]}":
			vip_add => "${config::global::ip_prefix}.${config::hosts::ip_list[wan_gw_vip]}/24
		${config::wan::ip_add}/27 dev eth1",
			routes => "${config::global::ip_prefix}/24 to 0.0.0.0/0 gw ${config::wan::gateway} dev eth1",
	}

	haproxy::conf::cluster {
		"website":
			port => 80,
	}

	haproxy::conf::server {
		["nginx1.web", "nginx2.web", "nginx3.web"]:
			port => 80,
			cluster => "website",
	}

	firewall::filter::allow {
		"80":
	}

	firewall::nat::forward {
		"tcp_80":
			wan_interface => "eth1",
			proto => "tcp",
			ip => $config::global::wan_ip,
			port => 1022,
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[nginx1_web]}",
			dest_port => 22,
	}

	include role_vip_holder, role_load_balancer, role_gateway
}
