#!/bin/bash

IpInfo="$(./IpInfo.sh)"

ipaddress=$(echo "$IpInfo" | sed -n '/IP Address: / {s/IP Address:/IP Address:/p}')


echo -e "IPs are: \n$ipaddress"