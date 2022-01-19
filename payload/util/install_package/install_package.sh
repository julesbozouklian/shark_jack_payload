#!/bin/sh
# Title:         Install package
# Description:   This payload will install the specified package using opkg.
# Author:        Jules Bozouklian - bozou_client
# Version:       1.0
# Category:      Template
#
# LED SETUP (Magenta)... Setting logs and waiting for IP address from DHCP
# LED FAIL (Red Blink)... Failed to update opkg or install package
# LED SPECIAL (Cyan Blink)... Saving list of package to log file
# LED FINISH (Green Fast Blink to Solid)... Package install or listsuccessful
#

PACKAGE_TO_INSTALL="nano curl"
LOG_DIR=/root/loot/install_package
TIMESTAMP=`date +"%Y-%m-%d"`

function FAIL() {
  LED FAIL;
  exit;
}

function SUCCESS() {
  LED FINISH;
  exit;
}

LED SETUP

NETMODE DHCP_CLIENT

# Make log file
mkdir -p $LOG_DIR
LOG_FILE=$TIMESTAMP"_$(find $LOG_DIR -type f | wc -l).log"

DISK_SPACE_BEFORE=$(df -h | grep overlayfs | awk {'print $4'})
LOG="$LOG_DIR/$LOG_FILE"

# Wait until Shark Jack has an IP address
while [ -z "$IPADDR" ]; do sleep 1 && IPADDR=$(ifconfig eth0 | grep "inet addr"); done

# Install package
echo -e "#\n#\n# Installing Package: $PACKAGE_TO_INSTALL\n#\n#" >> $LOG
opkg install $PACKAGE_TO_INSTALL >> $LOG 2>&1 || FAIL

# Finalizing log file
echo -e "#\n#\n# Payload Complete \n#\n#\n\
# Disk space free before: $DISK_SPACE_BEFORE\n\
# Disk space free after: $(df -h | grep overlayfs | awk {'print $4'})" >> $LOG

SUCCESS
