define haproxy::conf::server($port, $cluster, $check_port = nil) {
	if ($check_port == nill) {
		$check_string = "port $port"
	} else {
		$check_string = "port $check_port"
	}
	exec {
		"delete_if_exists_server_$name":
			command => "sed -i \"/$name/d\" /etc/haproxy/conf.d/$cluster.cfg",
			path => "/bin",
			require => Haproxy::Conf::Cluster["$cluster"];

		"add_server_$name":
			command => "echo '	server	$name	$name:$port	check $check_string' >> /etc/haproxy/conf.d/$cluster.cfg",
			path => "/bin",
			require => Exec["delete_if_exists_server_$name"];
	}
}
