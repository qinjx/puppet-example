class role_centos_vmtpl {
	file {
		"/etc/udev/rules.d/70-persistent-net.rules":
			ensure => absent;

		[
		"/etc/yum.repos.d/CentOS-Base.repo",
		"/etc/yum.repos.d/CentOS-Debuginfo.repo",
		"/etc/yum.repos.d/CentOS-Media.repo",
		"/etc/yum.repos.d/CentOS-Vault.repo"
		]:
			ensure => absent;
	}

	package {
		["vim-enhanced", "rsync", "cronie"]:
			ensure => present,
			require => Yum::repo::conf["centos_base"],
	}

	augeas {
		"ifcfg-eth0":
			changes => "set /files/etc/sysconfig/network-scripts/ifcfg-eth0/ONBOOT yes",
	}
}
