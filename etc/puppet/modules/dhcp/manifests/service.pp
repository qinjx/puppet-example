class dhcp::service {
	service {
		"dhcpd":
			require => Class["dhcp::install"],
	}

	firewall::filter::allow {
		"67":
	}
}
