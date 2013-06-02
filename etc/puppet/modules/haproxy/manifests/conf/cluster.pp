define haproxy::conf::cluster($port, $bind_ip = "0.0.0.0") {
	file {
		"/etc/haproxy/conf.d/$name.cfg":
			content => "frontend $name $bind_ip:$port
	default_backend $name

backend $name
	balance roundrobin
",
			require => File["/etc/haproxy/conf.d"],
	}

	firewall::filter::allow {
		"$port":
	}
}
