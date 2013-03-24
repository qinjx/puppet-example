class percona_yum_repo
{
	yumrepo
	{
		"percona":
			descr => "CentOS-\$releasever - Percona",
			baseurl => "$url_yum_mirror_percona/centos/\$releasever/os/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$url_yum_mirror_percona_key/downloads/percona-release/RPM-GPG-KEY-percona",
			enabled => 0,
	}
}
