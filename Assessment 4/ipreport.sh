#!/bin/bash


echo -e "\e[93mThis script provides a report of known hashes linked to an IP address\e[0m"
echo -e "\e[93mSubmit IPv4 Address below..:\e[0m\n"
echo -e "\e[35;1mIPs e.g: 0.0.0.0 - 255.255.255.255'\e[0m\n "
read -p "IP Address: " ip
now=$(date) #gets current datetime

ipValid() { # https://stackoverflow.com/questions/13777387/check-for-ip-validity

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

    curl --silent --request GET --url ${url} | jq --raw-output '.detected_communicating_samples[] | [.date, .positives, .total, .sha256] | @csv' > ipreport.csv
    printf "Report for: $ip. Detected communicating samples - $now \n\n" >> ipreporthistory.csv
    cat ipreport.csv >> ipreporthistory.csv
    
    echo -e "\e[46mDetected communicating samples for $ip...\e[0m\n"
    ipParse
    echo -e "\e[33;1mReport: 'ipreport.json' created in: $PWD\e[0m\n\n"
    exit 0
  else
    echo "Invalid IP address: ($ip). Please enter a valid IP address"
    exit 1
  fi
}

ipCheck