node /^sys\d*\.wan\.lb/ inherits default {
	keepalived::vrrp::instance {
		"${config::hosts::ip_list[sys_wan_lb_vip]}":
			vip_add => "${config::global::ip_prefix}.${config::hosts::ip_list[sys_wan_lb_vip]}/24",
	}

	yum::repo::conf {
		"pptp":
	}

	ssh::server::conf {
		"PermitRootLogin":
		    ensure => no,
	}

	augeas {
		"sshd_listen_all":
			context => "/files/etc/ssh/sshd_config",
			changes => "rm ListenAddress",
			require => Class["ssh::server::install"],
	}

	include role_vip_holder, role_pptp_server
}
