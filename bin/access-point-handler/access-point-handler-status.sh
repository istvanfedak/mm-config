#!/bin/bash
# Obtains the status of the access point handler service
# run with sudo

# get the status of the access point and filter if inactive
APH_STATUS=$(systemctl status access-point-handler.service | grep 'inactive')

# if the result is empty then the access point is active
if [ -z "$APH_STATUS" ]; then
  echo 'active'
# if it returns inactive then the access point is inactive
else
  echo 'inactive'
fi
