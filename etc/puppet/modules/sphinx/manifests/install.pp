class sphinx::install {
	iptables {
		"tcp_9312_for_sphinx":
			proto       => "tcp",
			dport       => "9312",
			jump        => "ACCEPT",
	}
}