#!/bin/bash
# this script should be run with sudo
ROOT_DIR='/usr/local/mm-config'
SCRIPTS="$ROOT_DIR/bin"

# running infinite loop
while(true); do
  # sleep for a minute
  sleep 60

  # check if connected to wifi
  WIFI_STATUS=$(sudo bash "$SCRIPTS/wifi/verify-wifi-connection.sh")
  
  # if connected to wifi check if process is running
  if [ WIFI_STATUS == 'Connected' ]; then
    
  # if not connected to wifi spin up access point

done
