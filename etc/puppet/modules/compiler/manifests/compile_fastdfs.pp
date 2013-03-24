class compile_fastdfs
{
	package
	{
		["libevent-devel"]:
			ensure => present,
			require => Yumrepo["centos_base"],
	}
}
