# Step 1: Collection of Channel State Information CSI using nexmon_csi:


## Steps to Install the tool (device used: rpi4, 4GB)
- _Important:_ `Don't update the firmware cause nexmon doesn't support latest version of raspiOS, don't use #_sudo apt-get upgrade_`.
- If using cable for local network and Wifi for updates/installs then ensure dhcp of wired-network is not provided. Otherwise there is two gateways.
-Source 1: https://github.com/nexmonster/nexmon_csi/tree/pi-5.4.51
-Source 2: https://github.com/nexmonster/nexmon_csi/tree/pi-4.19.97#get-kernel-headers

Configure wireless network (If WAN is wireless and LAN is wired)
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
    ssid="Advenir-5G"
    psk="2NB244200279"
}
network={
    ssid="Honor_5G"
    psk="Honor0010"
}
```
```sh
wpa_cli -i wlan0 reconfigure
```
- if wlan0 up throws this error: SIOCSIFFLAGS: Operation not possible due to RF-kill
```sh
rfkill list all
sudo rfkill unblock all
sudo ip link set wlan0 up
```


Install dependencies:
```sh
sudo apt-get update

sudo apt install git libgmp3-dev gawk qpdf bc bison flex libssl-dev make automake texinfo libtool-bin tcpdump tmux openssl libncurses5-dev

sudo reboot
```
Install proper heraders for the kernel version:

```sh
sudo wget https://raw.githubusercontent.com/RPi-Distro/rpi-source/master/rpi-source -O /usr/local/bin/rpi-source && sudo chmod +x /usr/local/bin/rpi-source && /usr/local/bin/rpi-source -q --tag-update

rpi-source
sudo reboot
```

Download Nexmon CSI and install instructions:
```sh
sudo su
git clone https://github.com/seemoo-lab/nexmon.git
git clone https://github.com/evertismael/install_nexmon.git
```



Install nexmon and nexmon_csi:
```sh
sudo su
cp install_nexmon/0010_links.sh ./
tmux new -c /home/pi -s nexmon 'bash 0010_links.sh | tee 0010.log'
```

```sh
sudo su
cp install_nexmon/0020_install_nexmon.sh ./
tmux new -c /home/pi -s nexmon 'bash 0020_install_nexmon.sh | tee 0020.log'
```

- check if install was sucessful:
```sh
sudo journalctl -b | grep brcmfmac

output: Apr 28 23:27:34 Amber4GB kernel: brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Apr 28 2021 23:27:00 version 7.45.189 (nexmon.org/csi: v0.1.1-5-g9d86-1)
```
## Simple test - No filtering (Listen to all data in the ether)
- _Important:_ Router is configured with a specific channel and bandwidth (161/40) in this case

```sh
ip link set mon0 down
ifconfig wlan0 down
ifconfig wlan0 up 
iw dev wlan0 interface add mon0 type monitor
ip link set mon0 up 
CFG_STR=$(mcp -c 36/80 -C 1 -N 1) 
nexutil -I wlan0 -s 500 -b -l 34 -v $CFG_STR 
nexutil -k
tcpdump -i wlan0 dst port 5500

#to stream to a file:
ip link set mon0 down ; ifconfig wlan0 down ; ifconfig wlan0 up ; iw dev wlan0 interface add mon0 type monitor ; ip link set mon0 up ; CFG_STR=$(mcp -c 100/80 -C 1 -N 1) ; nexutil -Iwlan0 -s500 -b -l34 -v$CFG_STR ; nexutil -k ; tcpdump -i wlan0 dst port 5500 -vv -w capture.pcap -c 1000
```

## Filter by MAC
```sh
ip link set mon0 down ; ifconfig wlan0 down ; ifconfig wlan0 up ; iw dev wlan0 interface add mon0 type monitor ; ip link set mon0 up ; CFG_STR=$(mcp -c 36/80 -C 1 -N 1 -m b8:27:c5:9b:1c:d8) ; nexutil -Iwlan0 -s500 -b -l34 -v$CFG_STR ; nexutil -k ; tcpdump -i wlan0 dst port 5500

#to stream to a file:
ip link set mon0 down ; ifconfig wlan0 down ; ifconfig wlan0 up ; iw dev wlan0 interface add mon0 type monitor ; ip link set mon0 up ; CFG_STR=$(mcp -c 36/80 -C 1 -N 1 -m b8:27:c5:9b:1c:d8) ; nexutil -Iwlan0 -s500 -b -l34 -v$CFG_STR ; nexutil -k ; tcpdump -i wlan0 dst port 5500 -vv -w capture.pcap -c 100
```


## Interprete the data:
Use `scp` to collect the files to the central PC ( execute that in your location in the PC `Not in the rpi` ):
```
scp pi@10.10.10.102:/home/pi/capture.pcap ./
```

## Usefull MAC of `WIRELESS` nics
| MAC  |      Device      |
|----------|:-------------:|
| 84:fd:d1:15:20:0c |  MSI laptop |
| 64:70:02:CC:1B:24 |  Mother tp-link 5G |
| b8:27:c5:9b:1c:d8 |  honor wifi 6 |
| dc:a6:32:64:9a:65 | Amber4GB |
| dc:a6:32:64:b9:11 | Betty4GB |
|  |  |
|  |  |


## Troubleshooting