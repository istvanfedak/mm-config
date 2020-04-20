#!/bin/bash
# run with sudo
# This script periodically checks if there's a wifi connection
# if there is none it starts up the access point

ROOT_DIR='/usr/local/mm-config'
SCRIPTS="$ROOT_DIR/bin"
WIFI_STATUS_SH="$SCRIPTS/wifi/wifi-status.sh"
AP_STATUS_SH="$SCRIPTS/access-point/access-point-service-status.sh"
RUN_AP_SH="$SCRIPTS/access-point/run-access-point-service.sh"

# running infinite loop
while(true); do
  # sleep for a minute
  sleep 60
  # check if connected to wifi
  WIFI_STATUS=$(bash $WIFI_STATUS_SH)

  # if connected to wifi check if process is running
  if [ WIFI_STATUS == 'disconnected' ]; then
    echo 'wifi is disconected'

    # check if access point is active
    AP_STATUS=$(bash $AP_STATUS_SH)

    # if the access point is inactive start it up 
    if [ AP_STATUS == 'inactive' ]; then

      echo 'access point is inactive, starting up access point'
      bash $RUN_AP_SH

    fi

  fi
done
