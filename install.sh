#!/bin/bash
# run with sudo
# global installer for the package

PACKAGE_PATH_NAME='/usr/local/mm-config'
WORKING_DIR=$(pwd)

# create symbolic link in the package directory to the current directory
ln -s $WORKING_DIR $PACKAGE_PATH_NAME
echo "$PACKAGE_PATH_NAME symbolic link created to $WORKING_DIR"

# run the package installer
echo "running package installer"
bash $PACKAGE_PATH_NAME/bin/install.sh
