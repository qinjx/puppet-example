#!/bin/bash
. ./func.inc.sh

echo "Please choose the role of this machine"
OPTIONS="Puppet-Master  Puppet-Client"
select opt in $OPTIONS; do
        if [ "$opt" = "Puppet-Master" ]; then
                install_master;
                exit
        elif [ "$opt" = "Puppet-Client" ]; then
                install_client;
                exit
        else
                echo "Bad option, please choose again"
        fi
done
