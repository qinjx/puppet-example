define puppet::client::conf($ensure) {
	augeas {
		"puppet.conf_${name}" :
			content => "/files/etc/puppet/puppet.conf",
			changes => "set ${name} ${ensure}";
	}
}
