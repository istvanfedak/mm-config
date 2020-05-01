'use strict'

const script = '/usr/local/mm-config/bin/wifi/list-wifi.sh';
const { execSync } = require('child_process');

module.exports = getWifiList

// this function gets a wifi list from a shell script and parses it
// into an array of wifi objects
function getWifiList() {
    var wifiList = execSync(`bash ${script}`).toString().split('\n');
    wifiList.pop();

    var objWifiList = [];

    for (var i = 0; i < wifiList.length; i++) {
        
	var wifi = wifiList[i].split(' ');
	if(wifi.length != 3) {
	    throw new Error(JSON.stringify({
	        'statusCode': 500,
		'body': {
		    'event': 'getWifiList',
		    'details': {
		        'message': 'error parsing wifi list'
		    }
		}
	    }));
	}
	
	const name = wifi[2];
	const signalStrength = parseInt(wifi[0]);
	var doesNotExist = true;
	
        for (var j = 0; j < objWifiList.length; j++) {
	    if(objWifiList[j].name === name) {
		doesNotExist = false;
	        if(objWifiList[j].signalStrength < signalStrength) {
		    objWifiList[j].signalStrength = signalStrength;
		}
	    }
	}

        if(doesNotExist) {
	    objWifiList.push({
	        'name': wifi[2],
	        'signalStrength': signalStrength
	    });
	}
    }
    return objWifiList;
}
