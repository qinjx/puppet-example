define firewall::filter::allow ($proto="tcp", $port = nil) {
	if ($port == nil) {
		$dport = $name
	} else {
		$dport = $port
	}

	iptables {
		"${proto}_${dport}":
		    proto => $proto,
		    dport => $dport,
		    jump  => "ACCEPT",
	}
}
