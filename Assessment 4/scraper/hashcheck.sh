#!/bin/bash

#. ENV VARIABLES (API keys stored in .envrc, )

# API Key:          $HYBRID_API_KEY
# API Server:       $HYBRID_SERVER
# User Agent:       $USR_AGENT

#Specifying Colours for reference



# example hash: 35047ad869607de0a52d54be5998f268c719bb655e168f9bff8356b1f1239c55
# Gather and format data pulled from server. Function to allow user to search for a hash for a file
searchHash()
{
    
    echo -e "\e[93mSEARCH HASH - Summary for a given hash\e[0m"
    echo -e "MD5/SHA1/SHA256 Supported"
    read -p "hash: " inputHash
    inputUrl="/search/hash"
    exec python3 requestor.py "$inputHash" "$inputUrl" 

}






















