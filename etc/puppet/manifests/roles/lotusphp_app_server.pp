class role_lotusphp_app_server
{
	$www_root = "$php_project_root/web_entrance/$app_name"

	file
	{
		"/root/${app_name}-up.sh":
			content => "#!/bin/sh
rm $php_project_root/web_entrance/$app_name/status.txt
echo 'waiting for load balancer check my status...'
sleep 3

rm -rf $php_project_root/*
mkdir -p $php_project_root/app $php_project_root/cache $php_project_root/web_entrance
chown apache.apache -R $php_project_root/cache
chmod 766 -R $php_project_root/cache

mkdir -p /tmp/$app_name
mount nfs.vip:/opt/nfs/php_from_svn /tmp/$app_name
rsync -rp --exclude=.svn /tmp/$app_name/lotusphp /var/www/
rsync -rp --exclude=.svn /tmp/$app_name/hkec/{conf,lib,view} $php_project_root/
rsync -rp --exclude=.svn /tmp/$app_name/hkec/app/$app_name $php_project_root/app/
rsync -rp --exclude=.svn /tmp/$app_name/hkec/web_entrance/$app_name $php_project_root/web_entrance/

umount nfs.vip:/opt/nfs/php_from_svn
rm -rf /tmp/$app_name

#enable devMode
sed -i -e 's/devMode\\s*=\\s*\\S*;/devMode = false;/' $php_project_root/web_entrance/$app_name/index.php
sed -i -e 's/root/php/' $php_project_root/conf/standard/db.conf.php

#sh gen_index_html.sh

echo 'please run the following command after testing:

touch $php_project_root/web_entrance/$app_name/status.txt'
#the end";

		"/root/gen_index_html.sh":
			content => "#!/bin/sh
curl http://localhost/index.php -o $php_project_root/web_entrance/$app_name/index.html
#the end";
	}
	
	cron
	{
		"autogen_index_html":
			command => "/bin/sh /root/gen_index_html.sh",
			minute => "*/5",
			ensure => "absent",
	}

	file
	{
		"$php_project_root/web_entrance/$app_name/index.html":
			 ensure => "absent",	
	}

	if ($domain =~ /raw/)
	{
		exec
		{
			"${app_name}-up.sh":
				command => "/bin/sh -p /root/${app_name}-up.sh",
				require => File["/root/${app_name}-up.sh"],
		}
	}

	nginx::resource::vhost {
		"$app_name.$root_domain_name_public":
			ensure   => present,
			www_root => $www_root,
	}

	nginx::resource::location {
		"php_fcgi":
			location => "~ \\.php$",
			ensure => present,
			vhost  => "$app_name.$root_domain_name_public",
			www_root => $www_root,
			fastcgi => "127.0.0.1:9000"
	}
}

