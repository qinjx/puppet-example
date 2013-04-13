#!/bin/bash
. ./func.inc.sh

echo "Please choose the role of this machine"
options="Puppet-Master  Puppet-Client"
select opt in ${options}; do
	if [[ "${opt}" = "Puppet-Master" || "${opt}" = "Puppet-Client" ]]; then
		if [[ "OK" = prepare_yum_repo ]]; then
			if [ "${opt}" = "Puppet-Master" ]; then
				install_master
			elif [ "${opt}" = "Puppet-Client" ]; then
				install_client
			fi
		else
			echo yum mirror can\'t be connected
			exit
		fi
	else
		echo "Bad option, please choose again"
	fi
done
