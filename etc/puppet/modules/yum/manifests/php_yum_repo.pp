class php_yum_repo
{	
	yumrepo
	{
		"php":
			descr => "CentOS-\$releasever - REMI",
			baseurl => "$url_yum_mirror_remi/enterprise/\$releasever/remi/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$url_yum_mirror_remi/RPM-GPG-KEY-remi",
			enabled => 0,
	}
}