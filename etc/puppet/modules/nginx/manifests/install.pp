class nginx::install {
	package {
		"nginx":
	}

	firewall::filter::allow {
		"80":
	}

	exec {
		"enable_gzip_by_default":
			command => "sed -i \"s/#gzip/gzip/\" /etc/nginx/nginx.conf",
			require => Package["nginx"],
	}
}
