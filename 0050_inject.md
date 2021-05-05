As suggested in https://github.com/seemoo-lab/nexmon_csi/issues/178

Install scapy:
```sh
sudo su
apt-get install python-pip
pip install scapy
```



```sh
sudo su
pkill wpa_supplicant ; ip link set mon0 down ; ifconfig wlan0 down ; iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor; ifconfig mon0 up ; ifconfig wlan0 up

# configure the channel
nexutil -k52/20 ; iw dev

cd /home/pi/install_nexmon/py_run/
sudo -E python tx.py
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTI1MjM4MjQxOCw1OTA3OTg0MDAsLTExMT
g0ODA0MTQsLTEyODYxOTA3MDJdfQ==
-->