define rsyslog::conf($ensure) {
	augeas {
		"change_rsyslog_setting_${name}":
			context => "/files/etc/rsyslog.conf",
			changes => "set ${name} ${ensure}",
			notify => Service["rsyslog"],
	}
}

