node /^mysql\d*\.db/ inherits default {
	$serverId = regsubst($hostname, 'mysql', '', 'G')
	mysql::server::conf {
		# 这是双核8G的配置，如果配置更高，不应该直接翻倍
		# 配置建议参见：http://www.mysqlperformanceblog.com/2014/01/28/10-mysql-settings-to-tune-after-installation/
		"innodb_buffer_pool_size":
			ensure => "6G";
		"innodb_log_file_size":
			ensure => "512M";
		"max_connections":
			ensure => "2560";
		"innodb_flush_method":
			ensure => "O_DIRECT";
		"query_cache_size":
			ensure => "1G";
		"log_bin":#要同时指定server_id
			ensure => "ON";
		"server_id":
			ensure => $serverId;
	}

	yum::repo::conf {
		"mysql":
	}
	
	include mysql::server::install, mysql::server::service
}
