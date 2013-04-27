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
			install_master $1
			exit
		;;

		"Install-Puppet-Client" )
			install_client $1
			exit
		;;

		"Config-Puppet-Server" )
			config_puppet_master
			exit
		;;

		"Config-Puppet-Client" )
			config_puppet_client
			exit
		;;

		"Exit" )
			exit
		;;

		* ) echo "Bad option, please choose again"
	esac
done
