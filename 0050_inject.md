As suggested in https://github.com/seemoo-lab/nexmon_csi/issues/178

Install scapy:
```sh
sudo su
apt-get install python-pip
pip install scapy
```
Important: Something weird happens when I run ```iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor``` , I get an error: `-95` and It doesn't transmit anymore even-though scapy works properly.
 
If it's 
Run:
```sh
sudo su
pkill wpa_supplicant ; ip link set mon0 down ; ifconfig wlan0 down ; iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor; ifconfig mon0 up ; ifconfig wlan0 up; nexutil -k48/20 ; iw dev

sudo -E python /home/pi/install_nexmon/py_run/tx.py
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTk1OTM0MzEwNywxMDUyMTU4NTcxLDI1Mj
c0OTE0MiwxMTk2MDMxNDQ3LDU0NzExNjg5MiwtMjUyMzgyNDE4
LDU5MDc5ODQwMCwtMTExODQ4MDQxNCwtMTI4NjE5MDcwMl19
-->