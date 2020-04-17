#!/bin/bash
# run with sudo
# global uninstaller for the package

PACKAGE_PATH_NAME='/usr/local/mm-config'

# run the package installer
echo "running package uninstaller"
bash $PACKAGE_PATH_NAME/bin/uninstall.sh

# remove symbolic link in the package directory  
unlink $PACKAGE_PATH_NAME
echo "$PACKAGE_PATH_NAME symbolic link removed"

