#!/bin/bash

#stores the IpInfo.sh file as a variable
IpInfo="$(./IpInfo.sh)"

#this command uses sed to accomplish the following:
    # -n is used for silent modifications
    #  s within the '/IP addr....' is used to substitute the line for a newer line
    #  p within the sed command 'prints' the command
    #  repeating 'IP Address:' twice is done to 1. Establish what line is being used/subd from IpInfo, and;
        # 2. Substituting that with a new 'header'.

ipaddress=$(echo "$IpInfo" | sed -n '/IP Address: / {s/IP Address:/IP Address:/p}')

# this echos the information edited in ipaddress

echo -e "IPs are: \n$ipaddress"