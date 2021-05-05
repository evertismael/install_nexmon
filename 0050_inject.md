As suggested in https://github.com/seemoo-lab/nexmon_csi/issues/178

Install scapy:





```sh
sudo iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor
sudo ifconfig mon0 up
nexutil -k7
sudo -E python tx.py
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbNjM3NDgyOTEzLC0xMjg2MTkwNzAyXX0=
-->