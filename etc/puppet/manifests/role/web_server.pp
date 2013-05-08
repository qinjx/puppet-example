class role_web_server {
	#include nginx

	iptables {
		"tcp_80":
			proto       => "tcp",
			dport       => "80",
			jump        => "ACCEPT",
	}
}
