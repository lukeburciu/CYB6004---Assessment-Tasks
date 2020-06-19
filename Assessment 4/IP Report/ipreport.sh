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
read -p "IP Address: " ip
ipValid() { 

  # Set up local variables
    local ip=${1:-1.2.3.4}
    local IFS=.; local -a a=($ip)

    # Start with a regex format test
    [[ $ip =~ ^[0-9]+(\.[0-9]+){3}$ ]] || return 1

    # Test values of quads
    local quad
    for quad in {0..3}; do
        [[ "${a[$quad]}" -gt 255 ]] && return 1
    done
    return 0
}


ipCheck()
{
  if ipValid "$ip"; then

    echo -e "\n\e[34;1mValid IP: $ip... Looking up '$ip' against VirusTotal database\e[0m\n"

    apiDomain='https://www.virustotal.com/vtapi/v2/ip-address/report?'
    apiKey="apikey=${VIRUSTOTAL_API_KEY}" #read env variable for API key
    apiIP="&ip=${ip}"                     #specifies IP address
    url="$apiDomain$apiKey$apiIP"         #concatenates outputs
    
    mkdir ./response
    mkdir ./report
    curl --silent --request GET --url ${url} | jq -r '.' > ./response/ipresponse.json
    cat ./response/ipresponse.json | jq --raw-output '.undetected_referrer_samples[] | [.date, .positives, .total, .sha256] | @csv' > ./report/ipreport.csv
    
    #awk -F"," 'BEGIN { OFS = "," } {$5'
    
    printf "\n\n,,,,Report for: $ip. Undetected referrer samples - $now \n" >> ./report/ipreporthistory.csv
    cat ./report/ipreport.csv >> ./report/ipreporthistory.csv
    
    echo -e "\e[46mUndetected referrer samples for $ip\e[0m\n"
    ipreport="./report/ipreport.csv" #specifies ipreport file for reportParser
    sh ../reportParser.sh "$ipreport"
    echo -e "\n\n\e[32;1mReport generated in: $ipreport\e[0m\n\n"
    exit 0
  else
    echo "Invalid IP address: ($ip). Please enter a valid IP address"
    exit 1
  fi
}

#start of the script
ipCheck