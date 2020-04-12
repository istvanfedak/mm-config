# this file returns a json object with a list of all available wifi networks
from subprocess import Popen, PIPE
import json

COMMAND = ['nmcli', 'd', 'wifi', 'list']

def parse(wifiList):
  # responce array
  response = []
  # split by new line
  wifiList = wifiList.split('\n')
  # remove the first and last items of the list
  wifiList.pop(0)
  wifiList.pop()
  # skip the first entry which is the description

  for wifiEntry in wifiList:
    # dictionary representing the entry
    entry = {}
    # split wifi entry into a list of the entry's information
    entryInfo = (' '.join(wifiEntry.split())).split()
    if '*' in entryInfo:
      entry['in-use'] = True
      entryInfo.remove('*')
    else:
      entry['in-use'] = False
    entry['ssid'] = entryInfo[0]
    entry['mode'] = entryInfo[1]
    entry['chan'] = entryInfo[2]
    entry['rate'] = entryInfo[3] + ' ' + entryInfo[4]
    entry['signal'] = entryInfo[5]
    entry['bars'] = entryInfo[6]
    response.append(entry)
  return response

def getWifiList():
  # create a process to read the wifi's from the terminal command
  process = Popen(COMMAND, stdout=PIPE, stderr=PIPE)
  stdout, stderr = process.communicate()
  process.wait()

  # decode the output
  wifiList = stdout.decode('utf-8')

  return parse(wifiList)

print(json.dumps(getWifiList()))
