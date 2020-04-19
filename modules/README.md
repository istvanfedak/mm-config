# Module structure

Note: the handler module handles all other modules

The modules folder contains all the modules used by mm-config

Modules should be each in their own directory
- README.md file that explains what the module does
  - note all configuration setup should be done in the module bash 
    install script 
- The name of the module should be the name of the directory
- The name of the node js file executable should be within the
  that directory and have the same name as the module
- All scripts should be under a bin folder
  - install, run, stop and uninstall scripts should have the action followed by
    a dash preceding the name of the module
  - all other scripts that your service uses should be stored here

- All the web interface should be stored in a www folder
  - the www directory contents will be copied over to /var/www/html/module-name
    - making your module interface accessible throught the following url:
      - http://magicmirror/module-name/
    - your module can query the config module for its assigned port
      - just do a local host request to port 54321
    - port.json is the port that your service will be run on
      - its set by mm-config-handler
      - when developing a module set it to your favorite port number
      - the user will be able to override the port in the /config/congig.json
        file
        - the mm-config-handler will override that file every time it runs
          your module

### Note: you need to make sure that the port your module is running on doesn't
    conflict with any other
### Note: mm-config-handler is the only module with a default port number 
For example a hello-world module should have the following structure:

## Note: your modules can use the default scripts used in the root 
   mm-config bin directory

modules/
|--- hello-world/
|    | README.md
|    |--- hello-world.js
|    |--- bin/
|    |    |--- install-hello-world.sh
|    |    |--- run-hello-world.sh
|    |    |--- stop-hello-world.sh
|    |    |--- uninstall-hello-world.sh
|    |--- www/
|    |    |--- index.html
|    |    |--- index.css
|    |    |--- index.js

## port.json structure


## mm-config-handler

The first module to be run is the mm-config-handler
- It handles the loading of all modules
- Modules are placed into two categories
  1. run-with-no-wifi
  2. run-with-wifi
- Depending on where you place your module it will either run when the
  raspberry pi is not connected to wifi or when it is.

