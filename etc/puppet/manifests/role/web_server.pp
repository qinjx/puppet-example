class role_web_server {
	iptables {
		"tcp_80_for_nginx":
			proto       => "tcp",
			dport       => "80",
			jump        => "ACCEPT",
	}

	include nginx
}

define web::server::site($www_root, $fcgi = null) {
	nginx::resource::vhost {
		$name:
			ensure   => present,
			www_root => $www_root,
	}

	if ($fcgi) {
		nginx::resource::location {
			"fcgi_for_${name}":
				location => "~ \\.php$",
				ensure => present,
				vhost  => $name,
				www_root => $www_root,
				fastcgi => $fcgi,
		}
	}
}