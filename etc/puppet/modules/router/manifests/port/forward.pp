define router::port::forward($wan_interface, $proto, $ip, $port, $dest_ip, $dest_port) {
	iptables {
		"port_forward_rule_for_${proto}_${port}":
			table => "nat",
		    chain => "PREROUTING",
			iniface => $wan_interface,
		    proto => $proto,
		    dport => $port,
			destination	=> $ip,
			todest	=> "$dest_ip:$dest_port",
		    jump => "DNAT",
	}
}