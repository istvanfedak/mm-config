# !/bin/bash
# This file runs a basic web server
# Run with sudo if port is 80

WEBDIR_PATH='/var/www/'
IP_ADDRESS='127.0.0.1'
PORT='80'

# if the WEBDIR_PATH does not exist create it
if [ -d $WEBDIR_PATH ]
then
  sudo busybox httpd -p $IP_ADDRESS:$PORT -h $WEBDIR_PATH
  echo "Listening on port $PORT ..."
else
  echo "$WEBDIR_PATH cannot be found"
  echo "Please make sure to install the webserver files"
  echo "run sudo bash ./bin/install-webserver-files.sh and try again"
fi

