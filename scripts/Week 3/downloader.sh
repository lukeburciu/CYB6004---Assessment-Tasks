#!/bin/bash

#    prompt the user to type a website URL to download or type “exit” to quit.”
#    prompt the user to type a download location
#    use wget to download the webpage requested by the user
#    repeat the process until the user types “exit”.


while read -p "Please type the URL of a file to download or type 'exit' to quit: " url
do
    if [ "$url" == "exit" ]; then
        break
    else
        wget "$url"
    fi
done