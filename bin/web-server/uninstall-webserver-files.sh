# !/bin/bash
# This file removed all the web config files from the system
# Run with sudo!

WEBDIR_PATH='/var/www/'

# if the WEBDIR_PATH exist delete it
if [ -d $WEBDIR_PATH ]
then
  rm -rf $WEBDIR_PATH
  echo "$WEBDIR_PATH was removed"
else
  echo "$WEBDIR_PATH cannot be found"
fi
