# !/bin/bash
# This file starts the access point service
# Run with sudo

ROOT_DIR="$(cd "$(dirname "$0")/../../"; pwd)"
CONFIGDIR_PATH="$ROOT_DIR/config"
DHCPCD_CONF='dhcpcd.conf'
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
