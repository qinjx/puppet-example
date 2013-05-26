define firewall::filter::allow ($proto="tcp", $port = nil) {
	if ($port==nil) {
		$port = $name
	}

	iptables {
		"${proto}_${port}":
		    proto => $proto,
		    dport => $port,
		    jump  => "ACCEPT",
	}
}