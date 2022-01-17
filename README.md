# shark_jack_payload

A portable network attack and automation tool for pentesters and systems administrators designed to enable social engineering engagements and opportunistic wired network auditing.

# Payload


# How to update

#### 1) Download the last firmware
 - https://downloads.hak5.org/shark

#### 2) Manual Upgrade
 - Power on the Shark Jack in Arming Mode and connect it to a reliable USB power source
 - Copy the firmware to the Shark Jack : ``` scp upgrade-1.1.0.bin root@172.16.24.1:/tmp/ ```
 - SSH into the Shark Jack : ``` ssh root@172.16.24.1 ```
 - Default password for ssh is 'hak5shark'
 - From the Shark Jack's bash prompt, issue the sysupgrade command relevant to your firmware update file : ``` sysupgrade -n /tmp/upgrade-1.1.0.bin ```
 - Wait 5-10 minutes as the Shark Jack flashes the firmware and reboots. DO NOT unplug the device from USB power during this process as doing so will render the device inoperable.



# Shark Jack Operation Modes
![image](https://user-images.githubusercontent.com/26013529/149832744-74d3fb1f-48be-4460-b611-c39c6f2e8a18.png)

Similar to many Hak5 tools, the Shark Jack features an Arming mode and an Attack mode. In Arming mode, the Shark Jack is accessible from SSH for payload loading and configuration. In Attack mode, the selected payload is executed

#### Attack Mode
In attack mode, the Shark Jack will execute the payload.sh or payload.txt bash script from /root/payload. Most payloads specify a network mode, setting the Shark Jack as a client with NETMODE DHCP_CLIENT or a server with NETMODE DHCP_SERVER.

#### Arming Mode
In arming mode, the Shark Jack will be configured with a static IP address of 172.16.24.1 and will start an SSH server.

With the Shark Jack in arming mode, you may access the embedded linux system via SSH. Connect the Shark Jack to your computer's Ethernet interface, specify a static IP address in the 172.16.24.0/24 range for this interface (for example 172.16.24.2) then establish an SSH connection to the Shark Jack at 172.16.24.1 (e.g. with the command "ssh root@172.16.24.1")
