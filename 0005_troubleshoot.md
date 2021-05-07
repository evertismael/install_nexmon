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

### mount usb:
```sh
apt-get install libpcap-dev

sudo mkdir /media/usbstick
mount -t vfat -o rw /dev/sda1 /media/usbstick/
cd /media/usbstick  
ls -l

```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIyMjkzOTQ2MCw1ODE0NjYwNTldfQ==
-->