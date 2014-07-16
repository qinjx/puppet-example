define haproxy::conf::server($port, $cluster, $check_port = nil, $server = $name) {
	if ($check_port == nil) {
		$check_string = ""
	} else {
		$check_string = "port $check_port"
	}

	$line = "	server  $server   $server:$port     check $check_string"
	$file = "/etc/haproxy/conf.d/$cluster.cfg"
	exec {
		"add_server_$server:$cluster":
			command => "echo '$line' >> $file",
			notify => Service["haproxy"],
			onlyif => "test `grep '$server:$port' $file | wc | awk '{print \$1}'` -eq 0",
			require => Haproxy::Conf::Cluster[$cluster],
	}
}
