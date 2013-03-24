class fastdfs_storage_service
{	
	iptables
	{
		"fdfs_storage_23000":
			proto       => "tcp",
			dport       => "23000",
			jump        => "ACCEPT",
	}
	
	iptables
	{
		"fdfs_web":
			proto       => "tcp",
			dport       => "80",
			jump        => "ACCEPT",
	}
}
