node /^compiler\d*\.tool/ inherits default {
	include role_compiler
	
	file
	{
		"/root/fastdfs_auto_compiler.sh":
			source => "puppet:///node_files/compiler.tool/fastdfs_auto_compiler.sh",
			mode => 755,
	}
	
	file
	{
		"/root/nginx_auto_compiler.sh":
			source => "puppet:///node_files/compiler.tool/nginx_auto_compiler.sh",
			mode => 755,
	}
	
	file
	{
		"/etc/init.d/nginx":
			source => "puppet:///node_files/compiler.tool/init.d/nginx",
			mode => 755,
	}

	yum::repo::switcher
	{
		"php":
			ensure => disabled;
		"percona":
			ensure => disabled;
	}
}