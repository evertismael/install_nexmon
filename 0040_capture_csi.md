## Simple test - No filtering (Listen to all data in the channel)
- _Important:_ Router is configured with a specific channel and bandwidth (e.x. 36/80) in this case

```sh
pkill wpa_supplicant ; ip link set mon0 down ; ifconfig wlan0 down ; ifconfig wlan0 up ; iw dev wlan0 interface add mon0 type monitor ; ip link set mon0 up ; CFG_STR=$(mcp -c 36/80 -C 1 -N 1 -d 50) ; nexutil -I wlan0 -s 500 -b -l 34 -v $CFG_STR ; iw dev ; nexutil -k ; tcpdump -i wlan0 dst port 5500

#to stream to a file:
pkill wpa_supplicant ; ip link set mon0 down ; ifconfig wlan0 down ; ifconfig wlan0 up ; iw dev wlan0 interface add mon0 type monitor ; ip link set mon0 up ; CFG_STR=$(mcp -c 36/80 -C 1 -N 1 -d 50) ; nexutil -I wlan0 -s 500 -b -l 34 -v $CFG_STR ; iw dev ; nexutil -k ; tcpdump -i wlan0 dst port 5500 -vv -w capture.pcap -c 1000
```

## Filter by MAC
```sh
MAC1='64:70:02:CC:1B:24';

MAC1='84:fd:d1:15:20:0c';
pkill wpa_supplicant ; ip link set mon0 down ; ifconfig wlan0 down ; ifconfig wlan0 up ; iw dev wlan0 interface add mon0 type monitor ; ip link set mon0 up ; CFG_STR=$(mcp -c 36/80 -C 1 -N 1 -d 50 -m $MAC1) ; nexutil -I wlan0 -s 500 -b -l 34 -v $CFG_STR ; iw dev ; nexutil -k ; tcpdump -i wlan0 dst port 5500

#to stream to a file:
pkill wpa_supplicant ; ip link set mon0 down ; ifconfig wlan0 down ; ifconfig wlan0 up ; iw dev wlan0 interface add mon0 type monitor ; ip link set mon0 up ; CFG_STR=$(mcp -c 36/80 -C 1 -N 1 -d 50 -m $MAC1) ; nexutil -I wlan0 -s 500 -b -l 34 -v $CFG_STR ; iw dev ; nexutil -k ; tcpdump -i wlan0 dst port 5500 -vv -w capture.pcap -c 1000
```


## Interprete the data:
Use `scp` to collect the files to the central PC ( execute that in your location in the PC `Not in the rpi` ):
```
scp pi@10.10.10.102:/home/pi/capture.pcap ./
```

## Usefull MAC of `WIRELESS` nics 
Notice that these are my devices and yours can be very different
| MAC  |      Device      |
|----------|:-------------:|
| 84:fd:d1:15:20:0c |  MSI laptop |
| 64:70:02:CC:1B:24 |  Mother tp-link 5G |
| b8:27:c5:9b:1c:d8 |  honor wifi 6 |
| dc:a6:32:64:9a:65 | Amber4GB |
| dc:a6:32:64:b9:11 | Betty4GB |
|  |  |

<!--stackedit_data:
eyJoaXN0b3J5IjpbNDIxNTAyMTE1LC0xMjQ1NjMzMDI1LDEzMD
U1MjI2MDUsLTE2ODQ5OTM0OCwtMTM4MzQyOTQwNCw2Nzg0NTU5
NTksMTM2OTA2NjY4MywxOTI3OTczNzMwLDE3MjU0ODA3NjIsMT
k0NTk4MDMxMl19
-->