define haproxy::conf::cluster($port, $bind_ip = "0.0.0.0", $check_option=nil) {
	if (nil == $check_option) {
		$check_option_string = ""
	} else {
		$check_option_string = "option $check_option"
	}
	file {
		"/etc/haproxy/conf.d/$name.cfg":
			content => "frontend $name $bind_ip:$port
	default_backend $name

backend $name
	balance roundrobin
	$check_option_string
",
			require => File["/etc/haproxy/conf.d"],
	}

	firewall::filter::allow {
		"$port":
	}
}
