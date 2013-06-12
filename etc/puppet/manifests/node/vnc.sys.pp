node /^vnc\d*\.sys/ inherits default {
	$ip_suffix = regsubst($ipaddress, $config::global::ip_prefix, "", "G")
	keepalived::vrrp::instance {
		"${config::hosts::ip_list[vnc_sys_vip]}":
		vip_add => "${config::global::phy_server_ip_prefix}$ip_suffix/24",
	}

	package {
		["virt-manager", "qemu-kvm", "libvirt"]:
	}

	service {
		"libvirtd":
		    require => Package["libvirt"],
	}

	include role_vnc_server, role_vip_holder
}
