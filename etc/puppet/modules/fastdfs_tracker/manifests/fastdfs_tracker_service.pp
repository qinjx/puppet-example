class fastdfs_tracker_service
{	
	iptables
	{
		"fdfs_tracker_22122":
			proto       => "tcp",
			dport       => "22122",
			jump        => "ACCEPT",
	}
}
