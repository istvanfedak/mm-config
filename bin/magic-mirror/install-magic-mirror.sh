#!/bin/bash
# this script attempts to install the magic mirror on the raspberry pi
# run with sudo

# note: assuming you are running the installer 
#       located at ~/mm-config/install.sh

cd ../
HOMEDIR="$(pwd)"

echo "MagicMirror will be installed the following direcotry:"
echo "  $HOMEDIR"

echo "installing MagicMirror, you will be prompted for input"
bash -c "$(curl -sL https://raw.githubusercontent.com/ac2799/MagicMirror/master/installers/raspberry.sh)"

cd MagicMirror

echo "fixing any vulnerabilities Magic Mirror might have"
npm audit fix

echo "Staring MagicMirror"
DISPLAY=:0 npm start

