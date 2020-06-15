#!/bin/bash


urlCheck()
{

 echo -e "\e[93mSubmit URL - Submit URL to be scanned\e[0m"
    echo -e "full url e.g: 'hxxps://www[.]google[.]com/' "
    read -p "URL: " inputUrl
    inputUrl="/submit/url/"
    #exec python3 requestor.py "$inputHash" "$inputUrl" 


curl -X POST "https://www.hybrid-analysis.com/api/v2/submit/url"/
 -H  "accept: application/json" /
 -H  "user-agent: $USR_AGENT" /
 -H  "api-key: $HYBRID_API_KEY" /
 -H  "Content-Type: application/x-www-form-urlencoded" /
 -d  "url=https%3A%2F%2Fgoogle.com&environment_id=300&no_share_third_party=true&allow_community_access=false&no_hash_lookup=false&action_script=default&email=me%40kjashdkjsadhkjsa.naet.aua&comment=%23exampleoutput" /
 -d  "url=$inputUrl"

}
