class config::hosts {
	define set($ip) {
		host {
			$name:
				ip => "$config::global::ip_prefix.$ip",
				name => "$name.$config::global::root_domain_name",
				host_aliases => [$name],
		}
	}
}

config::hosts::set {
	"wan.gw.vip": ip => "254";
	"dns.vip": ip => "250";
	"vpn.gw.vip": ip => "253";
	"sys.wan.lb.vip": ip => "1";
	"user.wan.lb.vip": ip => "2";
	"puppet-server.sys.vip": ip => "10";
	"yum-mirror.sys.vip": ip => "11";
	"nfs.sys.vip": ip => "12";
	"ntp.sys.vip": ip => "13";
	"svn.sys.vip": ip => "14";
	"puppet-server1.sys": ip => "21";
	"puppet-server2.sys": ip => "22";
	"yum-mirror1.sys": ip => "23";
	"yum-mirror2.sys": ip => "24";
	"dns1.sys": ip => "27";
	"dns2.sys": ip => "28";
	"nfs1.sys": ip => "29";
	"nfs2.sys": ip => "30";
	"ntp1.sys": ip => "31";
	"ntp2.sys": ip => "32";
	"svn1.sys": ip => "33";
	"svn2.sys": ip => "34";
	"shop.db.vip": ip => "50";
	"tracker.dfs.vip": ip => "50";
	"shop.se.vip": ip => "50";
	"php.app.vip": ip => "50";
	"acp-php.app.vip": ip => "50";
	"shop1.db": ip => "51";
	"shop2.db": ip => "52";
	"shop3.db": ip => "53";
	"shop1.se": ip => "54";
	"shop2.se": ip => "55";
	"shop3.se": ip => "56";
	"storage1.dfs": ip => "57";
	"storage2.dfs": ip => "58";
	"storage3.dfs": ip => "59";
	"tracker1.dfs": ip => "60";
	"tracker2.dfs": ip => "61";
	"tracker3.dfs": ip => "62";
	"nginx1.web": ip => "101";
	"nginx2.web": ip => "102";
	"nginx3.web": ip => "103";
	"php1.app": ip => "111";
	"php2.app": ip => "112";
	"php3.app": ip => "113";
	"acp-php1.app": ip => "114";
	"acp-php2.app": ip => "115";
	"acp-php3.app": ip => "116";
	"sys1.wan.lb": ip => "200";
	"sys2.wan.lb": ip => "201";
	"user1.wan.lb": ip => "202";
	"user2.wan.lb": ip => "203";
	"dhcp1.sys": ip => "204";
	"dhcp2.sys": ip => "205";
	"lan1.lb": ip => "206";
	"lan2.lb": ip => "207";
	"centos0.vmtpl": ip => "208";
	"centos1.vmtpl": ip => "209";
	"centos2.vmtpl": ip => "210";
	"centos3.vmtpl": ip => "211";
	"compiler.tool": ip => "217";
	"test.tool": ip => "218";
	"vpn1.gw": ip => "219";
	"vpn2.gw": ip => "220";
	"wan1.gw": ip => "221";
	"wan2.gw": ip => "222";
}
