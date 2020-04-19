# !/bin/bash
# This file installs and runs the web server
# run as sudo

SCRIPTS="/usr/local/mm-config/bin/"

echo "installer started"
echo "note: you will be prompted for user input"
sleep 1
exit 0

# 1. install node js
bash $SCRIPTS/nodejs/install-nodejs.sh 

# 2. install MagicMirror
bash $SCRIPTS/magic-mirror/install-magic-mirror.sh

# 3. install access point service
bash $SCRIPTS/access-point/install-access-point-service.sh
# bash $SCRIPTS/access-point/run-access-point-service.sh

# 4. install web server and www files and run web server
bash $SCRIPTS/web-server/install-webserver-files.sh
# bash $SCRIPTS/web-server/run-webserver.sh

# 5. TODO install and run the mm-config-api

# 6. TODO install script that spins up everythign if the raspbery pi
#    is not connected to the internet. Once the pi is connected to the
#    script will spin down everything unless the user specifies not to
#    during the web configuration.
#      add feature that enables a button to toggle this script on and off

# reboot is required because of the hostname change to take effect
echo "This install requires a reboot"
echo "Note after reboot the new hostname will be magicmirror"
read -p 'Would you like to reboot now? (Y/n): ' REBOOT

if [ "$REBOOT" = "Y" ]; then
  shutdown -r now
else
  echo "Please reboot your machine for the changes to take effect"
fi
