#!/bin/sh
domain=$1
puppet_conf_root="/etc/puppet"
echo "*.$1" > "$puppet_conf_root/autosign.conf"
cp ./conf_tpl/auth.conf $puppet_conf_root
sed -e "s/allow .*$/allow \*\.$domain/" ./conf_tpl/fileserver.conf > "$puppet_conf_root/fileserver.conf"
sed -e "s/root_domain_name *= *\".*\"/root_domain_name=\"$domain\"/" ./conf_tpl/config.pp > "$puppet_conf_root/manifests/config.pp"
