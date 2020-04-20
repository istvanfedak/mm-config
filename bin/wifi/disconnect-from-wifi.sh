#!/bin/bash
# run with sudo
# this file will disconnect you from wifi and clear all wifi settings

CONFIG_PATH_NAME='/etc/wpa_supplicant/wpa_supplicant.conf'

# check if save file already exists and replace it
if [ -f "$CONFIG_PATH_NAME.save" ]; then
  mv $CONFIG_PATH_NAME.save $CONFIG_PATH_NAME
  echo "$CONFIG_PATH_NAME file restored"
else
  echo "error restoring $CONFIG_PATH_NAME"
  echo "please remove network={...} manually from the file and rerun"
fi

# reconfigure wifi to disconnect from it
wpa_cli -i wlan0 reconfigure

# flush the wlan0
ip link set dev wlan0 down
ip link set dev wlan0 up

