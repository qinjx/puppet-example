class compile_nginx
{
	package
	{
		["pcre-devel", "openssl-devel", "zlib-devel"]:
			ensure => present,
			require => Yumrepo["centos_base"],
	}
}
