define haproxy::conf::cluster($port) {
	file {
		"/etc/haproxy/conf.d/$name.cfg":
			content => "frontend $name *:$port
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
