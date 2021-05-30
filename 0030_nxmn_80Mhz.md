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

* Clone the repository:

```sh
sudo su
git clone https://github.com/evertismael/install_nexmon.git
```
*  
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEwMjU2MzI4OTYsODE1Mjk0NTkwLC0xMz
M1MTQ2Njk2LDY4NTM4MzkwOCwtMTk0MTI5MjU3NSw5NjQ5NjQz
MjYsLTE5ODI1NDI4NDAsMTY4NzczNTIwNywzMzM2NDE1MDgsMT
MyMjk0OTM2OCwtMzYzMTc5NTc5LDE2NTkwODI2MzgsMTkwOTA2
NDE4OCwtMTg5OTQ4MTQ5NywtMTMyNDA3MDQyOSwtMTk4Mzc3OT
cxNiwtNjkwMzQyODYxLDEwNzQ5MDMzODEsNTgxNTM3ODAxLDE1
Mzg1OTM5MTVdfQ==
-->