As suggested in https://github.com/seemoo-lab/nexmon_csi/issues/178

Install scapy:
```sh
sudo su
apt-get install python-pip
pip install scapy
```



```sh
sudo su
pkill wpa_supplicant ; ip link set mon0 down ; ifconfig wlan0 down ; iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor; ifconfig mon0 up ; ifconfig wlan0 up; nexutil -k64/20 ; iw dev

sudo -E python /home/pi/install_nexmon/py_run/tx.py
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbNTQ3MTE2ODkyLC0yNTIzODI0MTgsNTkwNz
k4NDAwLC0xMTE4NDgwNDE0LC0xMjg2MTkwNzAyXX0=
-->