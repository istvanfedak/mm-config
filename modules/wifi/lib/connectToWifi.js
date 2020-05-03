'use strict'

const script = '/usr/local/mm-config/bin/wifi-handler/wifi-handler-connect.sh';
const statusScript = '/usr/local/mm-config/bin/wifi/wifi-status.sh';
const { execSync } = require('child_process');

module.exports = connectToWifi

// this function connects the raspberry pi to the wifi
function connectToWifi(name, password) {
    execSync(`bash ${script} ${name}`, { input: password });
    const wifiStatus = execSync(`bash ${statusScript}`).toString();
    if(wifiStatus.includes("connected"))
	return true;
    else
	return false;
}
