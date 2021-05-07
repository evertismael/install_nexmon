As suggested in https://github.com/seemoo-lab/nexmon_csi/issues/178

Install scapy:
```sh
sudo su
apt-get install python-pip
pip install scapy
```
Important: Something weird happens when I run ```iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor``` , I get an error: `-95` and It doesn't transmit anymore even-though scapy works properly.
 
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
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTExMjk0MjUzMDIsLTEyNTc3NjM5OTEsMT
A1MjE1ODU3MSwyNTI3NDkxNDIsMTE5NjAzMTQ0Nyw1NDcxMTY4
OTIsLTI1MjM4MjQxOCw1OTA3OTg0MDAsLTExMTg0ODA0MTQsLT
EyODYxOTA3MDJdfQ==
-->