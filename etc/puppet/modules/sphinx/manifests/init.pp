class sphinx (
	$sphinx_rpm_url = "http://sphinxsearch.com/files/sphinx-2.0.4-1.rhel6.x86_64.rpm"
) {
	package
	{
		["Percona-Server-shared-compat", "postgresql-libs"]:
			ensure => present,
			require => Yumrepo["centos_updates", "percona"],
	}

	package
	{
		"sphinx":
			ensure => present,
			require => Package["Percona-Server-shared-compat", "postgresql-libs"],
			provider => "rpm",
			source => $sphinx_rpm_url,
	}

	exec
	{
		"build_index":
			command => "/usr/bin/indexer --rotate --all",
			require => File["/etc/sphinx/sphinx.conf"],
	}
	
	iptables
	{
		"sphinx_9312":
			proto       => "tcp",
			dport       => "9312",
			jump        => "ACCEPT",
	}
}
