# configure channel and frequency:

Sources : 
https://unix.stackexchange.com/questions/381298/how-to-calculate-parameters-to-iw-set-freq
https://stackoverflow.com/questions/60473359/scapy-get-set-frequency-or-channel-of-a-packet
```
# create mon0:
iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor
ifconfig mon0 up


```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEwOTkwMDc5ODFdfQ==
-->