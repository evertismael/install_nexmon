# Transmit in a 80MHz bandwidth:
* Notice that we don't use Nexmon to do frame injection. We set a normal rpi instead. The setup consists of 3 elements:
	* Router 1: It properly opens a wifi network on channel 36 with 80MHz bandwidth. It should be configured to support protocols 802.11a/b/g/ac (or just 802.11ac is fine too).
	* Tx-rpi: A rpi (with a normal installation) is connected to the network opened by the Router-1, and sends ICMP packets to the router at a specific rate. This file is meant to set-up properly the 'Tx-rpi' (See next section).
	* N-rpi's: These rpi's are sniffers, i.e., they listen to the communication between Tx-rpi and the router. These rpi's use Nexmon CSI to collect the channel state information (To see how to install Nexmon csi see "0010_nxmn_csi.md") . Notice that these rpi's are NOT connected to the network opened by the Router 1. In fact they are connected to a totally private/separate network.

# Setting up the transmitter:

* Burn a normal image downloaded from rpi-web page. We use the same image as wit the sniffers rpi's.  Kernel version: 5.4.83-v7l+.
```sh
sudo su
sudo apt-get update
sudo apt python3 python3-pip git
pip install scapy
sudo reboot
```
* Ensure that the rpi connects to the wifi network (See 0005_troubleshoot for proper configuration of wlan0 interface).

* After being connected to the wifi, check the channel and bandwidth:
```sh
sudo su
iw dev

output: 

```

* Clone the repository:
```sh
sudo su
git clone https://github.com/evertismael/install_nexmon.git
```
* Important: Something weird happens when I run ```iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor``` , I get an error: `-95` and It doesn't transmit anymore even-though scapy works properly.
 
If it's the first run (immediately after reboot): 
```sh
sudo su
pkill wpa_supplicant ; ifconfig wlan0 down ; iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor; ifconfig mon0 up ; nexutil -k36/20 ; iw dev

sudo -E python /home/pi/install_nexmon/py_run/tx.py
```

If it's the second run (to change to other channel without reboot): 
```sh
sudo su
nexutil -k48/20 ; iw dev
sudo -E python /home/pi/install_nexmon/py_run/tx.py
```
* 
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTcxNzk3MzQ3Nyw4MTUyOTQ1OTAsLTEzMz
UxNDY2OTYsNjg1MzgzOTA4LC0xOTQxMjkyNTc1LDk2NDk2NDMy
NiwtMTk4MjU0Mjg0MCwxNjg3NzM1MjA3LDMzMzY0MTUwOCwxMz
IyOTQ5MzY4LC0zNjMxNzk1NzksMTY1OTA4MjYzOCwxOTA5MDY0
MTg4LC0xODk5NDgxNDk3LC0xMzI0MDcwNDI5LC0xOTgzNzc5Nz
E2LC02OTAzNDI4NjEsMTA3NDkwMzM4MSw1ODE1Mzc4MDEsMTUz
ODU5MzkxNV19
-->