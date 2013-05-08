class role_centos_vm_tpl {
	include fast_yum_repo,  base_yum_repo

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

	package {
		["vim-enhanced", "rsync", "cronie"]:
			ensure => present,
			require => Class["base_yum_repo"],
	}
}
