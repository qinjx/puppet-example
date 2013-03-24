class php_extensions
{
	package
	{
		["php-mysql","php-mbstring","php-mcrypt","php-eaccelerator"]:
			ensure => present,
			require => Yumrepo["php"],
	}
}
