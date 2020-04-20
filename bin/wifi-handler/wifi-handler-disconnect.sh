#!/bin/bash
# run with sudo
# this file connects to wifi and handles the access point service

ROOT_DIR='/usr/local/mm-config'
SCRIPTS="$ROOT_DIR/bin"

# define all the access point handler scripts needed
APH_STATUS_SH="$SCRIPTS/access-point-handler/access-point-handler-status.sh"
APH_RUN_SH="$SCRIPTS/access-point-handler/run-access-point-handler.sh"
APH_STOP_SH="$SCRIPTS/access-point-handler/stop-access-point-handler.sh"

# define all the access point config scripts needed
AP_STATUS_SH="$SCRIPTS/access-point/access-point-status.sh"
AP_RUN_SH="$SCRIPTS/access-point/run-access-point.sh"
AP_STOP_SH="$SCRIPTS/access-point/stop-access-point.sh"

# define all the wifi scripts needed
WIFI_DISCONNECT_SH="$SCRIPTS/wifi/disconnect-from-wifi.sh"

# if the access point handler is active stop it
if [ $(bash $APH_STATUS_SH) == "active" ]; then
  bash $APH_STOP_SH
  echo 'stopped access-point-handler.service'
fi

# if the access point is active stop it
if [ $(bash $AP_STATUS_SH) == "active" ]; then
  bash $AP_STOP_SH
  echo 'stopped access point'
fi

# attempt to disconnect from wifi
echo 'attempting to disconnect from wifi'
bash $WIFI_DISCONNECT_SH $WIFI_NAME

# if not connected to wifi start up access point
bash $AP_RUN_SH
echo 'started up access point'

# start up the access point handler service
bash $APH_RUN_SH
echo 'started the access-point-handler service'

