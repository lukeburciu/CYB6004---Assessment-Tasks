#!/bin/bash


hashCheck()
{
set -x
 echo -e "\e[93mSubmit URL - Submit URL to be scanned\e[0m"
    echo -e "full url e.g: 'hxxps://www[.]google[.]com/' "
    read -p "URL: " inputUrlread
    #exec python3 requestor.py "$inputHash" "$inputUrl" 

    inputUrl="${inputUrlprefix}${inputUrlread}&${environment_id}"


curl --request POST \
  --url 'https://www.virustotal.com/vtapi/v2/url/scan' \
  --data "apikey=${VIRUSTOTAL_API_KEY}" \
  --data "url=${inputUrlread}"

set +x
}


hashCheck