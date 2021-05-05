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
pkill wpa_supplicant ; ifconfig wlan0 down ; iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor; ifconfig mon0 up ; nexutil -k48/20 ; iw dev

sudo -E python /home/pi/install_nexmon/py_run/tx.py
```

If it's the second run (to change to other channel without reboot): 
```sh
sudo su
pkill wpa_supplicant ; ip link set mon0 down ; ifconfig wlan0 down ; iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor; ifconfig mon0 up ; ifconfig wlan0 up; nexutil -k48/20 ; iw dev

sudo -E python /home/pi/install_nexmon/py_run/tx.py
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTI2MzQwNTU2NiwxMDUyMTU4NTcxLDI1Mj
c0OTE0MiwxMTk2MDMxNDQ3LDU0NzExNjg5MiwtMjUyMzgyNDE4
LDU5MDc5ODQwMCwtMTExODQ4MDQxNCwtMTI4NjE5MDcwMl19
-->