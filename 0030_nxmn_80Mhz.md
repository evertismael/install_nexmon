# Transmit in a 80MHz bandwidth:
* Notice that we don't use Nexmon to do frame injection. We set a normal rpi instead. The setup consists of 3 elements:
	* Router 1: It properly opens a wifi network on channel 36 with 80MHz bandwidth. It should be configured to support protocols 802.11a/b/g/ac (or just 802.11ac is fine too).
	* Tx-rpi: A rpi (with a normal installation) is connected to the network opened by the Router-1, and sends ICMP packets to the router at a specific rate. This file is meant to set-up properly the 'Tx-rpi'.
	* N-rpi's: These rpi's are sniffers, i.e., they listen to the communication between Tx-rpi and the router. Notice that these rpi's are NOT connected to the network opened by the Router 1. In fact they are connected to a totally private/
	* 
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE5Mzg3NTY3OTksODE1Mjk0NTkwLC0xMz
M1MTQ2Njk2LDY4NTM4MzkwOCwtMTk0MTI5MjU3NSw5NjQ5NjQz
MjYsLTE5ODI1NDI4NDAsMTY4NzczNTIwNywzMzM2NDE1MDgsMT
MyMjk0OTM2OCwtMzYzMTc5NTc5LDE2NTkwODI2MzgsMTkwOTA2
NDE4OCwtMTg5OTQ4MTQ5NywtMTMyNDA3MDQyOSwtMTk4Mzc3OT
cxNiwtNjkwMzQyODYxLDEwNzQ5MDMzODEsNTgxNTM3ODAxLDE1
Mzg1OTM5MTVdfQ==
-->