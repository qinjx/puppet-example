define nginx::conf::location($pattern, $fcgi_address) {
	file {
		"/etc/nginx/fastcgi_${name}.conf":
			content => "location ~ $pattern {
	include fastcgi.conf;
	fastcgi_pass $fcgi_address;
}",
			require => Package["nginx"],
			notify => Service["nginx"],
	}
}
