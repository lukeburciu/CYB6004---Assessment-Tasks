#!/bin/bash

# REFERENCES.
  # Getting started. (2020). VirusTotal API. VirusTotal. https://developers.virustotal.com/reference
  # ghoti. (2017).  Check for IP validity. Stack Overflow. https://stackoverflow.com/questions/13777387/check-for-ip-validity

# GLOBAL.
now=$(date) #gets current datetime

#Prints information regarding the script and what it does.
echo -e "\e[93mThis script provides a report of known hashes linked to an IP address\e[0m"
echo -e "\e[93mSubmit IPv4 Address below..:\e[0m\n"
echo -e "\e[35;1mIPs e.g: 0.0.0.0 - 255.255.255.255'\e[0m\n "

#prompts User for IP address input.
ipValid() { 

   read -p "IP Address: " ip

  #Regular expressions for IP address
    ipRegex='\b([0-9]{1,3}\.){3}[0-9]{1,3}\b'

  #Checks to see if IP is valid
    #if not a valid IP, will prompt to enter a valid IP referencing the function.
    if [[ $ip =~ $ipRegex ]]; then
        ipCheck
    else
        echo "Invalid IP address: ($ip). Please enter a valid IP address"
        ipValid
    fi
}

  # ipCheck does the following:
  #  uses cURL to download report of the $url via a GET request of the VirusTotal API using an API key stored in .envrc. 
  #   This API responds as JSON.
  #    JSON is then parsed using jq, jq is like sed for json data.
  #     jq output uses tr to clean up ' " ' and then is parsed to a csv file, saved as '.csv'
  #      '.csv' is appended to ipreporthistory.csv along with the URL and current date time.
  #       ipCheck passes $ipreport to reportParser.sh (as $1), which is printed on screen.

ipCheck()
{
  

    echo -e "\n\e[34;1mValid IP: $ip... Looking up '$ip' against VirusTotal database\e[0m\n"

    apiDomain='https://www.virustotal.com/vtapi/v2/ip-address/report?'
    apiKey="apikey=${VIRUSTOTAL_API_KEY}" #read env variable for API key
    apiIP="&ip=${ip}"                     #specifies IP address
    url="$apiDomain$apiKey$apiIP"         #concatenates outputs
      
    mkdir -p ./response
    mkdir -p ./report
    curl --silent --request GET --url ${url} | jq -r '.' > ./response/ipresponse.json
    cat ./response/ipresponse.json | jq --raw-output '.undetected_referrer_samples[] | [.date, .positives, .total, .sha256] | @csv' | tr -d '"' > ./report/ips/ipreport.csv
      
    #awk -F"," 'BEGIN { OFS = "," } {$5'
      
    printf "\n\n,,,,Report for: $ip. Undetected referrer samples - $now \n" >> ./report/ips/ipreporthistory.csv
    cat ./report/ips/ipreport.csv >> ./report/ips/ipreporthistory.csv
      
    echo -e "\e[46mUndetected referrer samples for $ip\e[0m\n"
    ipreport="./report/ips/ipreport.csv" #specifies ipreport file for reportParser
    sh ./config/reportParser.sh "$ipreport"
    echo -e "\n\n\e[32;1mReport generated in: $ipreport\e[0m\n\n"
    exit 0

}

#start of the script
ipValid