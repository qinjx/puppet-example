class svn
{
	package
	{
		["subversion"]:
			ensure => present,
			require => Yumrepo["centos_base", "centos_updates"],
	}

	file
	{
		"/etc/init.d/subversion":
			mode => 755,
			source => "puppet:///modules/svn/init.d/subversion";
		"/etc/subversion/subversion.conf":
			source => "puppet:///modules/svn/subversion.conf";
		"/var/lib/svn":
			ensure => directory;
	}

	service
	{
		"subversion":
			enable => true,
			ensure => running,
	}
	
	iptables
	{
		"svnserve_3690":
			proto       => "tcp",
			dport       => "3690",
			jump        => "ACCEPT",
	}
}
