define yum::group::install {
	#$name_without_space = regsubst($name, " ", "", "G")
	exec {
		"yum_group_install_$name":
			unless  => '/usr/bin/yum grouplist "$name" | /bin/grep "^Installed Groups"',
			command => '/usr/bin/yum -y groupinstall "$name"',
	}
}
