define nginx::conf::vhost($www_root, $fcgi_conf = nil, $server_name = nil, $extra_conf = nil) {
	if ($server_name == nil) {
		$server_name_string = $name
	} else {
		$server_name_string = $server_name
	}

	if ($fcgi_conf == nil) {
		$fcgi_conf_string = ""
	} else {
		$fcgi_conf_string = "include fastcgi_${fcgi_conf}.conf;"
	}

	if ($extra_conf == nil) {
		$extra_conf_string = ""
	} else {
		$extra_conf_string = $extra_conf
	}

	file {
		"/etc/nginx/conf.d/vhost_${name}.conf":
			content => "
server {
	listen *;
	server_name $server_name_string;
	root $www_root;
	access_log /var/log/nginx/${name}.access.log;
	error_log /var/log/nginx/${name}.error.log;

	location / {
		index index.html index.htm index.php;
	}
	
	$fcgi_conf_string
	
	$extra_conf_string
}",
			require => Package["nginx"],
			notify => Service["nginx"],
	}
}
