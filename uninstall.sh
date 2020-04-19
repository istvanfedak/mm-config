#!/bin/bash
# run with sudo
# global uninstaller for the package

PACKAGE_PATH_NAME='/usr/local/mm-config'

# run the package installer
if [ -L $PACKAGE_PATH_NAME ]; then
  echo "running package uninstaller"
  bash $PACKAGE_PATH_NAME/bin/uninstaller.sh

  # remove symbolic link in the package directory  
  unlink $PACKAGE_PATH_NAME
  echo "$PACKAGE_PATH_NAME symbolic link removed"
else
  echo "error: symbolic link is broken"
  echo "  cannot find the path to the uninstaller"
  echo "  uninstaller path: $PACKAGE_PATH_NAME/bin/uninstaller.sh"
  echo ''
  echo "restore the link and run this script again to uninstall"
  echo "symbolic link: $PACKAGE_PATH_NAME -> $(pwd)"
fi

echo "advice: if you're trying to repurpose this raspberry pi, i recommend"
echo "        you reinstall raspbian"
