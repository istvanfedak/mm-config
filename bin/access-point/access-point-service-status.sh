#!/bin/bash
# Obtains the status of the hostapd service
# run with sudo

# get the status of the access point and filter if inactive
AP_STATUS=$(systemctl status hostapd.service | grep -i inactive)

# if the result is empty then the access point is active
if [ -z "$AP_STATUS" ]; then
  echo 'active'
# if it returns inactive then the access point is inactive
else
  echo 'inactive'
fi
