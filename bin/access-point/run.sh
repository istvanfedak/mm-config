# !/bin/bash
# This file installs the necessary software to make the raspberry pi into an
# access point
# Run with sudo!
# Make sure to run the following commands first
# - sudo apt update
# - sudo apt upgrade
# Note this install will require a reboot

ROOT_DIR="/usr/local/mm-config"
CONFIGDIR_PATH="$ROOT_DIR/config"
DHCPCD_CONF='dhcpcd.conf'
DNSMASQ_CONF='dnsmasq.conf'
HOSTNAME='hostname'
HOSTS='hosts'
HOSTAPD_CONF='hostapd.conf'
INTERFACES='interfaces'

# modify the dhcpcd.conf file
# first save the template if the save file doesn't exist
if [ -f "/etc/$DHCPCD_CONF.save" ]; then
  echo "/etc/$DHCPCD_CONF.save already exists"
else
  mv /etc/$DHCPCD_CONF /etc/$DHCPCD_CONF.save
  echo "/etc/$DHCPCD_CONF.save file created"
fi

# copy our dhcpcd config file into the directory
cp $CONFIGDIR_PATH/$DHCPCD_CONF '/etc/'
echo "$CONFIGDIR_PATH/$DHCPCD_CONF copied into /etc/" 

# restart the dhcpcd daemon
# sudo service dhcpcd restart
service dhcpcd restart
echo 'Restarted dhcpcd service'

# now we need to tell the system where to find the configuration file
# make a copy of the default network interfaces file
if [ -f "/etc/network/$INTERFACES.save" ]; then
  echo "/etc/network/$INTERFACES.save already exists"
else
  mv /etc/network/$INTERFACES /etc/network/$INTERFACES.save
  echo "/etc/network/$INTERFACES.save file created"
fi

# copy our network interfaces file into the directory
cp $CONFIGDIR_PATH/$INTERFACES '/etc/network/'
echo "$CONFIGDIR_PATH/$INTERFACES copied into /etc/network/"

# start hostapd up
systemctl start hostapd
echo 'started hostapd service'

# start dnsmasq service
systemctl start dnsmasq
echo 'started dnsmasq service'
