#!/bin/bash

# REFERENCES.
  # Getting started. (2020). VirusTotal API. VirusTotal https://developers.virustotal.com/v3.0/reference#file-info

# 2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824

echo -e "\e[93mThis script retrieves information of a hash\e[0m"
echo -e "\e[93mPlease submit SHA256, SHA1 or MD5 identifying the file..:\e[0m\n"

getHash() {

  #prompts user for URL input.
    read -p "Hash: " file_hash

  #Regular expressions for md5, sha256, sha1
    hashRegex='^(((([a-z,1-9]+)|[0-9,A-Z]+))([^a-z\.]))*'

  #Checks to see if hash is valid to: md5, sha256, sha1
    #if not a valid url, will prompt to enter a valid hash referencing the function.
    if [[ $file_hash =~ $hashRegex ]]; then
        hashCheck
    else
        echo "Invalid url: ($url). Please enter a valid URL"
        getHash
    fi

}

  # hashCheck does the following:
  #  uses cURL to download report of the $file_hash via a GET request of the VirusTotal API using an API key stored in .envrc. 
  #   This API responds as JSON.
  #    JSON is then parsed using jq, jq is like sed for json data.
  #     jq output uses tr to clean up ' " ' and then is parsed to a csv file, saved as '.csv'
  #      '.csv' is appended to urlreporthistory.csv along with the URL and current date time.
  #       hashCheck executes checkParser.sh w/ $hashcheckreport as $1, which prints output on screen.

hashCheck()
{

    apiUrl='https://www.virustotal.com/api/v3/files/'
    curlUrl="$apiUrl$file_hash"

    apiKeyprefix="x-apikey:"
    apiKey=${VIRUSTOTAL_API_KEY}
    xapikey=$apiKeyprefix$apiKey

    mkdir -p ./response
    mkdir -p ./report
    curl --silent --request GET --url ${curlUrl} --header $xapikey | jq --raw-output '.' > ./response/hashcheckresponse.json
    cat ./response/hashcheckresponse.json |  jq --raw-output '.data.attributes.last_analysis_results[] | [.category, .engine_name, .engine_update, .engine_version, .method, .result] | @csv' | tr -d '"' > ./report/hashes/hashcheckreport.csv

    printf "\n\n,,,,,,Report for: $file_hash. Detected communicating samples - $now\n" >> ./report/hashes/hashcheckreporthistory.csv
    cat ./report/hashes/hashcheckreport.csv >> ./report/hashes/hashcheckreporthistory.csv

    echo -e "\e[36mBlocklist results for: $file_hash\e[0m\n"
    hashcheckreport="./report/hashes/hashcheckreport.csv"
    sh ./config/checkParser.sh "$hashcheckreport"
    echo -e "\n\n\e[32;1mReport generated in: $hashcheckreport\e[0m\n\n"
    exit 0
}

#start of script
getHash