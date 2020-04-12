# !/bin/bash
# This file starts the access point service
# Run with sudo

# restart the dnsmasq service
ip link set wlan0 down
ip link set wlan0 up
systemctl start dnsmasq

# start hostapd up
systemctl unmask hostapd
systemctl enable hostapd
systemctl start hostapd

# restart the dhcpcd daemon
sudo service dhcpcd restart
echo "Restarted dhcpcd service"


