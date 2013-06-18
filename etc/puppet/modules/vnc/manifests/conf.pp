define vnc::conf($ensure) {
	augeas {
		"change_vncserver_config-$name":
		    context => "/files/etc/sysconfig/vncservers",
		    changes => "set $name \"$ensure\"",
			notify => Service["vncserver"],
	}
}
