#!/usr/bin/python3

#list of libraries to be used
import requests
import os
import sys
import json
import time
from pathlib import Path as responsePath


def searchHash():
  
  #scrape.sh carries commandline argument to script
  inputHash = sys.argv[1] 
  apiUrl = sys.argv[2]
    
  # os library accesses environment variables
  baseUrl = os.environ.get('HYBRID_SERVER')
  #apiUrl = "/search/hash"
  API_KEY = os.environ.get('HYBRID_API_KEY')
  USER_AGENT = os.environ.get('USR_AGENT')

  # used to join baseUrl and apiUrl
  url= ''.join([baseUrl, apiUrl])
  
  #time of day
  #datetime = str(time.strftime("%Y%m%d-%H%M%S"))

  # Headers used in requests made to the API. 
    # Uses an API to sort through hashes, 
    # sends normal URL encoded request, pretending to be a win10, mozilla client ($USR_AGENT), 
    # and accepts response in json (application/json)
  
  headers = {
      'api-key': f'{API_KEY}',
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
      'user-agent': f'{USER_AGENT}',
      'accept': 'application/json',
  }

  # Data to be sent in the API call
    #Receives input hash from scrape.sh
  data = {
    'hash': f'{inputHash}'
  }

  #API call command using above parameters
  response = requests.post(f'{url}',headers=headers, data=data)
  response_json = response.json()
  #response_name = datetime + '_' + str(response.status_code) + '_' + 'response' + '.txt'
  #responsePath("./APIResponse-output").mkdir(parents=True, exist_ok=True)
  #os.chdir(responsePath)

  with open('response.json', 'w') as f:
    if(response.status_code == 200):
      print("Successful response from server. Status code:", response.status_code)
      json.dump(response_json, f, indent=4, sort_keys=True)
      #print(response_json)
      #os.system("cat response.json | jq -r '.[].domains[]")
    else:
      print("Unable to grab data due to error", response.status_code)
     
    

  
if __name__ == "__main__":
    searchHash()
  
