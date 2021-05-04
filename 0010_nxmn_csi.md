# Install nexmon CSI
- _Important:_ `Don't update the firmware cause nexmon doesn't support latest version of raspiOS, don't use #_sudo apt-get upgrade_`.
- If using cable for local network and Wifi for updates/installs then ensure dhcp of wired-network is not provided. Otherwise there is two gateways.
-Source 1: https://github.com/nexmonster/nexmon_csi/tree/pi-5.4.51
-Source 2: https://github.com/nexmonster/nexmon_csi/tree/pi-4.19.97#get-kernel-headers


Install dependencies:
```sh
sudo apt-get update

sudo apt install git libgmp3-dev gawk qpdf bc bison flex libssl-dev make automake texinfo libtool-bin tcpdump tmux openssl libncurses5-dev

sudo reboot
```
Install proper headers for the kernel version:

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

cd nexmon
NEXDIR=$(pwd)
cd $NEXDIR/patches/bcm43455c0/7_45_189/
git clone https://github.com/seemoo-lab/nexmon_csi.git

# missing file in driver:
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt

cd /home/pi/nexmon
```
Add chanspecs:

- add `CH80MHZ_CHSPEC(58, WL_CHANSPEC_CTL_SB_UU),` in file  `nexmon_csi/src/regulations.c` in line 195 `unsigned short additional_valid_chanspecs[] = {`
```sh
nano $NEXDIR/patches/bcm43455c0/7_45_189/nexmon_csi/src/regulations.c
```
- channel 64/80MHz:  `CH80MHZ_CHSPEC(58, WL_CHANSPEC_CTL_SB_UU),`
- channel 36/80MHz:  `CH80MHZ_CHSPEC(42, WL_CHANSPEC_CTL_SB_LL),`
- channel 100/80MHz:  `CH80MHZ_CHSPEC(106, WL_CHANSPEC_CTL_SB_LL),`

Add patch for long recordings in 80MHz channels:
```
nano $NEXDIR/patches/bcm43455c0/7_45_189/nexmon_csi/src/patch.c

# And write this before "extern unsigned chat templateram_bin[];":
__attribute__((at(0x1B6B02, "", CHIP_VER_BCM43455c0,FW_VER_7_45_189)))
BPatch(wlc_monitor_amsdu_patch, 0x1B6B1E);

```

Remove wpa_supplicant:
```sh
apt remove wpasupplicant -y

echo "denyinterfaces wlan0" >> /etc/dhcpcd.conf
```
Setting up logical links:
```sh
cd /home/pi
sudo su
tmux new -c /home/pi -s nexmon 'bash install_nexmon/scripts/0010_links.sh | tee ./0010.log'
```
Install Nexmon drivers & set up persistence
```sh
sudo su
tmux new -c /home/pi -s nexmon 'bash install_nexmon/scripts/0020_nxm_csi.sh | tee ./0020.log'
```

- check if install was successful:
```sh
sudo journalctl -b | grep brcmfmac

output: Apr 28 23:27:34 Amber4GB kernel: brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Apr 28 2021 23:27:00 version 7.45.189 (nexmon.org/csi: v0.1.1-5-g9d86-1)
```


<!--stackedit_data:
eyJoaXN0b3J5IjpbNDIyOTA3NjUzLDg0MjM5MTAwMCwtMTA0OT
k3MzQ5NiwtMTcwNDc5ODY5OSw3OTE4Njc2ODEsLTczMzEzNTE2
MSwtMjA3MzY2MTE5NSwzNjc3Nzk2MTksMTIxMjA1OTQ3MiwxND
I2Njg2NDM0LC0xMjU5ODk4MDAwLC00MTU1NDA3MywtMTY1MzQ2
MDg5Nl19
-->