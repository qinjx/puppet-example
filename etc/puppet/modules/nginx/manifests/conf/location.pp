define nginx::conf::location($pattern, $fcgi_address) {
	file {
		"/etc/nginx/fastcgi_${name}.conf":
			content => "location ~ $pattern {
	include fastcgi_params;
	fastcgi_pass $fcgi_address;
}",
			require => Package["nginx"],
			notify => Service["nginx"],
	}
}
