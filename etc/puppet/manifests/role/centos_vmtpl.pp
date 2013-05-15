class role_centos_vmtpl {
	include yum::repo::base

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
			require => Class["yum::repo::base"],
	}
}
