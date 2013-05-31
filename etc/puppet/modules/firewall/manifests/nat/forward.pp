define firewall::nat::forward($wan_interface, $proto, $ip, $port, $dest_ip, $dest_port) {
	iptables {
		"port_forward_prerouting_rule_for_${proto}_${port}":
			table => "nat",
			chain => "PREROUTING",
			iniface => $wan_interface,
			proto => $proto,
			dport => $port,
			destination => $ip,
			todest => "$dest_ip:$dest_port",
			jump => "DNAT";
		"port_forward_postrouting_rule_for_${proto}_${port}":
			table => "nat",
			chain => "POSTROUTING",
			source => $ip,
			outiface => $wan_interface,
			jump => "MASQUERADE";
	}
}
