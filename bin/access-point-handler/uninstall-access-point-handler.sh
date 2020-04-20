#!/bin/bash
# run with sudo
# this script uinstalls the access point handler from systemd

ROOT_DIR='/usr/local/mm-config'
CONFIG_FILE='access-point-handler.service'
SERVICE_PATH_NAME="$ROOT_DIR/config/$CONFIG_FILE"
SCRIPTS="$ROOT_DIR/bin"

# stop the service 
systemctl stop access-point-handler

# unregister the script to be run on startup
systemctl disable access-point-handler

# remove the file from the systemd systems dir if it exists
if [ -L "/etc/systemd/system/$CONFIG_FILE" ]; then
  unlink /etc/systemd/system/$CONFIG_FILE
  echo "/etc/systemd/system/$CONFIG_FILE unlinked"
fi

