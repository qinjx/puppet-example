define gateway::conf {
	iptables {
		"gateway_postrouting_$name":
			table       => "nat",
			outiface    => $name,
			chain		=> "POSTROUTING",
			jump        => "MASQUERADE",
			proto       => "all",
	}
}
