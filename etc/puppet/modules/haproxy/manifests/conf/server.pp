define haproxy::conf::server($port, $cluster){
	exec {
		"delete_if_exists_server_$name":
			command => "sed -i \"/$name/d\" /etc/haproxy/conf.d/$cluster.cfg",
			path => "/bin",
			require => Haproxy::Conf::Cluster["$cluster"];

		"add_server_$name":
			command => "echo '	server	$name	$name:$port	check' >> /etc/haproxy/conf.d/$cluster.cfg",
			path => "/bin",
			require => Exec["delete_if_exists_server_$name"]
	}
}
