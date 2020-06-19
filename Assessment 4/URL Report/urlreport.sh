#!/bin/bash

# REFERENCES.
  # Getting started. (2020). VirusTotal API. VirusTotal https://developers.virustotal.com/reference
  # Url checker with or without http:// or https://. (n.d.). RegEx Testing. Dan's Tools. https://www.regextester.com/93652

# GLOBAL.
now=$(date) #gets current datetime
 
#Prints information regarding the script and what it does.
echo -e "\e[93mThis script provides a report of known hashes linked to detected communicating samples for a URl address\e[0m"
echo -e "\e[36mPlease submit full URL Address below..\e[0m"
echo -e "Example URLs: google.com, https://google.com, http://google.com"
#read -p "URL: "


getUrl() {

  #prompts user for URL input.
  read -p "URL: " url

  #Regular expressions for prefix/no prefix.
  prefixRegex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
  noprefixRegex='[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?'

  #Checks to see if url has a prefix or not. If not, will append https:// to the beginning.
    #if not a valid url, will prompt to enter a valid URL referencing the function.
  if [[ $url =~ $prefixRegex ]]; then
    urlCheck
  elif [[ $url =~ $noprefixRegex ]]; then
    url="https://$url"
    urlCheck
  else
    echo "Invalid url: ($url). Please enter a valid URL"
    getUrl
  fi

}

  # urlCheck does the following:
  # 1. does a regular expression check to ensure the url passed is a real URL. If not valid URL, exits
  # 2. uses cURL to download report of the $url via a GET request of the VirusTotal API using an API key stored in .envrc. 
  #   2a. This API responds as JSON.
  #   2b. JSON is then parsed using jq, jq is sed for json.
  #   2c. jq output is parsed to a csv file, saved as 'urlreport.csv'
  #   2d. urlreport.csv is appended to urlreporthistory.csv along with the URL and current date time.
  # 3. urlCheck passes function to urlParse, which is printed to bash.

urlCheck()
{

  echo -e "\e[32mValid URL: $url. Looking up $url against VirusTotal database...\e[0m\n "
  
  apiDomain='https://www.virustotal.com/vtapi/v2/domain/report?'
  apiKey="apikey=${VIRUSTOTAL_API_KEY}" #read env variable for API key
  apiUrl="&domain=${url}"               #specifies url
  curlUrl="$apiDomain$apiKey$apiUrl"    #concatenates outputs

  mkdir ./response
  mkdir ./report
  curl --silent --request GET --url ${curlUrl} | jq --raw-output '.' > ./response/urlresponse.json
  cat ./response/urlresponse.json | jq --raw-output '.detected_communicating_samples[] | [.date, .positives, .total, .sha256] | @csv' > ./report/urlreport.csv
    
  printf "\n\n,,,,Report for: $url. Detected communicating samples - $now\n" >> ./report/urlreporthistory.csv
  cat ./report/urlreport.csv >> ./report/urlreporthistory.csv
    
  echo -e "\e[46mDetected communicating samples for $url\e[0m\n"
  urlreport="./report/urlreport.csv" #specifies urlreport file for reportParser
  sh ../reportParser.sh "$urlreport"
  echo -e "\n\n\e[32;1mReport generated in: $urlreport\e[0m\n\n"
  exit 0
}

#start of the script
getUrl
