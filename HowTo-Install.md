Puppet安装方法（服务端客户端通用）
=============================
__兼容性说明__

- 这个脚本是在CentOS 6上编写和测试的，完全兼容RHEL 6
- CentOS/RHEL 5, Fedora应该也可以使用，但我没测试过
- 不支持Debian家族（含Debian、Ubuntu），因为脚本依赖yum
- 不支持Mac OS，因为mac是BSD家族，没有yum，sed, rm等命令的语法也不一样


## Step 1. 装个Linux系统
从vm模板clone一个虚拟机，或者新装的centos都可以，最小化安装即可。

最小化安装的CentOS/RHEL默认会有yum, vi, curl这些工具。


## Step 2. 连接互联网
通常只有办公环境才有DHCP服务器自动给你分配IP，IDC环境一般没有DHCP的，需要按如下步骤设置IP地址/网关/DNS，使之可以访问互联网。

### Step 2.1 设置IP和子网掩码：
如果你的环境支持复制粘贴（如XenCenter管理XCP、XenServer就可以在console里粘贴复制），可以复制下面的代码并招待，记得把IP地址改成你自己的。

如果你的环境不支持复制粘贴（大部分VNC客户端都不支持的），只好自己用vi去编辑了。

	echo "DEVICE="eth0"
	NM_CONTROLLED="yes"
	ONBOOT="yes"
	BOOTPROTO="static"
	IPADDR=10.250.0.221 #此处改成你的IP
	NETMASK=255.255.255.0" > /etc/sysconfig/network-scripts/ifcfg-eth0;

### Step 2.2 设置网关：
仅仅设置IP和子网掩码只能访问这台机器所在的子网，不能访问互联网，需要设置网关，由网关来将数据包转发到子网外面的世界：

	echo "NETWORKING=yes
	HOSTNAME=centos_raw
	GATEWAY=10.250.0.254" > /etc/sysconfig/network

### Step 2.3 添加DNS：
可以使用Google提供的DNS服务器：

	echo "nameserver 8.8.8.8
	nameserver 8.8.4.4" > /etc/resolv.conf

### Step 2.4 重启网络：
	/etc/init.d/network restart

### Step 2.5 验证是否可以访问互联网：
Ping一下github试试：

	ping github.com


## Step 3. 用curl从github上下载安装脚本
只需要下载install.sh和func.inc.sh

	curl https://raw.github.com/qinjx/puppet-example/master/install_scripts/func.inc.sh -o func.inc.sh
	curl https://raw.github.com/qinjx/puppet-example/master/install_scripts/install.sh -o install.sh
	

## Step 4. 执行安装脚本install.sh
执行：
	
	sh install.sh

脚本会询问你，想把这个机器安装为puppet server，还是puppet client，输入数字1或者2来选择，然后按照脚本提示往下做，填写必要的设置即可安装成功