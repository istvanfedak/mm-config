# !/bin/bash
# this script verifies if the computer is connected to the wifi
# and the internet

WIFI_INFO="$(ip address show wlan0 | grep -i inet)"
INTERNET_CONNECTION="$(ping -c 1 -q google.com >&/dev/null; echo $?)"

# check if connected to wifi by verifying an ip was assigned
#   if the output of the command is not empty
if [ ! -z "$WIFI_INFO" ]; then
  echo "connected"
else
  echo "disconnected"
fi

# check if connected to the internet by pining google
# if [ $INTERNET_CONNECTION == 0 ]; then
#   echo "Connected to the internet"
# else
#   echo "No internet connection"
# fi

