#!/bin/sh
. /root/config.ini

hostname="$1.$root_domain"
hostname_raw="$1.raw.$root_domain"

rm /var/lib/puppet/ssl/* -rf
ssh $puppet_server "puppet cert --clean $hostname_raw $hostname"