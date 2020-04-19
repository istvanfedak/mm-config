#!/bin/bash
# This file stops the access point service
# Run with sudo
DHCPCD_CONF='/etc/dhcpcd.conf'
INTERFACES='/etc/network/interfaces'

systemctl stop dnsmasq
echo 'stoped dnsmasq'
systemctl stop hostapd
echo 'stoped hostapd'

# restore the dhcpcd config file
if [ -f $DHCPCD_CONF.save ]; then
  mv $DHCPCD_CONF.save $DHCPCD_CONF
  echo "$DHCPCD_CONF file restored"
else
  echo "warning: $DHCPCD_CONF.save file could not be found"
  echo "  manually restore $DHCPCD_CONF"
fi

# restore the network interfaces config file
if [ -f $INTERFACES.save ]; then
  mv $INTERFACES.save $INTERFACES
  echo "$INTERFACES file restored"
else
  echo "warning: $INTERFACES.save file could not be found"
  echo "  manually restore $INTERFACES"
fi
