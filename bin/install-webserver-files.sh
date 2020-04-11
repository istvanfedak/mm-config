# !/bin/bash
# This file spins up a basic web server used to host the configuration site
# Run with sudo!

WEBDIR_PATH='/var/www/'
ROOT_DIR="$(cd "$(dirname "$0")/../"; pwd)"
WEBFILES_PATH="$ROOT_DIR/www/"

# if the WEBDIR_PATH does not exist create it
if [ -d $WEBDIR_PATH ]
then
  echo "$WEBDIR_PATH already exists"
else
  echo "$WEBDIR_PATH directory created"
  mkdir -p $WEBDIR_PATH
fi

# copy the files over
echo "$WEBFILES_PATH* files copied to $WEBDIR_PATH"
cp -R $WEBFILES_PATH* $WEBDIR_PATH

