node default {
	yum::repo::conf {
		["centos_base", "centos_updates", "centos_extras", "epel"]:
	}

	package {
		[
		"wget", "vim-enhanced", "rsync", "unzip", "cronie",
		"sysstat", "iftop",
		"augeas",
		]:
			require => [Yum::Repo::Conf["epel"], Yum::Repo::Conf["centos_base"]]
	}

	hosts::conf {
		$config::hosts::ip_keys:
	}

	file {
		"/root/init_scripts/":
			ensure => directory;

		"/root/init_scripts/conf.ini":
			require => File["/root/init_scripts/"];

		"/root/init_scripts/init.sh":
			source => "puppet:///files/default/init.sh";
	}

	augeas {
		"init_vm_config_ini":
			lens => "Shellvars.lns",
			incl => "/root/init_scripts/conf.ini",
			changes => [
				"set puppet_server $config::global::host_puppet_server",
				"set root_domain $config::global::root_domain_name"
			],
			require => File["/root/init_scripts/conf.ini"];
		"set_default_dns":
			context => "/files/etc/resolv.conf",
			changes => [
				"set nameserver 114.114.114.114"
			];
	}

	sysctl::conf {
		["net.bridge.bridge-nf-call-arptables", "net.bridge.bridge-nf-call-ip6tables", "net.bridge.bridge-nf-call-iptables"]:
			action => "rm";
		"fs.file-max":
			ensure => 204800;
		"kernel.threads-max":
			ensure => 204800;
	}

	limits::conf {
		"default_max_fd":
			domain => "*",
			type => "-",
			item => "nofile",
			value => 204800,
	}

	include ssh::server::install, ssh::server::service
}
