class compile_php_ext
{
	#phpize, autoconf
	package
	{
		["php", "php-devel", "autoconf"]:
			ensure => present,
			require => Yumrepo["centos_base", "php"],
	}
}
