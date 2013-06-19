class config::wan {
	$ip_add = "210.14.147.93"
	$gateway = "210.14.147.65"
	$prefix = "27"

	$opened_port = {
		ssh_1 => 22,
		ssh_2 => 2202,
		vnc_1 => 5901,
		vnc_2 => 5902,
		vpn => 1723,
		svn => 3690
	}
}
