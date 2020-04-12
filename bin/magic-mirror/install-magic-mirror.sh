# !/bin/bash
# this script attempts to install the magic mirror on the raspberry pi
# run with sudo

ROOTDIR='/home/pi'

cd $ROOTDIR

echo "Installing MagicMirror, you will be prompted for input"
bash -c "$(curl -sL https://raw.githubusercontent.com/ac2799/MagicMirror/master/installers/raspberry.sh)"

cd MagicMirror

echo "Fixing any vulnerabilities Magic Mirror might have"
npm audit fix

echo "Staring MagicMirror"
DISPLAY=:0 npm start

