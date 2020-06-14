#!/bin/bash

#. ENV VARIABLES (API keys stored in .envrc.

apiKey=$HYBRID_API_KEY
apiSecret=$HYBRID_API_SECRET
apiServer=$HYBRID_SERVER
apiLogin=$HYBRID_LOGIN


curl -v -H "apikey: $apiKey" $apiServer
