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
			check_option => "httpchk HEAD /status.txt HTTP/1.0";
		"web_tool":
			port => 8000,
			check_option => "httpchk HEAD /status.txt HTTP/1.0";
	}

	haproxy::conf::server {
		["nginx1.web", "nginx2.web", "nginx3.web"]:
			port => 80,
			cluster => "website";
		"tool.web":
			port => 80,
			cluster => "web_tool";
	}

	firewall::nat::forward {
		"ssh_forward_1":
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => $config::wan::opened_port[ssh_1],
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[vnc1_sys]}",
			dest_port => 22;
		"ssh_forward_2":
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => $config::wan::opened_port[ssh_2],
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[nfs_sys_vip]}",
			dest_port => 22;
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
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[svn1_sys]}",
			dest_port => 3690;
    	"mysql_forward":#临时开放mysql端口
			wan_interface => "eth1",
			ip => $config::wan::ip_add,
			port => 3306,
			dest_ip => "${config::global::ip_prefix}.${config::hosts::ip_list[mysql1_db]}",
			dest_port => 3306;
	}

	augeas {
		"ifcfg_wan":
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

	ssh::server::conf {
		"ListenAddress":
			ensure => $ipaddress,
			require => Class["ssh::server::install"],
	}

	exec {
		"enable_ip_forward_now":
		command => "/sbin/sysctl -e -p",
		refreshonly => true;
		"delete_iptables_forward_reject_rule":
		command => "/bin/sed -i \"/FORWARD -j REJECT/d\" /etc/puppet/iptables/post.iptables";
	}

	augeas {
		"enable_ip_forward_forever":
		context => "/files/etc/sysctl.conf",
		changes => "set net.ipv4.ip_forward 1",
		notify => Exec["enable_ip_forward_now"],
	}

	yum::repo::conf {
		"pptp":
	}

	include pptp::server::install, pptp::server::service
	include haproxy::install, haproxy::service
	include keepalived::install, keepalived::service
}
