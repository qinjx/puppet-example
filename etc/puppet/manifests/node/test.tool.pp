node /^test\d*\.tool/ inherits default {
	file {
		"/opt/src":
			ensure => directory;

		"/opt/src/fastdfs_auto_compiler.sh":
			source => "puppet:///files/node/test.tool/fastdfs_auto_compiler.sh";

		"/opt/src/php_fdfs_auto_compiler.sh":
			source => "puppet:///files/node/test.tool/php_fdfs_auto_compiler.sh";
	}

	package {
		["augeas", "rsync"]:
	}

	include role_internet_enduser, role_compiler
}
