#!/bin/bash
# This file uninstalls the necessary software needed to make a raspberry pi
# into an access point
# Run with sudo!
# Note this uninstall will require a reboot

ROOT_DIR='/usr/local/mm-config/'
CONFIGDIR_PATH="/usr/local/mm-config/config"
STOP_AP_SERVICE="$ROOT_DIR/bin/access-point/stop-access-point-service.sh"

DHCPCD_CONF='dhcpcd.conf'
DNSMASQ_CONF='dnsmasq.conf'
HOSTNAME='hostname'
HOSTS='hosts'
HOSTAPD_CONF='hostapd.conf'
INTERFACES='interfaces'

# stop access point service
bash $STOP_AP_SERVICE

# remove hostapd configuration file
if [ -f "/etc/hostapd/$HOSTAPD_CONF" ]; then
  rm /etc/hostapd/$HOSTAPD_CONF
  echo "/etc/hostapd/$HOSTAPD_CONF file removed"
echo
  echo "/etc/hostapd/$HOSTAPD_CONF file not found, could not be removed"
fi

# restore the dnsmasq local host file
if [ -f "/etc/$HOSTS.save" ]; then
  mv /etc/$HOSTS.save /etc/$HOSTS
  echo "/etc/$HOSTS file restored"
else
  echo "error restoring /etc/$HOSTS"
  echo "  /etc/$HOSTS.save file not found"
fi

# restore the host name of the computer
if [ -f "/etc/$HOSTNAME.save" ]; then
  mv /etc/$HOSTNAME.save /etc/$HOSTNAME
  echo "/etc/$HOSTNAME file restored"
else
  echo "error restoring /etc/$HOSTNAME"
  echo "  /etc/$HOSTNAME.save file not found"
fi

# restore the dnsmasq config file
if [ -f "/etc/$DNSMASQ_CONF.save"]; then
  mv /etc/$DNSMASQ_CONF.save /etc/$DNSMASQ_CONF
  echo "/etc/$DNSMASQ_CONF file restored"
else
  echo "error restoring /etc/$DNSMASQ_CONF"
  echo "  /etc/$DNSMASQ_CONF.save file not found"
fi

# uninstall hostapd and dnsmasq
apt remove hostapd -y
echo "hostapd removed"
apd remove dnsmasq -y
echo "dnsmasq removed"

