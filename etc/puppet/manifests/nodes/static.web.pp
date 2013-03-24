node /^static\d*\.web/ inherits default {
	$app_name = "static"
	$www_root = "$php_project_root/$app_name"
	include role_web_server

	file
	{
		"/root/${app_name}-up.sh":
			content => "#!/bin/sh
rm $www_root/status.txt
echo 'waiting for load balancer check my status...'
sleep 3

mkdir -p $www_root
mkdir -p /tmp/$app_name
mount nfs.vip:/opt/nfs/php_from_svn/hkec/$app_name /tmp/$app_name
rsync -rp /tmp/$app_name/* $www_root
umount nfs.vip:/opt/nfs/php_from_svn/hkec/$app_name
rm -rf /tmp/$app_name

echo 'please run the following command after testing:

touch $www_root/status.txt'
#the end";
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
		"$app_name.jjcdn.com":
			ensure   => present,
			www_root => $www_root,
	}
}
