class role_ip_forwarder {
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
}
