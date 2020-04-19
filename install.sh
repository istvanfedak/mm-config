#!/bin/bash
# run with sudo
# global installer for the package

PACKAGE_PATH_NAME='/usr/local/mm-config'
WORKING_DIR=$(pwd)

# create symbolic link in the package directory to the current directory
if [ ! -L $PACKAGE_PATH_NAME ]; then
  ln -s $WORKING_DIR $PACKAGE_PATH_NAME
  echo "$PACKAGE_PATH_NAME symbolic link created to $WORKING_DIR"
else
  echo "$PACKAGE_PATH_NAME symbolic link to $WORKING_DIR already exists"
fi

# run the package installer
echo "running package installer"
bash $PACKAGE_PATH_NAME/bin/installer.sh
