# Step 1: Collection of Channel State Information CSI using nexmon_csi:

## Steps to Install the tool (device used: rpi4, 4GB)
- _Important:_ `Don't update the firmware cause nexmon doesn't support latest version of raspiOS, don't use 
#_sudo apt-get upgrade_`.
- If using cable for local network and Wifi for updates/installs then ensure dhcp of wired-network is not 
provided. Otherwise there is two gateways. -Source 1: https://github.com/nexmonster/nexmon_csi/tree/pi-5.4.51
-Source 2: https://github.com/nexmonster/nexmon_csi/tree/pi-4.19.97#get-kernel-headers


Configure wireless network (If WAN is wireless and LAN is wired)

