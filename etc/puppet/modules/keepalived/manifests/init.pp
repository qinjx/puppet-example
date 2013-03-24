# keepalived.pp
#
# $Id$

class keepalived (
  $email,
  $smtp_server = '127.0.0.1'
) {
    package {
        "keepalived":
            ensure => installed;
    }

    common::concatfilepart {
        "global_defs":
            ensure  => present,
            manage  => true,
            content => template("keepalived/global_defs.erb"),
            file    => "/etc/keepalived/keepalived.conf",
            require => Package["keepalived"];
    }

    service {
        "keepalived":
            ensure     => running,
            enable     => true,
            require    => Package["keepalived"],
            hasrestart => true,
            status     => 'pgrep keepalived',
            subscribe  => File["/etc/keepalived/keepalived.conf"];
    }
	
	iptables
	{
		"multicast":
			destination => "224.0.0.0/8",
			jump        => "ACCEPT",
	}
	
	iptables
	{
		"vrrp_input":
			proto       => "vrrp",
			chain		=> "INPUT",
			jump        => "ACCEPT",
	}
	
	iptables
	{
		"vrrp_output":
			proto       => "vrrp",
			chain		=> "OUTPUT",
			jump        => "ACCEPT",
	}
}
