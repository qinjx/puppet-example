define puppet::client::conf($ensure) {
	augeas {
		"puppet.conf_${name}" :
			changes => "set /files/etc/puppet/puppet.conf/${name} ${ensure}",
	}
}
