# vrrp_sync_group.pp
#
# $Id$

define keepalived::vrrp_sync_group(
  $members
) {
    common::concatfilepart {
       "vrrp_sync_group_${name}":
           ensure  => present,
           manage  => true,
           content => template("keepalived/vrrp_sync_group.erb"),
           file    => "/etc/keepalived/keepalived.conf",
           require => Package["keepalived"];
    }
}
