As suggested in https://github.com/seemoo-lab/nexmon_csi/issues/178

Install scapy:
```sh
sudo su
apt-get install python-pip
pip install scapy
```
Run:
```sh
sudo su
pkill wpa_supplicant ; ip link set mon0 down ; ifconfig wlan0 down ; iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor; ifconfig mon0 up ; ifconfig wlan0 up; nexutil -k48/20 ; iw dev

sudo -E python /home/pi/install_nexmon/py_run/tx.py
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTA1MjE1ODU3MSwyNTI3NDkxNDIsMTE5Nj
AzMTQ0Nyw1NDcxMTY4OTIsLTI1MjM4MjQxOCw1OTA3OTg0MDAs
LTExMTg0ODA0MTQsLTEyODYxOTA3MDJdfQ==
-->