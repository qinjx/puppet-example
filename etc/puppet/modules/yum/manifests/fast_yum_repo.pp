class fast_yum_repo
{
	yumrepo
	{
		"centos_base":
			descr => "CentOS-\$releasever - Base",
			baseurl => "$url_yum_mirror_base/centos/\$releasever/os/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$url_yum_mirror_base/centos/\$releasever/os/\$basearch/RPM-GPG-KEY-CentOS-\$releasever",
	}

	yumrepo
	{
		"centos_updates":
			descr => "CentOS-\$releasever - Updates",
			baseurl => "$url_yum_mirror_base/centos/\$releasever/updates/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$url_yum_mirror_base/centos/\$releasever/os/\$basearch/RPM-GPG-KEY-CentOS-\$releasever",
	}

	yumrepo
	{
		"centos_extras":
			descr => "CentOS-\$releasever - Extras",
			baseurl => "$url_yum_mirror_base/centos/\$releasever/extras/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$url_yum_mirror_base/centos/\$releasever/os/\$basearch/RPM-GPG-KEY-CentOS-\$releasever",
	}

	yumrepo
	{
		"epel":
			descr => "CentOS-\$releasever - EPEL",
			baseurl => "$url_yum_mirror_epel/fedora-epel/\$releasever/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$url_yum_mirror_epel/fedora-epel/RPM-GPG-KEY-EPEL-\$releasever",
	}
}
