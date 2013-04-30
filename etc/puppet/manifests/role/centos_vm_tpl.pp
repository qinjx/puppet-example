class role_centos_vm_tpl {
	file {
		"/etc/udev/rules.d/70-persistent-net.rules":
			ensure => absent;

		"/etc/yum.repos.d/CentOS-Base.repo":
			ensure => absent;
		
		"/etc/yum.repos.d/CentOS-Debuginfo.repo":
			ensure => absent;
		
		"/etc/yum.repos.d/CentOS-Media.repo":
			ensure => absent;
		
		"/etc/yum.repos.d/CentOS-Vault.repo":
			ensure => absent;
	}
}
