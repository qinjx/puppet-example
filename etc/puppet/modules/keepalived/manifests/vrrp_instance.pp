# vrrp_instance.pp
#
# $Id$

define keepalived::vrrp_instance(
  $kind = "SLAVE",
  $priority = 100,
  $interface = "eth0",
  $virtual_router_id = 10,
  $advert_int = 1,
  $password,
  $virtual_addresses
) {

    if($kind != "MASTER" and $kind != "SLAVE") {
        fail("${kind} is not allowed, only MASTER or SLAVE")
    }

    common::concatfilepart {
       "vrrp_instance_${name}":
           ensure  => present,
           manage  => true,
           content => template("keepalived/vrrp_instance.erb"),
           file    => "/etc/keepalived/keepalived.conf",
           require => Package["keepalived"];
    }

}
