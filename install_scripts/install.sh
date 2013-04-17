#!/bin/bash
. ./func.inc.sh

echo "Please choose the task"
options="Install-Puppet-Server
Install-Puppet-Client
Config-Puppet-Server
Config-Puppet-Client
Exit"
select opt in ${options}; do
	case "${opt}" in
		"Install-Puppet-Server" )
			install_master
			config_puppet_master
		;;

		"Install-Puppet-Client" )
			install_client
			config_puppet_client
		;;

		"Config-Puppet-Server" )
			config_puppet_master
		;;

		"Config-Puppet-Client" )
			config_puppet_client
		;;

		"Exit" )
			exit

		* ) echo "Bad option, please choose again"
	esac
done
