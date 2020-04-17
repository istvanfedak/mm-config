# !/bin/bash
# This file installs and runs the web server
# run as sudo

ROOT_DIR="$(cd "$(dirname "$0")/../"; pwd)"
WEBSERVER_SCRIPTS="$ROOT_DIR/bin/web-server"

echo "Uninstaller started"
exit 0

bash $WEBSERVER_SCRIPTS/stop-webserver.sh 
bash $WEBSERVER_SCRIPTS/uninstall-webserver-files.sh
