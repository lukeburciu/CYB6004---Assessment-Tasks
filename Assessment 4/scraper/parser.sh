#!/bin/bash

# https://stackoverflow.com/questions/55607925/extract-json-value-with-sed

parseResponse() #using jq instead of sed as json is impossible to parse with sed due to the structure of json v txt.
{
    response="$(cat response.json)" # References the file created in searchhash.py

    response_parsed=$("$response" |'.[].domains]'



}