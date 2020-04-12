# this file returns a json object with a list of all available wifi networks
from subprocess import Popen, PIPE

def connectToWifi(wifi, password):
  # create a process to connect to the given wifi
  process = Popen(
    ['nmcli', 'd', 'wifi', 'connect', wifi, 'password', password], 
    stdout=PIPE, 
    stderr=PIPE
  )
  stdout, stderr = process.communicate()
  process.wait()

  # decode the output
  response = stdout.decode('utf-8')
  print(response)

connectToWifi('VFG', 'repulok2016')
