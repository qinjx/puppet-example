class system_base
{
	package
	{
		["vim-enhanced", "rsync", "cronie"]:
			ensure => present,
			require => Yumrepo["centos_base"],
	}

	file
	{
		"/etc/puppet/iptables":
			ensure => directory,
	}

	file
	{
		"/etc/puppet/iptables/pre.iptables":
			content => "-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT",
			mode    => 0600,
	}

	file
	{
		"/etc/puppet/iptables/post.iptables":
			content => "-A INPUT -j REJECT --reject-with icmp-host-prohibited
#-A FORWARD -j REJECT --reject-with icmp-host-prohibited",
			mode    => 0600,
	}
}
