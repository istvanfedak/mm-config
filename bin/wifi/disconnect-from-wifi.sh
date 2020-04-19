#!/bin/bash
# run with sudo
# this file will disconnect you from wifi and clear all wifi settings

CONFIG_PATH_NAME='/etc/wpa_supplicant/wpa_supplicant.conf'

# check if save file already exists and replace it
if [ -f "$CONFIG_PATH_NAME.save" ]; then
  cp $CONFIG_PATH_NAME.save $CONFIG_PATH_NAME
  echo "$CONFIG_PATH_NAME file restored"
else
  echo "error restoring $CONFIG_PATH_NAME"
  echo "please remove network={...} manually from the file and rerun"
  exit 1
fi

# reconfigure wifi to disconnect from it
wpa_cli -i wlan0 reconfigure


