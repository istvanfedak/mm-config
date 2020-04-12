# !/bin/bash
# This file stops the access point service
# Run with sudo

systemctl stop dnsmasq
echo 'stoped dnsmasq'
systemctl stop hostapd
echo 'stoped hostapd'

