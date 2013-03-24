$ip_prefix = "10.250.0"

############################## Domain name config start ##############################
#use for LAN, can be a fake domain
$root_domain_name="example.com"

#use for WAN, must be a true domain that end user can resolve it
$root_domain_name_public = "kinhom.com" 
##############################  Domain name config end  ##############################


############################## puppet server config start ##############################
#don't use short domain name here, it must be an FQDN
$host_puppet_server = "puppet-server.vip.$root_domain_name"
$host_puppet_server_ip = "$ip_prefix.10"
##############################  puppet server config end  ##############################


############################## yum mirror url config start ##############################
# if you dont't have local yum mirror, please don't change this setting section
$host_yum_mirror = "yum-mirror.vip.$root_domain_name"
$host_yum_mirror_ip = "$ip_prefix.11"
$use_local_yum_mirror = 0

if ($use_local_yum_mirror == 1) {
	if ($domain =~ /raw/) {
		$url_yum_mirror_prefix = "http://$host_yum_mirror_ip/"
	} else {
		$url_yum_mirror_prefix = "http://$host_yum_mirror/"
	}
} else {
	$url_yum_mirror_prefix = "http://"
}

$url_yum_mirror_base = "${url_yum_mirror_prefix}mirrors.sohu.com"
$url_yum_mirror_epel = "${url_yum_mirror_prefix}mirrors.sohu.com"
$url_yum_mirror_remi = "${url_yum_mirror_prefix}rpms.famillecollet.com"
$url_yum_mirror_percona = "${url_yum_mirror_prefix}repo.percona.com"
$url_yum_mirror_percona_key = "${url_yum_mirror_prefix}www.percona.com"
$url_yum_mirror_pptp = "${url_yum_mirror_prefix}poptop.sourceforge.net"
##############################  yum mirror url config end  ##############################

############################## php application config start ##############################
$php_project_root = "/var/www/hkec"
$svn_root = "svn://svn.$root_domain_name/hkec/trunk"
$lotusphp_root = "/var/www/lotusphp"
##############################  php application config end  ##############################