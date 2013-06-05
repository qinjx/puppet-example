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

		"/etc/puppet/iptables":
			ensure => directory;

		"/etc/puppet/iptables/pre.iptables":
			content => "
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT";
		"/etc/puppet/iptables/post.iptables":
			content => "
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited";
	}

	package {
		["vim-enhanced", "rsync", "cronie"]:
			require => Yum::Repo::Conf["centos_base"],
	}

	augeas {
		"ifcfg-eth0":
			changes => "set /files/etc/sysconfig/network-scripts/ifcfg-eth0/ONBOOT yes",
	}
}
