puppet-example
==============

这是一个puppet示范项目，兼作我的运维学习笔记，在现实世界运行着，有三个成功案例，各管理100多台服务器，都是小型B2C网站，这些网站的架构大致如下图（图是网站上线前设计的，实际实施有所变化）：

![puppet-example项目成功案例服务器拓扑图](http://ww1.sinaimg.cn/large/6a174839gw1dsp0ptypt4j.jpg "小型B2C网站服务器架构")

[出处：我的微博@qinjianxiang](http://photo.weibo.com/1779910713/wbphotos/large/photo_id/3442830834329049)

我花了约100小时学习这些服务器配置，反复试错，并编写成puppet脚本和bash shell脚本，故本项目只能保证正常运行和基本的性能与安全，没有涉及这些服务器的高级技巧。

## 功能范围

### 已实现的功能模块
- compiler：编译工具
- coreseek：中文版的sphinx
- fastdfs：分布式文件系统
- firewall
	- filter：iptables防火墙
	- nat：端口转发
- gateway：网关（iptables实现）
- haproxy：负载均衡器
- hhvm：Facebook开源出来的高性能PHP引擎
- hosts：/etc/hosts配置工具
- inifile：ini配置文件操作工具（第三方开源）
- iptables：iptables规则配置工具（第三方开源）
- java：openjdk
- keepalived：高可用方案，IP共享（使用VRRP协议）
- limits：控制/etc/security/limits.conf文件
- memcached：高性能内存缓存服务器
- mongodb：NoSQL，面向文档的数据库
- mysql：MySQL服务器
- nfs：
	- nfs服务端，export
	- nfs客户端，mount
- nginx：高性能的Web服务器
- ntp：时间服务器和客户端
- percona：Percona over Galera，多主同步复制MySQL集群
- php：PHP语言环境（php-fpm和cli）
- pptp
	- VPN服务端：pptpd
	- 客户端：ppp（未实现）
- puppet
	- master：puppet服务端
	- client：客户端
- redis：高性能内存NoSQL
- rsyslog：日志服务器
- sphinx：实现的搜索引擎（独立于MySQL）
- ssh：SSH服务端
- svn：svn代码仓库服务器
- sysctl：控制/etc/sysctl.conf文件
- virtmanager：虚拟机管理工具
- vnc：VNC远程桌面服务端
- yum：yum源管理和本地yum镜像搭建工具

### yum源
- centos：centos官方源的sohu镜像，含base、updates、extras
- epel：fedora-epel源，提供nginx, puppet, haproxy, keepalived等绝大部分软件包
- remi：PHP 5.4源（CentOS和epel源的PHP版本都较低，分别是5.1和5.2，没有内建php-fpm）
- percona：percona mysql cluster源
- pptp：pptpd和pptp源
- nginx：nginx官方源（epel上的nginx版本较低，为1.0.15）
- hop5：非facebook官方的hhvm源
- puppetlabs：puppet官方源


## 安装说明
### clone centos vm时应注意的网络配置问题
在XEN和KVM平台，clone一台VM时，新克隆出来的vm，eth0会变成eth1，新克隆出来的vm，eth0由于mac地址冲突已经不能用了，自动生成了个eth1，而ifcfg-eth0配置文件仍然存在，只是不起作用了，要避免这种情况，需这样克隆：

- 启动要克隆的模板vm
- 删除/etc/udev/rules.d/70-persistent-net.rules，这个文件会在每次启动的时候自动生成，最好配个crontab定时删除
- 打开网卡配置文件（如/etc/sysconfig/network-scripts/ifcfg-eth0）
- 删除网上配置文件中的HWADDR那一行，删除它也能正常工作
- 确保ONBOOT=YES，若保留默认值NO，使用service network restart时会关闭这个网卡，但并不自动启动这个网卡
- 关闭模板vm
- 克隆

除CentOS外，其它的linux发行版应该也有这个问题，解决方法也是类似的。我验证过的只有Debian，但这是linux kernel的机制决定的，跟发行版关系不大，发行版不同，只是配置文件语法不同。

*** 更新 ***
这是我2012年发现的问题，当时我使用的是XCP和Promox VE。后来Ctrix把它的XenServer开源了，经测试，XenServer 6.2上安装CentOS 6.4，没有这个问题了。

### 从CentOS裸机安装puppet
参见[puppet安装说明文档](HowTo-Install.md)，包括puppet server和puppet client安装。

### 在puppet服务器使用本项目
参见[puppet-example使用文档](HowTo-Use.md)，包括单机模式和Client/Server模式的使用方法。


## 架构
开发本项目的第一版时，我初学puppet，虽然也用到了role，module，config来将我的代码分层，但分层执行不够彻底，抽象得还不够，坏处就是影响项目的通用性。

我重新梳理后的架构，分为五层：config - node - role - module type - module provider，越往右，通用性越强。使用本项目的用户，主要会去修改config和node两层，role层较少修改，module type和module provider层几乎不用修改，如果发现这两层满足不了需求，可以提需求给我，我来改。

![架构图](http://ww3.sinaimg.cn/large/6a174839gw1e3rbunqjlrj.jpg "代码架构图")
