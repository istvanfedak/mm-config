# !/bin/bash
# This file installs the necessary software to make the raspberry pi into an
# access point
# Run with sudo!
# Make sure to run the following commands first
# - sudo apt update
# - sudo apt upgrade

ROOT_DIR="$(cd "$(dirname "$0")/../../"; pwd)"
CONFIGDIR_PATH="$ROOT_DIR/config"
DHCPCD_CONF='dhcpcd.conf'
DNSMASQ_CONF='dnsmasq.conf'
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
sudo service dhcpcd restart
echo "Restarted dhcpcd service"

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

# configuring the dnsmasq local hosts
# first save the hosts file and append it to the template
if [ -f "/etc/$HOSTS.save" ]; then
  echo "/etc/$HOSTS.save already exists"
else
  # append the hosts file to our hosts template
  cat /etc/$HOSTS >> $CONFIGDIR_PATH/$HOSTS
  echo "/etc/$HOSTS appended to the end of $CONFIGDIR_PATH/$HOSTS"
  mv /etc/$HOSTS /etc/$HOSTS.save
  echo "/etc/$HOSTS.save file created"
fi

# copy our hosts template to the directory
cp $CONFIGDIR_PATH/$HOSTS '/etc/'
echo "$CONFIGDIR_PATH/$HOSTS copied into /etc/"

# restart the dnsmasq service
systemctl start dnsmasq

# configuring the access point host software (hostapd)
# first save the template if the save file doesn't exist
# if [ -f "/etc/hostapd/$HOSTAPD_CONF.save" ]; then
#   echo "/etc/hostapd/$HOSTAPD_CONF.save already exists"
# else
#   mv /etc/hostapd/$HOSTAPD_CONF /etc/hostapd/$HOSTAPD_CONF.save
#   echo "/etc/$HOSTAPD_CONF.save file created"
# fi

# copy our hostapd config file into the directory
cp $CONFIGDIR_PATH/$HOSTAPD_CONF '/etc/hostapd/'
echo "$CONFIGDIR_PATH/$HOSTAPD_CONF copied into /etc/hostapd/"

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
systemctl unmask hostapd
systemctl enable hostapd
systemctl start hostapd
