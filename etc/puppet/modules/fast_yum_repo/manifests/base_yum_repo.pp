class base_yum_repo {
	yumrepo {
		"centos_base":
			descr => "CentOS-\$releasever - Base",
			baseurl => "$config::global::url_yum_mirror_base/centos/\$releasever/os/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$config::global::url_yum_mirror_base/centos/\$releasever/os/\$basearch/RPM-GPG-KEY-CentOS-\$releasever";

		"centos_updates":
			descr => "CentOS-\$releasever - Updates",
			baseurl => "$config::global::url_yum_mirror_base/centos/\$releasever/updates/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$config::global::url_yum_mirror_base/centos/\$releasever/os/\$basearch/RPM-GPG-KEY-CentOS-\$releasever";

		"centos_extras":
			descr => "CentOS-\$releasever - Extras",
			baseurl => "$config::global::url_yum_mirror_base/centos/\$releasever/extras/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$config::global::url_yum_mirror_base/centos/\$releasever/os/\$basearch/RPM-GPG-KEY-CentOS-\$releasever";

		"epel":
			descr => "CentOS-\$releasever - EPEL",
			baseurl => "$config::global::url_yum_mirror_epel/fedora-epel/\$releasever/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$config::global::url_yum_mirror_epel/fedora-epel/RPM-GPG-KEY-EPEL-\$releasever";

		"percona":
			descr => "CentOS-\$releasever - Percona",
			baseurl => "$config::global::url_yum_mirror_percona/centos/\$releasever/os/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$config::global::url_yum_mirror_percona_key/downloads/percona-release/RPM-GPG-KEY-percona",
			enabled => 0;

		"remi":
			descr => "CentOS-\$releasever - REMI",
			baseurl => "$config::global::url_yum_mirror_remi/enterprise/\$releasever/remi/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$config::global::url_yum_mirror_remi/RPM-GPG-KEY-remi",
			enabled => 0;

		"pptp":
			descr => "CentOS-\$releasever - PPTP",
			baseurl => "$config::global::url_yum_mirror_pptp/yum/beta/rhel\$releasever/\$basearch/",
			gpgcheck => 1,
			gpgkey => "$config::global::url_yum_mirror_pptp/yum/RPM-GPG-KEY-PPTP",
			enabled => 0;
	}
}
