if versioncmp($::puppetversion,'3.6.1') >= 0 {
	$allow_virtual_packages = hiera('allow_virtual_packages',false)
	Package {
		allow_virtual => $allow_virtual_packages,
	}
}

# the global config
import "config/*.pp"

include config::yum
include config::global
include config::hosts
include config::web
include config::wan

# default values
File {
	ensure => present,
}

Package {
	ensure => installed,
}

Service {
	enable => true,
	ensure => running,
}

Exec {
	path => "/bin:/sbin:/usr/bin:/usr/sbin",
}
