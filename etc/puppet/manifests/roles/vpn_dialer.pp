class role_vpn_dialer
{
	include pptp

	file
	{
		"/root/vpn_dial.sh":
			source => "puppet:///node_files/vpn-gateway/vpn_dial.sh",
			mode => 755,
	}
}
