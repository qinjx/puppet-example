Puppet安装方法（服务端客户端通用）
=============================
__兼容性说明__

- 这个脚本是在CentOS 6上编写和测试的，完全兼容RHEL 6
- CentOS/RHEL 5, Fedora应该也可以使用，但我没测试过
- 不支持Debian家族（含Debian、Ubuntu），因为脚本依赖yum
- 不支持Mac OS，因为mac是BSD家族，没有yum。mac上的sed, rm等命令的语法也跟linux不一样


## Step 1. 装个Linux系统
从vm模板clone一个虚拟机，或者新装的centos都可以，最小化安装即可。

最小化安装的CentOS/RHEL默认会有yum, vi, curl这些工具。


## Step 2. 连接互联网
通常只有办公环境才有DHCP服务器自动给你分配IP，IDC环境一般没有DHCP的，需要按如下步骤设置IP地址/网关/DNS，使之可以访问互联网。

### Step 2.1 设置IP和子网掩码：
如果你的环境支持复制粘贴（如XenCenter就可以在console里粘贴复制），可以复制下面的代码并执行，记得把IP地址改成你自己的。

如果你的环境不支持复制粘贴（大部分VNC客户端都不支持的），只好自己用vi去编辑了。

	echo 'DEVICE="eth0"
	ONBOOT="yes"
	BOOTPROTO="static"
	IPADDR=10.250.0.221 #此处改成你的IP
	PREFIX=24' > /etc/sysconfig/network-scripts/ifcfg-eth0;

### Step 2.2 设置网关：
仅仅设置IP和子网掩码只能访问这台机器所在的子网，不能访问互联网，需要设置网关，由网关来将数据包转发到子网外面的世界：

	echo "NETWORKING=yes
	HOSTNAME=centos_raw
	GATEWAY=10.250.0.254 #此处改成你的网关IP" > /etc/sysconfig/network

### Step 2.3 添加DNS：
可以使用Google提供的DNS服务器：

	echo "nameserver 114.114.114.114
	nameserver 8.8.4.4" > /etc/resolv.conf

### Step 2.4 重启网络：
	/etc/init.d/network restart

### Step 2.5 验证是否可以访问互联网：
Ping一下github试试：

	ping github.com


## Step 3. 下载安装脚本
只需要下载install.sh和func.inc.sh

	curl https://raw.github.com/qinjx/puppet-example/master/install_scripts/func.inc.sh -o func.inc.sh
	curl https://raw.github.com/qinjx/puppet-example/master/install_scripts/install.sh -o install.sh
	

## Step 4. 执行安装脚本
执行：
	
	sh install.sh

脚本会询问你，想把这个机器安装为puppet server，还是puppet client，输入数字来选择，然后按照脚本提示往下做，填写必要的设置即可安装成功。

### 4.1 Install 和 Config的区别
- Install-Puppet-Master/Client是先用yum装包，再调用Config-Puppet-Master/Client。yum执行时间稍长，适合第一次安装
- Config-Puppet-Master/Client是只是对puppet的配置文件、iptables防火墙做一些配置，不包括yum装包过程，执行速度非常快。如果你只想更改一些配置，选这个合适

## Step 5. 验证安装是否成功
在puppet client机器上执行：

	puppetd -t

### 5.1 如果安装成功
看到下面这样的输出就说明master和client都安装成功了(在终端下是绿色字)：

	[root@vnc1 qinjx]# puppetd -t
	info: Retrieving plugin
	info: Caching catalog for vnc1.sys.example.com
	info: Applying configuration version '1375365926'
	notice: Finished catalog run in 0.03 seconds
	
### 5.2 如果安装失败
看到下面这样的输出，就说明安装失败了（在终端下是红色字）：

	[root@vnc1 qinjx]# puppetd -t
	info: Retrieving plugin
	err: /File[/var/lib/puppet/lib]: Failed to generate additional resources using 'eval_generate': Connection refused - connect(2)
	err: /File[/var/lib/puppet/lib]: Could not evaluate: Connection refused - connect(2) Could not retrieve file metadata for puppet://puppet-server.vip.example.com/plugins: Connection refused - connect(2)
	err: Could not retrieve catalog from remote server: Connection refused - connect(2)
	warning: Not using cache on failed catalog
	err: Could not retrieve catalog; skipping run
