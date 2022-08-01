#!/bin/bash
#SMS with Kannel

message=$(echo $2|sed -e 's/ /%20/g') 
curl --location --request GET  "http://Kannel_ip:13013/cgi-bin/sendsms?username=Kannle_send_sms_suer&password=kannel_send_smsmpass&from=smsc_Account_name&to=$1&text=$message"

