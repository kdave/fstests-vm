#!/bin/sh

rm /etc/resolv.conf
echo 'nameserver 1.1.1.1' > /etc/resolv.conf
dhcpcd enp0s1
zypper ar --refresh http://download.opensuse.org/tumbleweed/repo/oss/ tw-oss
