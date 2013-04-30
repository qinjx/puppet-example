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
		
		"/etc/puppet/iptables":
			ensure => directory;

		"/etc/puppet/iptables/pre.iptables":
			content => "-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT",
			mode    => 0600;

		"/etc/puppet/iptables/post.iptables":
			content => "-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited",
			mode    => 0600;
	}

	package {
		["vim-enhanced", "rsync", "cronie"]:
			ensure => present,
			require => Class["base_yum_repo"],
	}
}
