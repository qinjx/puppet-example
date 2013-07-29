node /^vnc\d*\.sys/ inherits default {
	$ip_suffix = regsubst($ipaddress, "${config::global::ip_prefix}.", "", "G")
	keepalived::vrrp::instance {
		"$ip_suffix":
		vip_add => "${config::global::phy_server_ip_prefix}.$ip_suffix/24",
	}

	package {
		"expect":
	}

	include role_vnc_server, role_vip_holder, role_virt_manager
}
