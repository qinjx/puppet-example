# Keepalived puppet module

Module to manage keepalived on Debian/Ubuntu. It's not yet finished, only the VIP part is done.

## Example

    class {
      "keepalived":
        email => "root@example.com"; # array also allowed
    }

    keepalived::vrrp_sync_group {
      "yuxCluster":
        members => [ "gw" ];
    }

    keepalived::vrrp_instance {
      "gw":
        kind              => "MASTER",
        interface         => "eth1",
        password          => "ThisIsAPassword",
        virtual_router_id => 1,
        virtual_addresses => [
                              "10.10.10.1 dev eth1",
                              "10.12.12.1 dev eth0",
                              "ffff::1 dev eth1"
                             ];
    }
