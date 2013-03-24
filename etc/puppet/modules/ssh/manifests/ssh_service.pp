class ssh_service
{	
	package
	{
		["openssh"]:
		ensure => present;
	}
	
	service
	{
		"ssh_server":
			name => "sshd",
			enable => true,
			ensure => running,
			require => Package["openssh"]
	}
	
	iptables
	{
		"sshd":
			proto       => "tcp",
			dport       => "22",
			jump        => "ACCEPT",
	}
}