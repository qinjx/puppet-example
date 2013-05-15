class config::global {
	$ip_prefix = "10.250.0"
	
	$root_domain_name = "example.com"
	$host_puppet_server = "puppet-server.vip.$root_domain_name"
	
	$local_yum_mirror_prefix = "yum-mirror.vip.$root_domain_name/"
	
	$url_yum_mirror_base = "http://${local_yum_mirror_prefix}mirrors.sohu.com"
	$url_yum_mirror_epel = "http://${local_yum_mirror_prefix}mirrors.sohu.com"
	$url_yum_mirror_remi = "http://${local_yum_mirror_prefix}rpms.famillecollet.com"
	$url_yum_mirror_percona = "http://${local_yum_mirror_prefix}repo.percona.com"
	$url_yum_mirror_percona_key = "http://${local_yum_mirror_prefix}www.percona.com"
	$url_yum_mirror_pptp = "http://${local_yum_mirror_prefix}poptop.sourceforge.net"
}

