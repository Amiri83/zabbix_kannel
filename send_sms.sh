#!/bin/bash
#SMS with Kannel

message=$(echo $2|sed -e 's/ /%20/g') 
curl --location --request GET  "http://Kannel_ip:13013/cgi-bin/sendsms?username=simple&password=simple1&from=smsc_Account_name&to=$1&text=$message"

