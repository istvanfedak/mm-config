#!/bin/bash
# run with sudo
# this file will connect you to the wifi given the wifi name and password
# note this script will clear this command from the ~/.bash_history for
# security

if [ $# != 1 ]; then
  echo "usage: sudo bash $0 <wifi-name>"
  exit 0
fi

ROOT_DIR="$(cd "$(dirname "$0")/../../"; pwd)"
SCRIPTS="$ROOT_DIR/bin"
CONFIG_PATH_NAME='/etc/wpa_supplicant/wpa_supplicant.conf'
WIFI_NAME=$1

read -sp 'Password: ' PASSWORD
echo ''

# first we need to make a copy of the wpa supplicant config file if it doesn't
# exist already

if [ ! -f "$CONFIG_PATH_NAME.save" ]; then
  cp $CONFIG_PATH_NAME $CONFIG_PATH_NAME.save
  echo "$CONFIG_PATH_NAME.save file created"
fi

# copy the save file into the original to override any previous config
cp $CONFIG_PATH_NAME.save $CONFIG_PATH_NAME
echo "$CONFIG_PATH_NAME overriden with $CONFIG_PATH_NAME.save"

# generating key network key to be stored in the config file
# this also removes the plain text password
wpa_passphrase "$WIFI_NAME" <<< "$PASSWORD" | grep -v '#' >> $CONFIG_PATH_NAME
echo "Saved wifi information in $CONFIG_PATH_NAME"

# reconfigure wifi to attempt to connect to it
sleep 1
wpa_cli -i wlan0 reconfigure

# clear the session's bash history
history -c

# sleep for 5 seconds to wait for wifi connection
echo 'verifying wifi connection please wait'
sleep 10

# validate if connection was successful
bash $SCRIPTS/wifi/wifi-status.sh
