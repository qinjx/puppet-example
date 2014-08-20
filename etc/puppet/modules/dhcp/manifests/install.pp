class dhcp::install {
	package {
		"dhcp":
	}

	exec {
		"set_default_dhcp_args":
			command => 'sed -i "s/DHCPDARGS.*$/DHCPDARGS=eth0/g" /etc/sysconfig/dhcpd',
			unless => 'grep "DHCPDARGS=" /etc/sysconfig/dhcpd';
		"insert_default_dhcp_conf":
			command => 'echo \'
option domain-name "example.com";
option domain-name-servers 114.114.114.114;
default-lease-time 3600;
subnet 192.168.1.0 netmask 255.255.255.0 {
	range 192.168.1.50 192.168.1.100;
	option routers 192.168.1.1;
}
\' > /etc/dhcp/dhcpd.conf',
			unless => 'grep -v "#" /etc/dhcp/dhcpd.conf';
	}
}
