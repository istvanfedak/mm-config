#!/bin/bash
# run with sudo
# this script installs the access point handler into systemd

ROOT_DIR='/usr/local/mm-config'
CONFIG_FILE='access-point-handler.service'
SERVICE_CONFIG="$ROOT_DIR/config/$CONFIG_FILE"
SCRIPTS="$ROOT_DIR/bin"

# copy handler file into the system folder to be run by systemd on boot
# if the file doesn't exist
if [ ! -L "/etc/systemd/system/$CONFIG_FILE" ]; then
  ln -s $SERVICE_CONFIG /etc/systemd/system
else
  echo "warning: /etc/systemd/system/$CONFIG_FILE already exists"
fi

# register the script to be run on startup
systemctl enable access-point-handler

# start up the service
systemctl start access-point-handler
