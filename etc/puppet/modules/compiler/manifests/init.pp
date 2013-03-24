class compiler
{
	# general compiling tool	
	package
	{
		["gcc", "make"]:
			ensure => present,
			require => Yumrepo["centos_base"],
	}
	include compile_fastdfs
	include compile_nginx
	include compile_php_ext
}
