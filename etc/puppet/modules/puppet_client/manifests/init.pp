class puppet_client {
	define conf ($ensure) {
		augeas {
			"puppet.conf_${name}" :
				changes => "set /files/etc/puppet/puppet.conf/${name} ${ensure}";
		}
	}

	service {
		"puppet":
			enable => true,
			ensure => running,
	}
}
