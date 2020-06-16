#!/bin/bash



echo -e "\e[93mSubmit URL Address to be scanned\e[0m"
echo -e "URLs e.g 'hxxps://www[.]google[.]com' "
read -p "URL: " url


#URL Regex check
urlvalid() 
{
  local inputUrl=${1}

  [[ $inputUrl =~ https?:// ]] || return 0

}

urlCheck()
{

  if urlvalid "$url"; then
    echo -e "Valid $url. Looking up $url against VirusTotal database"
    apiDomain='https://www.virustotal.com/vtapi/v2/domain/report?'
    apiKey="apikey=${VIRUSTOTAL_API_KEY}"
    apiUrl="&domain=${url}"
    curlUrl="$apiDomain$apiKey$apiUrl"

    curl --request GET --url ${curlUrl} | jq -r '.[]' > urlreport.json
    exit 0
  else
    echo "Not a valid url: ($curlUrl)"
    exit 1
  fi
}

urlCheck