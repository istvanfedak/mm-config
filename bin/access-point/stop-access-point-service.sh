# !/bin/bash
# This file stops the access point service
# Run with sudo
DHCPCD_CONF='/etc/dhcpcd.conf'
INTERFACES='/etc/network/interfaces'

systemctl stop dnsmasq
echo 'stoped dnsmasq'
systemctl stop hostapd
echo 'stoped hostapd'

# restore the dhcpcd config file
mv $DHCPCD_CONF.save $DHCPCD_CONF
echo "$DHCPCD_CONF file restored"

# restore the network interfaces config file
mv $INTERFACES.save $INTERFACES
echo "$INTERFACES file restored"

echo "Please reboot for changes to take effect"

