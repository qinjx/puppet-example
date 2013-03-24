class role_vpn_server
{
	include pptpd
	if ($domain =~ /raw/)
	{
		exec
		{
			"pptpd_config":
				command => '/bin/echo "ms-dns 8.8.8.8" >> /etc/ppp/options.pptpd',
				require => Package["pptpd"],
		}

		exec
		{
			"enable_ip_forward_now_for_vpn_server":
				command => "/bin/echo 1 > /proc/sys/net/ipv4/ip_forward",
		}
	}
}