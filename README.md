# Send SMS with Zabbix and Kannel in Linux


On Zabbix you can send an alert through a SMS gateway. This tutorial explains how to setup the Kannel SMPP


What you'll need:

1. Curl
2. Kannel ( setup and integrated with your SMSC)
3. send_sms.sh

```
First create your send_sms.sh 

#!/bin/bash
#SMS with Kannel

message=$(echo $2|sed -e 's/ /%20/g') 
curl --location --request GET  "http://Kannel_ip:13013/cgi-bin/sendsms?username=Kannle_send_sms_suer&password=kannel_send_smsmpass&from=smsc_Account_name&to=$1&text=$message"
```


second : Add the script to Zabbix (Tested on Zabbix Server 5.x):

1. Administration > Media Types
2. Add a new "Script" media Type
```
		Name: Send SMS
		Type: Script
		Script name: send_sms.sh
		Script parameters:
		PARAMETER 1: {ALERT.SENDTO}
		PARAMETER 2: {ALERT.MESSAGE}
		
```


3. on Message template tab add problem and problem recovery you may need to repalce new line in your message with propre chart that your SMSC understands
like : Problem started at {EVENT.TIME}%0D%0AProblem name: {EVENT.NAME}%0D%0AHost: {HOST.NAME}


4. Create an action and make sure it has the "SEND SMS" enabled on it.
5. make sure your user has send_sms enabled on his/her media tab
6. Copy the script `send_sms.sh` to your Zabbix server on: `/usr/lib/zabbix/alertscripts`
7. Add permission to the file:
```
		chmod +x /usr/lib/zabbix/alertscripts/send_sms.sh
		chown zabbix:zabbix /usr/lib/zabbix/alertscripts/send_sms.sh
```

7. Your user's Media should look like (Assuming their Mobile phone is +989308504342)
 /usr/lib/zabbix/alertscripts/send_sms.sh '+989308504342' 'testing'

