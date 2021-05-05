As suggested in https://github.com/seemoo-lab/nexmon_csi/issues/178

Install scapy:
```sh
sudo su
apt-get install python-pip
pip install scapy
```



```sh
sudo iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor
sudo ifconfig mon0 up
nexutil -k7
sudo -E python tx.py
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTExMTg0ODA0MTQsLTEyODYxOTA3MDJdfQ
==
-->