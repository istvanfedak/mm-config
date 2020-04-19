#!/bin/bash
# This file spins up a basic web server used to host the configuration site
# Run with sudo!

WEBDIR_PATH='/var/www/html/'
ROOT_DIR='/usr/local/mm-config'
WEBFILES_PATH="$ROOT_DIR/www/"

# install apache 2 to host the website
apt install apache2

# if the WEBDIR_PATH does not exist create it
if [ -d $WEBDIR_PATH ]
then
  echo "$WEBDIR_PATH already exists"
else
  echo "$WEBDIR_PATH directory created"
  mkdir -p $WEBDIR_PATH
fi

# copy the files over
cp -R $WEBFILES_PATH* $WEBDIR_PATH
echo "$WEBFILES_PATH* files copied to $WEBDIR_PATH"
