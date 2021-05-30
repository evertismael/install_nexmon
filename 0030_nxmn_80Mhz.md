# Transmit in a 80MHz bandwidth:
* Notice that we don't use Nexmon to do frame injection. We set a normal rpi instead. The setup consists of 3 elements:
	* Router 1: It properly opens a wifi network on channel 36 with 80MHz bandwidth. It should be configured to support protocols 802.11a/b/g/ac (or just 802.11ac is fine too).
	* Tx-rpi: A rpi (with a normal installation) is connected to the network opened by the Router-1, and sends ICMP packets to the router at a specific rate. This file is meant to set-up properly the 'Tx-rpi' (See next section).
	* N-rpi's: These rpi's are sniffers, i.e., they listen to the communication between Tx-rpi and the router. These rpi's use Nexmon CSI to collect the channel state information (To see how to install Nexmon csi see "0010_nxmn_csi.md") . Notice that these rpi's are NOT connected to the network opened by the Router 1. In fact they are connected to a totally private/separate network.

# Setting up the transmitter:

* Burn a normal image downloaded from rpi-web page. We use the same image as 
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTk2ODUzMTcxMCw4MTUyOTQ1OTAsLTEzMz
UxNDY2OTYsNjg1MzgzOTA4LC0xOTQxMjkyNTc1LDk2NDk2NDMy
NiwtMTk4MjU0Mjg0MCwxNjg3NzM1MjA3LDMzMzY0MTUwOCwxMz
IyOTQ5MzY4LC0zNjMxNzk1NzksMTY1OTA4MjYzOCwxOTA5MDY0
MTg4LC0xODk5NDgxNDk3LC0xMzI0MDcwNDI5LC0xOTgzNzc5Nz
E2LC02OTAzNDI4NjEsMTA3NDkwMzM4MSw1ODE1Mzc4MDEsMTUz
ODU5MzkxNV19
-->