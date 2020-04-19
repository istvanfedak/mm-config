#!/bin/bash
# This file installs the necessary software needed to make the raspberry pi 
# into an access point
# Run with sudo!
# Make sure to run the following commands first
# - sudo apt update
# - sudo apt upgrade
# Note this install will require a reboot

ROOT_DIR='/usr/local/mm-config'
CONFIGDIR_PATH="$ROOT_DIR/config"
RUN_AP_SERVICE="$ROOT_DIR/bin/access-point/run-access-point-service.sh"
DHCPCD_CONF='dhcpcd.conf'
DNSMASQ_CONF='dnsmasq.conf'
HOSTNAME='hostname'
HOSTS='hosts'
HOSTAPD_CONF='hostapd.conf'
INTERFACES='interfaces'

# isntall packages
apt install dnsmasq -y
echo 'dnsmasq installed'
apt install hostapd -y
echo 'hostapd installed'

systemctl stop dnsmasq
echo 'stoped dnsmasq'
systemctl stop hostapd
echo 'stoped hostapd'

# configuring the DHCP server (dnsmasq)
# first save the template if the save file doesn't exist
if [ -f "/etc/$DNSMASQ_CONF.save" ]; then
  echo "/etc/$DNSMASQ_CONF.save already exists"
else
  mv /etc/$DNSMASQ_CONF /etc/$DNSMASQ_CONF.save
  echo "/etc/$DNSMASQ_CONF.save file created"
fi

# copy our dnsmasq config file into the directory
cp $CONFIGDIR_PATH/$DNSMASQ_CONF '/etc/'
echo "$CONFIGDIR_PATH/$DNSMASQ_CONF copied into /etc/"

# rename the hostname of the computer to the one in .../config/hostname
if [ -f "/etc/$HOSTNAME.save" ]; then
  echo "/etc/$HOSTNAME.save already exists"
else
  mv /etc/$HOSTNAME /etc/$HOSTNAME.save
  echo "/etc/$HOSTNAME.save file created"
fi

# copy our hostname file into the directory
cp $CONFIGDIR_PATH/$HOSTNAME '/etc/'
echo "$CONFIGDIR_PATH/$HOSTNAME copied into /etc/"

# configuring the dnsmasq local hosts
# first save the hosts file and append it to the template
if [ -f "/etc/$HOSTS.save" ]; then
  echo "/etc/$HOSTS.save already exists"
else
  mv /etc/$HOSTS /etc/$HOSTS.save
  echo "/etc/$HOSTS.save file created"
fi

# copy our hosts template to the directory
cp $CONFIGDIR_PATH/$HOSTS '/etc/'
echo "$CONFIGDIR_PATH/$HOSTS copied into /etc/"

# copy our hostapd config file into the directory
cp $CONFIGDIR_PATH/$HOSTAPD_CONF '/etc/hostapd/'
echo "$CONFIGDIR_PATH/$HOSTAPD_CONF copied into /etc/hostapd/"

# run the access point service after install
bash $RUN_AP_SERVICE
