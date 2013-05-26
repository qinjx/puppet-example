define nginx::conf::location($file_pattern, $fcgi_address) {
	file {
		"/etc/nginx/conf.d/${name}.conf":
		    content => "
location ~ $file_pattern {
	include fastcgi.conf;
	fastcgi_pass $fcgi_address
}",
	}
}