class config::hosts {
	define set($ip) {
		host {
			$ip:
				ip => "$config::global::ip_prefix.$ip",
				name => "$name.$config::global::root_domain_name",
				host_aliases => [$name],
		}
	}
}

config::hosts::set {
	"internet-gateway": ip => "254";
	"dns.vip": ip => "250";
	"vpn-gateway.vip": ip => "253";
	"sys.wan.lb.vip": ip => "1";
	"user.wan.lb.vip": ip => "2";
	"puppet-server.vip": ip => "10";
	"yum-mirror.vip": ip => "11";
	"nfs.vip": ip => "12";
	"ntp.vip": ip => "13";
	"svn.vip": ip => "14";
	"puppet-server1": ip => "21";
	"puppet-server2": ip => "22";
	"yum-mirror1": ip => "23";
	"yum-mirror2": ip => "24";
	"file-server1": ip => "25";
	"file-server2": ip => "26";
	"dns1": ip => "27";
	"dns2": ip => "28";
	"nfs1": ip => "29";
	"nfs2": ip => "30";
	"ntp1": ip => "31";
	"ntp2": ip => "32";
	"svn1": ip => "33";
	"svn2": ip => "34";
	"shop.db.vip": ip => "50";
	"tracker.dfs.vip": ip => "50";
	"shop.se.vip": ip => "50";
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
	"dhcp1": ip => "204";
	"dhcp2": ip => "205";
	"lan1.lb": ip => "206";
	"lan2.lb": ip => "207";
	"centos0.vmtpl": ip => "208";
	"centos1.vmtpl": ip => "209";
	"centos2.vmtpl": ip => "210";
	"centos3.vmtpl": ip => "211";
	"compiler.tool": ip => "217";
	"sb.test": ip => "218";
	"vpn-gateway1": ip => "219";
	"vpn-gateway2": ip => "220";
}
