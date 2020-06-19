#!/bin/bash


#Prints information regarding the script and what it does. Prompts user for input which is passed as $url
echo -e "\e[93mThis script provides a report of known hashes linked to detected communicating samples for a URl address\e[0m"
echo -e "\e[36mPlease submit full URL Address below..\e[0m"
echo -e "URLs e.g 'https://google.com' "
read -p "URL: " url
now=$(date) #gets current datetime


#Awk is used for processing the output of information downloaded via urlCheck() and passed to a csv file in the same folder path.
  #$1 is Date, #$2 is Positives, $3 is total positives, $4 is the hash value.

urlParse()
{

  awk 'BEGIN {
    FS = ",";
    printf("\033[33m%29-s %5-s %12-s %70-s %1s \033[0m\n", "| Date", "| Positives ", "| Total ", "| sha256 ", "|")
    print("________________________________________________________________________________________________________________________________")
    print
  }
  {
          printf("| \033[33m %25-s \033[0m | \033[35m %8-d \033[0m | \033[35m %8-d \033[0m | \033[35m %30-s \033[0m |\n", $1, $2, $3, $4)  
  }
  END {
      print("________________________________________________________________________________________________________________________________");
  }' ./urlreport.csv

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

  regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
  
  if [[ $url =~ $regex ]]; then
    echo -e "\e[32mValid URL: $url. Looking up $url against VirusTotal database...\e[0m\n "
    
    apiDomain='https://www.virustotal.com/vtapi/v2/domain/report?'
    apiKey="apikey=${VIRUSTOTAL_API_KEY}" #read env variable for API key
    apiUrl="&domain=${url}"               #specifies url
    curlUrl="$apiDomain$apiKey$apiUrl"    #concatenates outputs

    curl --silent --request GET --url ${curlUrl} | jq --raw-output '.detected_communicating_samples[] | [.date, .positives, .total, .sha256] | @csv' > urlreport.csv
    printf "Report for: $url. Detected communicating samples - $now \n\n" >> urlreporthistory.csv
    cat urlreport.csv >> urlreporthistory.csv
    
    echo -e "\e[46mDetected communicating samples for $url...\e[0m\n"
    urlParse 
    echo -e "\n\n\e[32;1mReport: 'urlreport.csv' created in: ./$PWD\e[0m\n\n"
    exit 0
  else
    echo "Invalid url: ($url). Please enter a valid URL"
    exit 0
  fi

}

#start of script
while true
do
  urlCheck
done