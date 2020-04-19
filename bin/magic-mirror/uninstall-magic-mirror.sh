# !/bin/bash
# this script attempts to install the magic mirror on the raspberry pi
# run with sudo

# note: assuming you are running the uninstaller 
#       located at ~/mm-config/uninstall.sh

cd ../
HOMEDIR="$(pwd)"

echo "attempting to uninstall MagicMirror in the following direcotry:"
echo "  $HOMEDIR"

# running node js packet manager uninstaller
npm uninstall MagicMirror

# attempting to remove magic mirror dir
if [ -d $HOMEDIR/MagicMirror ]; then
  rm -rf $HOMEDIR/MagicMirror
  echo "$HOMEDIR/MagicMirror directory removed"
else
  echo "error: couldn't find $HOMEDIR/MagicMirror"
fi
