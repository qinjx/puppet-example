define nginx::conf::location($pattern, $fcgi_address) {
	file {
		"/etc/nginx/fastcgi_${name}.conf":
			content => "location ~ $pattern {

	fastcgi_param  SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;
	include fastcgi_params;
	fastcgi_pass $fcgi_address;
}",
			require => Package["nginx"],
			notify => Service["nginx"],
	}
}
