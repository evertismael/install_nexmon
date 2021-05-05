# Problems and helpful code:

### Configure wireless network (If WAN is wireless and LAN is wired)
```sh
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
```
- add the following at the end:
```
network={
    ssid="Advenir"
    psk="4982709LP"
}
network={
    ssid="Honor_5G"
    psk="Honor0010"
}
```
```sh
wpa_cli -i wlan0 reconfigure
```
### If wlan0 up throws this error: SIOCSIFFLAGS: Operation not possible due to RF-kill
```sh
rfkill list all
sudo rfkill unblock all
sudo ip link set wlan0 up
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbNTgxNDY2MDU5XX0=
-->