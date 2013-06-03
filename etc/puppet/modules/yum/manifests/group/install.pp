define yum::group::install {
	exec {
		'yum_group_install_$name':
			unless  => '/usr/bin/yum grouplist "$name" | /bin/grep "^Installed Groups"',
			command => '/usr/bin/yum -y groupinstall "$name"',
	}
}