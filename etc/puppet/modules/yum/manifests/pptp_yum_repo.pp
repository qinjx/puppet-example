class pptp_yum_repo
{
	yumrepo
	{
		"pptp":
			descr => "CentOS-\$releasever - PPTP",
			baseurl => "$url_yum_mirror_pptp/yum/beta/rhel\$releasever/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$url_yum_mirror_pptp/yum/RPM-GPG-KEY-PPTP",
			enabled => 0,
	}
}
