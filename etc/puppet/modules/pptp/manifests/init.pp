class pptp
{
	package
	{
		["ppp", "pptp", "pptp-setup"]:
			ensure => present,
			require => Yumrepo["centos_base"],
	}
}