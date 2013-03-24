######################### hosts RegEx start #########################
#find:
#	^(\d+\.\d+\.\d+\.\d+)\s+(\S+)$
#replace with:
#	host {"host_\1_\2": ip => "\1", name => "\2.$root_domain_name", host_aliases => ["\2"]}
#Note: this regex is used for crimson editor, for eclipse, replace "\1" "\2" with "$1" "$2"
#########################  hosts RegEx end  #########################


######################### most important hosts start #########################	
host {
	"localhost":
		ip => "127.0.0.1",
		name => "localhost";
	"puppet_server":
		ip => $host_puppet_server_ip,
		name => $host_puppet_server;
	"yum_mirror":
		ip => $host_yum_mirror_ip,
		name => $host_yum_mirror,
}
######################### most important hosts start #########################
host {"host_$ip_prefix.254_internet-gateway": ip => "$ip_prefix.254", name => "internet-gateway.$root_domain_name", host_aliases => ["internet-gateway"]}
host {"host_$ip_prefix.250_dns.vip": ip => "$ip_prefix.250", name => "dns.vip.$root_domain_name", host_aliases => ["dns.vip"]}
host {"host_$ip_prefix.253_vpn-gateway.vip": ip => "$ip_prefix.253", name => "vpn-gateway.vip.$root_domain_name", host_aliases => ["vpn-gateway.vip"]}
host {"host_$ip_prefix.1_sys.wan.lb.vip": ip => "$ip_prefix.1", name => "sys.wan.lb.vip.$root_domain_name", host_aliases => ["sys.wan.lb.vip"]}
host {"host_$ip_prefix.2_user.wan.lb.vip": ip => "$ip_prefix.2", name => "user.wan.lb.vip.$root_domain_name", host_aliases => ["user.wan.lb.vip"]}
host {"host_$ip_prefix.12_nfs.vip": ip => "$ip_prefix.12", name => "nfs.vip.$root_domain_name", host_aliases => ["nfs.vip"]}
host {"host_$ip_prefix.13_ntp.vip": ip => "$ip_prefix.13", name => "ntp.vip.$root_domain_name", host_aliases => ["ntp.vip"]}
host {"host_$ip_prefix.14_svn.vip": ip => "$ip_prefix.14", name => "svn.vip.$root_domain_name", host_aliases => ["svn.vip"]}
host {"host_$ip_prefix.21_puppet-server1": ip => "$ip_prefix.21", name => "puppet-server1.$root_domain_name", host_aliases => ["puppet-server1"]}
host {"host_$ip_prefix.22_puppet-server2": ip => "$ip_prefix.22", name => "puppet-server2.$root_domain_name", host_aliases => ["puppet-server2"]}
host {"host_$ip_prefix.23_yum-mirror1": ip => "$ip_prefix.23", name => "yum-mirror1.$root_domain_name", host_aliases => ["yum-mirror1"]}
host {"host_$ip_prefix.24_yum-mirror2": ip => "$ip_prefix.24", name => "yum-mirror2.$root_domain_name", host_aliases => ["yum-mirror2"]}
host {"host_$ip_prefix.25_file-server1": ip => "$ip_prefix.25", name => "file-server1.$root_domain_name", host_aliases => ["file-server1"]}
host {"host_$ip_prefix.26_file-server2": ip => "$ip_prefix.26", name => "file-server2.$root_domain_name", host_aliases => ["file-server2"]}
host {"host_$ip_prefix.27_dns1": ip => "$ip_prefix.27", name => "dns1.$root_domain_name", host_aliases => ["dns1"]}
host {"host_$ip_prefix.28_dns2": ip => "$ip_prefix.28", name => "dns2.$root_domain_name", host_aliases => ["dns2"]}
host {"host_$ip_prefix.29_nfs1": ip => "$ip_prefix.29", name => "nfs1.$root_domain_name", host_aliases => ["nfs1"]}
host {"host_$ip_prefix.30_nfs2": ip => "$ip_prefix.30", name => "nfs2.$root_domain_name", host_aliases => ["nfs2"]}
host {"host_$ip_prefix.31_ntp1": ip => "$ip_prefix.31", name => "ntp1.$root_domain_name", host_aliases => ["ntp1"]}
host {"host_$ip_prefix.32_ntp2": ip => "$ip_prefix.32", name => "ntp2.$root_domain_name", host_aliases => ["ntp2"]}
host {"host_$ip_prefix.33_svn1": ip => "$ip_prefix.33", name => "svn1.$root_domain_name", host_aliases => ["svn1"]}
host {"host_$ip_prefix.34_svn2": ip => "$ip_prefix.34", name => "svn2.$root_domain_name", host_aliases => ["svn2"]}
host {"host_$ip_prefix.50_shop.db.vip": ip => "$ip_prefix.50", name => "shop.db.vip.$root_domain_name", host_aliases => ["shop.db.vip"]}
host {"host_$ip_prefix.50_tracker.dfs.vip": ip => "$ip_prefix.50", name => "tracker.dfs.vip.$root_domain_name", host_aliases => ["tracker.dfs.vip"]}
host {"host_$ip_prefix.50_shop.se.vip": ip => "$ip_prefix.50", name => "shop.se.vip.$root_domain_name", host_aliases => ["shop.se.vip"]}
host {"host_$ip_prefix.51_shop1.db": ip => "$ip_prefix.51", name => "shop1.db.$root_domain_name", host_aliases => ["shop1.db"]}
host {"host_$ip_prefix.52_shop2.db": ip => "$ip_prefix.52", name => "shop2.db.$root_domain_name", host_aliases => ["shop2.db"]}
host {"host_$ip_prefix.53_shop3.db": ip => "$ip_prefix.53", name => "shop3.db.$root_domain_name", host_aliases => ["shop3.db"]}
host {"host_$ip_prefix.54_shop1.se": ip => "$ip_prefix.54", name => "shop1.se.$root_domain_name", host_aliases => ["shop1.se"]}
host {"host_$ip_prefix.55_shop2.se": ip => "$ip_prefix.55", name => "shop2.se.$root_domain_name", host_aliases => ["shop2.se"]}
host {"host_$ip_prefix.56_shop3.se": ip => "$ip_prefix.56", name => "shop3.se.$root_domain_name", host_aliases => ["shop3.se"]}
host {"host_$ip_prefix.57_storage1.dfs": ip => "$ip_prefix.57", name => "storage1.dfs.$root_domain_name", host_aliases => ["storage1.dfs"]}
host {"host_$ip_prefix.58_storage2.dfs": ip => "$ip_prefix.58", name => "storage2.dfs.$root_domain_name", host_aliases => ["storage2.dfs"]}
host {"host_$ip_prefix.59_storage3.dfs": ip => "$ip_prefix.59", name => "storage3.dfs.$root_domain_name", host_aliases => ["storage3.dfs"]}
host {"host_$ip_prefix.60_tracker1.dfs": ip => "$ip_prefix.60", name => "tracker1.dfs.$root_domain_name", host_aliases => ["tracker1.dfs"]}
host {"host_$ip_prefix.61_tracker2.dfs": ip => "$ip_prefix.61", name => "tracker2.dfs.$root_domain_name", host_aliases => ["tracker2.dfs"]}
host {"host_$ip_prefix.62_tracker3.dfs": ip => "$ip_prefix.62", name => "tracker3.dfs.$root_domain_name", host_aliases => ["tracker3.dfs"]}
host {"host_$ip_prefix.101_acp1.web": ip => "$ip_prefix.101", name => "acp1.web.$root_domain_name", host_aliases => ["acp1.web"]}
host {"host_$ip_prefix.102_acp2.web": ip => "$ip_prefix.102", name => "acp2.web.$root_domain_name", host_aliases => ["acp2.web"]}
host {"host_$ip_prefix.103_acp3.web": ip => "$ip_prefix.103", name => "acp3.web.$root_domain_name", host_aliases => ["acp3.web"]}
host {"host_$ip_prefix.104_admin1.web": ip => "$ip_prefix.104", name => "admin1.web.$root_domain_name", host_aliases => ["admin1.web"]}
host {"host_$ip_prefix.105_admin2.web": ip => "$ip_prefix.105", name => "admin2.web.$root_domain_name", host_aliases => ["admin2.web"]}
host {"host_$ip_prefix.106_admin3.web": ip => "$ip_prefix.106", name => "admin3.web.$root_domain_name", host_aliases => ["admin3.web"]}
host {"host_$ip_prefix.107_detail1.web": ip => "$ip_prefix.107", name => "detail1.web.$root_domain_name", host_aliases => ["detail1.web"]}
host {"host_$ip_prefix.108_detail2.web": ip => "$ip_prefix.108", name => "detail2.web.$root_domain_name", host_aliases => ["detail2.web"]}
host {"host_$ip_prefix.109_detail3.web": ip => "$ip_prefix.109", name => "detail3.web.$root_domain_name", host_aliases => ["detail3.web"]}
host {"host_$ip_prefix.110_help1.web": ip => "$ip_prefix.110", name => "help1.web.$root_domain_name", host_aliases => ["help1.web"]}
host {"host_$ip_prefix.111_help2.web": ip => "$ip_prefix.111", name => "help2.web.$root_domain_name", host_aliases => ["help2.web"]}
host {"host_$ip_prefix.112_help3.web": ip => "$ip_prefix.112", name => "help3.web.$root_domain_name", host_aliases => ["help3.web"]}
host {"host_$ip_prefix.113_order1.web": ip => "$ip_prefix.113", name => "order1.web.$root_domain_name", host_aliases => ["order1.web"]}
host {"host_$ip_prefix.114_order2.web": ip => "$ip_prefix.114", name => "order2.web.$root_domain_name", host_aliases => ["order2.web"]}
host {"host_$ip_prefix.115_order3.web": ip => "$ip_prefix.115", name => "order3.web.$root_domain_name", host_aliases => ["order3.web"]}
host {"host_$ip_prefix.116_passport1.web": ip => "$ip_prefix.116", name => "passport1.web.$root_domain_name", host_aliases => ["passport1.web"]}
host {"host_$ip_prefix.117_passport2.web": ip => "$ip_prefix.117", name => "passport2.web.$root_domain_name", host_aliases => ["passport2.web"]}
host {"host_$ip_prefix.118_passport3.web": ip => "$ip_prefix.118", name => "passport3.web.$root_domain_name", host_aliases => ["passport3.web"]}
host {"host_$ip_prefix.119_search1.web": ip => "$ip_prefix.119", name => "search1.web.$root_domain_name", host_aliases => ["search1.web"]}
host {"host_$ip_prefix.120_search2.web": ip => "$ip_prefix.120", name => "search2.web.$root_domain_name", host_aliases => ["search2.web"]}
host {"host_$ip_prefix.121_search3.web": ip => "$ip_prefix.121", name => "search3.web.$root_domain_name", host_aliases => ["search3.web"]}
host {"host_$ip_prefix.122_show1.web": ip => "$ip_prefix.122", name => "show1.web.$root_domain_name", host_aliases => ["show1.web"]}
host {"host_$ip_prefix.123_show2.web": ip => "$ip_prefix.123", name => "show2.web.$root_domain_name", host_aliases => ["show2.web"]}
host {"host_$ip_prefix.124_show3.web": ip => "$ip_prefix.124", name => "show3.web.$root_domain_name", host_aliases => ["show3.web"]}
host {"host_$ip_prefix.125_static1.web": ip => "$ip_prefix.125", name => "static1.web.$root_domain_name", host_aliases => ["static1.web"]}
host {"host_$ip_prefix.126_static2.web": ip => "$ip_prefix.126", name => "static2.web.$root_domain_name", host_aliases => ["static2.web"]}
host {"host_$ip_prefix.127_static3.web": ip => "$ip_prefix.127", name => "static3.web.$root_domain_name", host_aliases => ["static3.web"]}
host {"host_$ip_prefix.128_tuan1.web": ip => "$ip_prefix.128", name => "tuan1.web.$root_domain_name", host_aliases => ["tuan1.web"]}
host {"host_$ip_prefix.129_tuan2.web": ip => "$ip_prefix.129", name => "tuan2.web.$root_domain_name", host_aliases => ["tuan2.web"]}
host {"host_$ip_prefix.130_tuan3.web": ip => "$ip_prefix.130", name => "tuan3.web.$root_domain_name", host_aliases => ["tuan3.web"]}
host {"host_$ip_prefix.131_user1.web": ip => "$ip_prefix.131", name => "user1.web.$root_domain_name", host_aliases => ["user1.web"]}
host {"host_$ip_prefix.132_user2.web": ip => "$ip_prefix.132", name => "user2.web.$root_domain_name", host_aliases => ["user2.web"]}
host {"host_$ip_prefix.133_user3.web": ip => "$ip_prefix.133", name => "user3.web.$root_domain_name", host_aliases => ["user3.web"]}
host {"host_$ip_prefix.134_www1.web": ip => "$ip_prefix.134", name => "www1.web.$root_domain_name", host_aliases => ["www1.web"]}
host {"host_$ip_prefix.135_www2.web": ip => "$ip_prefix.135", name => "www2.web.$root_domain_name", host_aliases => ["www2.web"]}
host {"host_$ip_prefix.136_www3.web": ip => "$ip_prefix.136", name => "www3.web.$root_domain_name", host_aliases => ["www3.web"]}
host {"host_$ip_prefix.137_activity1.web": ip => "$ip_prefix.137", name => "activity1.web.$root_domain_name", host_aliases => ["activity1.web"]}
host {"host_$ip_prefix.138_activity2.web": ip => "$ip_prefix.138", name => "activity2.web.$root_domain_name", host_aliases => ["activity2.web"]}
host {"host_$ip_prefix.139_activity3.web": ip => "$ip_prefix.139", name => "activity3.web.$root_domain_name", host_aliases => ["activity3.web"]}
host {"host_$ip_prefix.140_favorite1.web": ip => "$ip_prefix.140", name => "favorite1.web.$root_domain_name", host_aliases => ["favorite1.web"]}
host {"host_$ip_prefix.141_favorite2.web": ip => "$ip_prefix.141", name => "favorite2.web.$root_domain_name", host_aliases => ["favorite2.web"]}
host {"host_$ip_prefix.142_favorite3.web": ip => "$ip_prefix.142", name => "favorite3.web.$root_domain_name", host_aliases => ["favorite3.web"]}
host {"host_$ip_prefix.200_sys1.wan.lb": ip => "$ip_prefix.200", name => "sys1.wan.lb.$root_domain_name", host_aliases => ["sys1.wan.lb"]}
host {"host_$ip_prefix.201_sys2.wan.lb": ip => "$ip_prefix.201", name => "sys2.wan.lb.$root_domain_name", host_aliases => ["sys2.wan.lb"]}
host {"host_$ip_prefix.202_user1.wan.lb": ip => "$ip_prefix.202", name => "user1.wan.lb.$root_domain_name", host_aliases => ["user1.wan.lb"]}
host {"host_$ip_prefix.203_user2.wan.lb": ip => "$ip_prefix.203", name => "user2.wan.lb.$root_domain_name", host_aliases => ["user2.wan.lb"]}
host {"host_$ip_prefix.204_dhcp1": ip => "$ip_prefix.204", name => "dhcp1.$root_domain_name", host_aliases => ["dhcp1"]}
host {"host_$ip_prefix.205_dhcp2": ip => "$ip_prefix.205", name => "dhcp2.$root_domain_name", host_aliases => ["dhcp2"]}
host {"host_$ip_prefix.206_lan1.lb": ip => "$ip_prefix.206", name => "lan1.lb.$root_domain_name", host_aliases => ["lan1.lb"]}
host {"host_$ip_prefix.207_lan2.lb": ip => "$ip_prefix.207", name => "lan2.lb.$root_domain_name", host_aliases => ["lan2.lb"]}
host {"host_$ip_prefix.208_centos0.vmtpl": ip => "$ip_prefix.208", name => "centos0.vmtpl.$root_domain_name", host_aliases => ["centos0.vmtpl"]}
host {"host_$ip_prefix.209_centos1.vmtpl": ip => "$ip_prefix.209", name => "centos1.vmtpl.$root_domain_name", host_aliases => ["centos1.vmtpl"]}
host {"host_$ip_prefix.210_centos2.vmtpl": ip => "$ip_prefix.210", name => "centos2.vmtpl.$root_domain_name", host_aliases => ["centos2.vmtpl"]}
host {"host_$ip_prefix.211_centos3.vmtpl": ip => "$ip_prefix.211", name => "centos3.vmtpl.$root_domain_name", host_aliases => ["centos3.vmtpl"]}
host {"host_$ip_prefix.212_centos4.vmtpl": ip => "$ip_prefix.212", name => "centos4.vmtpl.$root_domain_name", host_aliases => ["centos4.vmtpl"]}
host {"host_$ip_prefix.213_centos5.vmtpl": ip => "$ip_prefix.213", name => "centos5.vmtpl.$root_domain_name", host_aliases => ["centos5.vmtpl"]}
host {"host_$ip_prefix.214_centos6.vmtpl": ip => "$ip_prefix.214", name => "centos6.vmtpl.$root_domain_name", host_aliases => ["centos6.vmtpl"]}
host {"host_$ip_prefix.215_centos7.vmtpl": ip => "$ip_prefix.215", name => "centos7.vmtpl.$root_domain_name", host_aliases => ["centos7.vmtpl"]}
host {"host_$ip_prefix.216_centos8.vmtpl": ip => "$ip_prefix.216", name => "centos8.vmtpl.$root_domain_name", host_aliases => ["centos8.vmtpl"]}
host {"host_$ip_prefix.217_compiler.tool": ip => "$ip_prefix.217", name => "compiler.tool.$root_domain_name", host_aliases => ["compiler.tool"]}
host {"host_$ip_prefix.218_sb.test": ip => "$ip_prefix.218", name => "sb.test.$root_domain_name", host_aliases => ["sb.test"]}
host {"host_$ip_prefix.219_vpn-gateway1": ip => "$ip_prefix.219", name => "vpn-gateway1.$root_domain_name", host_aliases => ["vpn-gateway1"]}
host {"host_$ip_prefix.220_vpn-gateway2": ip => "$ip_prefix.220", name => "vpn-gateway2.$root_domain_name", host_aliases => ["vpn-gateway2"]}
