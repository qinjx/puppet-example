class role_web_server {
	#include nginx

	iptables {
		"tcp_80_for_nginx":
			proto       => "tcp",
			dport       => "80",
			jump        => "ACCEPT",
	}
}
