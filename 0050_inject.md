As suggested in https://github.com/seemoo-lab/nexmon_csi/issues/178

Install scapy:
```sh
sudo su
apt-get install python-pip
pip install scapy
```
Important: Something happens when I run `
Run:
```sh
sudo su
pkill wpa_supplicant ; ip link set mon0 down ; ifconfig wlan0 down ; iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor; ifconfig mon0 up ; ifconfig wlan0 up; nexutil -k48/20 ; iw dev

sudo -E python /home/pi/install_nexmon/py_run/tx.py
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbNjA0MzA4NTgyLDEwNTIxNTg1NzEsMjUyNz
Q5MTQyLDExOTYwMzE0NDcsNTQ3MTE2ODkyLC0yNTIzODI0MTgs
NTkwNzk4NDAwLC0xMTE4NDgwNDE0LC0xMjg2MTkwNzAyXX0=
-->