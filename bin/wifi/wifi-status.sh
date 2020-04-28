#!/bin/bash
# this script verifies if the computer is connected to the wifi
# and the internet

ROOT_DIR='/usr/local/mm-config'
SCRIPTS="$ROOT_DIR/bin"
WIFI_INFO="$(ip address show wlan0 | grep -i 'inet')"
ROUTER_IP="$(bash $SCRIPTS/wifi/get-router-ip.sh)"
ROUTER_CONNECTION="$(ping -c 1 -q $ROUTER_IP >&/dev/null; echo $?)"

# check if connected to wifi by verifying an ip was assigned
#   if the output of the command is not empty and can ping router
if [ ! -z "$WIFI_INFO" ] && [ $ROUTER_CONNECTION == 0 ]; then
  echo "connected"
else
  echo "disconnected"
fi

