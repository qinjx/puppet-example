define nginx::conf::vhost($www_root, $fcgi_conf = nil) {
	$domain_name = $name
	if ($fcgi_conf == nil) {
		$fcgi_conf_string = ""
	} else {
		$fcgi_conf_string = "include fastcgi_${fcgi_conf}.conf;"
	}

	file {
		"/etc/nginx/conf.d/vhost_${domain_name}.conf":
			content => "
server {
	listen *;
	server_name $domain_name;
	root $www_root;
	access_log /var/log/nginx/${domain_name}.access.log;

	location / {
		index index.html index.htm index.php;
	}
	
	$fcgi_conf_string
}",
			require => Package["nginx"],
		    notify => Service["nginx"],
	}
}
