# wifi-handler

Contains all the files necessary files for connecting and disconnecting
from the wifi if the access point is turned on

When the raspberry pi is an access point, it cannot connect to wifi because
it is using wlan0 to transmit the signal.

## connecting to wifi
  This handler does the following:
  1. if the access-point-handler service is running, it stops it
  2. if the access point is on turn it off once you obtain the password
  3. attempt to connect to the wifi
  4. if it fails start up access point
  5. else continue to step 6
  6. start up access-point-handler service

## disconnecting from wifi
  1. stop access-point-handler
  2. disconnect from wifi
  3. start up access point
  4. start up access-point-handler service
  
