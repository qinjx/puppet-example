define haproxy::conf::server($port, $cluster, $check_port = nil) {
	if ($check_port == nil) {
		$check_string = ""
	} else {
		$check_string = "port $check_port"
	}

	$line = "	server  $name   $name:$port     check $check_string"
	$file = "/etc/haproxy/conf.d/$cluster.cfg"
	exec {
		"add_server_$name":
			command => "echo '$line' >> $file",
			notify => Service["haproxy"],
			onlyif => "test `grep '$name:$port' $file | wc | awk '{print \$1}'` -eq 0",
			require => File["/etc/haproxy/conf.d"],
	}
}
