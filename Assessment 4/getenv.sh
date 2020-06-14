#!/bin/bash

#. ENV VARIABLES (API keys stored in .envrc, )

# API Key:          $HYBRID_API_KEY
# API Server:       $HYBRID_SERVER
# User Agent:       $USR_AGENT

#Specifying Colours for reference



# Gather data about the systems execution enviornment
getEnv()
{
    curl -X POST "https://www.hybrid-analysis.com/api/v2/system/environments" \
    -H  "accept: application/json" \
    -H  "user-agent: $USR_AGENT" \
    -H  "api-key: $HYBRID_API_KEY" | jq '.[].id'
}
getEnv





