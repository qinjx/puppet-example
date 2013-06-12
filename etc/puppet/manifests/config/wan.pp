class config::wan {
	$ip_add = "210.14.147.93"
	$gateway = "210.14.147.65"
	$prefix = "27"

	$opened_port = {
		ssh_1 => 22,
		ssh_2 => 2202,
		vpn_1 => 1723,
		vpn_2 => 1724,
		vnc_1 => 5901,
		vnc_2 => 5902,
		svn => 3690
	}
}
