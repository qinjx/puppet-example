define vnc::server::conf($ensure) {
	augeas {
		"change_vncserver_config-$name":
		    context => "/etc/sysconfig/vncserver",
		    changes => "set $name \"$ensure\"",
	}
}