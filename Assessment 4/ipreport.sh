#!/bin/bash



echo -e "\e[93mSubmit IPv4 Address to be scanned:\e[0m\n"
echo -e "\e[35;1mIPs e.g: 0.0.0.0 - 255.255.255.255'\e[0m\n "
read -p "IP Address: " ip


ipvalid() { # https://stackoverflow.com/questions/13777387/check-for-ip-validity

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
  if ipvalid "$ip"; then
    echo
    echo -e "\e[34;1mValid IP: $ip... Looking up '$ip' against VirusTotal database\e[0m "
    apiDomain='https://www.virustotal.com/vtapi/v2/ip-address/report?'
    apiKey="apikey=${VIRUSTOTAL_API_KEY}"
    apiIP="&ip=${ip}"
    url="$apiDomain$apiKey$apiIP"

    curl --silent --request GET --url ${url} | jq -r '.' > ipreport.json 
    cat ipreport.json | jq -r '.'
    echo
    echo -e "\e[33;1mReport: 'ipreport.json' created in: $PWD\e[0m\n\n"
    exit 0
  else
    echo "Not a valid IP address: ($ip)"
    exit 1
  fi
}

ipCheck