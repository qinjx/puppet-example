class gateway::install {
	exec {
		"enable_ip_forward_now":
			command => "/bin/echo 1 > /proc/sys/net/ipv4/ip_forward";
		"delete_forward_reject_rule":
			command => "/bin/sed -i \"/FORWARD \-j REJECT/d\" /etc/puppet/iptables/post.iptables",
			require => File["/etc/puppet/iptables/post.iptables"];
	}

	augeas {
		"enable_ip_forward_forever":
			context => "/files/etc/sysctl.conf",
			changes => "set net.ipv4.ip_forward 1",
	}
}
