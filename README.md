# Send SMS Alerts with Zabbix and Kannel

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Shell](https://img.shields.io/github/languages/top/Amiri83/zabbix_kannel)

Send SMS alerts directly from Zabbix using **Kannel SMPP Gateway**. This guide shows how to set up a Bash script that uses `curl` to send messages via Kannel.

---

## 🧰 Requirements

- `curl` installed
- Kannel (configured and integrated with your SMSC)
- `send_sms.sh` script

---

## 📝 Script Example (`send_sms.sh`)

```bash
#!/bin/bash
# Send SMS via Kannel

message=$(echo $2 | sed -e 's/ /%20/g') 
curl --location --request GET \
  "http://KANNEL_IP:13013/cgi-bin/sendsms?username=USERNAME&password=PASSWORD&from=SMSC_ACCOUNT&to=$1&text=$message"
```
## ⚙️ Zabbix Integration (Tested on Zabbix Server 5.x)

1. Add Script as Media Type
Go to: Administration > Media Types

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

