# Install Nexmon-only NOT csi:

* Notice that it's very similar to nexmon_CSI with some differences:
- Kernel version: 5.4.83-v7l+


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

Download Nexmon and install-instructions:
```sh
sudo su
git clone https://github.com/seemoo-lab/nexmon.git
git clone https://github.com/evertismael/install_nexmon.git

# missing file in driver:
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt

cd nexmon
NEXDIR=$(pwd)
cd $NEXDIR/patches/bcm43455c0/7_45_189/
git clone https://github.com/seemoo-lab/nexmon_csi.git
```

`Note: You can take an image from the sd card at this moment to avoid going through the whole process again`

Copy the chanspecs restrictions:
``` sh
ORI="$NEXDIR/patches/bcm43455c0/7_45_189/nexmon_csi/src/regulations.c"
DES="$NEXDIR/patches/bcm43455c0/7_45_206/nexmon/src/"
cp $ORI $DES 
```

Add chanspecs and Modify the regulations.c file:

```sh
nano $NEXDIR/patches/bcm43455c0/7_45_206/nexmon/src/regulations.c
```
-  Change line 236 to: `FW_VER_ALL`
- Add `CH80MHZ_CHSPEC(58, WL_CHANSPEC_CTL_SB_UU),` in file  `nexmon_csi/src/regulations.c` in line 195 `unsigned short additional_valid_chanspecs[] = {`
	- channel 64/80MHz:  `CH80MHZ_CHSPEC(58, WL_CHANSPEC_CTL_SB_UU),`
	- channel 36/80MHz:  `CH80MHZ_CHSPEC(42, WL_CHANSPEC_CTL_SB_LL),`
	- channel 100/80MHz:  `CH80MHZ_CHSPEC(106, WL_CHANSPEC_CTL_SB_LL),`

Modify wrapper.c file: Change `AT(CHIP_VER_BCM43455c0, FW_VER_7_45_189, 0x57770)` to `AT(CHIP_VER_BCM43455c0, FW_VER_ALL, 0x57770)` in line 1779
```sh
nano $NEXDIR/patches/common/wrapper.c
```

======================================================================
Remove chanspecs Restrictions:

- Modify the file sendframe.c  
```sh
nano /home/pi/nexmon/patches/bcm43455c0/7_45_206/nexmon/src/sendframe.c

# add the line after ´char ret´:
# this unmutes the currently used channel and allows to send on "quiet/passive" channels
    
wlc_bmac_mute(wlc->hw, 0, 0);
```
- declaire the function wlc_bmac_mute ()

```sh
nano /home/pi/nexmon/patches/common/wrapper.c

# add before: `#undef VOID_DUMMY`

AT(CHIP_VER_BCM43455c0, FW_VER_ALL, 0x49874)
void
wlc_bmac_mute(struct wlc_hw_info *wlc_hw, bool on, uint32 flags)
VOID_DUMMY

AT(CHIP_VER_BCM43455c0, FW_VER_ALL, 0x57b70)
void
wlc_clr_quiet_chanspec(void *wlc_cmi, unsigned short chanspec)
VOID_DUMMY
   
```
=======================================================================

Setting up logical links:
```sh
cd /home/pi
sudo su
tmux new -c /home/pi -s nexmon 'bash install_nexmon/scripts/0010_links.sh | tee ./0010.log'
```
Install nexmon
```sh
sudo su
tmux new -c /home/pi -s nexmon 'bash install_nexmon/scripts/0030_nxm.sh | tee ./0030.log'
```
- check if install was successful:
```sh
sudo journalctl -b | grep brcmfmac

output: Apr 28 23:27:34 Amber4GB kernel: brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Apr 28 2021 23:27:00 version 7.45.189 (nexmon.org/csi: v0.1.1-5-g9d86-1)
```


<!--stackedit_data:
eyJoaXN0b3J5IjpbNjg1MzgzOTA4LC0xOTQxMjkyNTc1LDk2ND
k2NDMyNiwtMTk4MjU0Mjg0MCwxNjg3NzM1MjA3LDMzMzY0MTUw
OCwxMzIyOTQ5MzY4LC0zNjMxNzk1NzksMTY1OTA4MjYzOCwxOT
A5MDY0MTg4LC0xODk5NDgxNDk3LC0xMzI0MDcwNDI5LC0xOTgz
Nzc5NzE2LC02OTAzNDI4NjEsMTA3NDkwMzM4MSw1ODE1Mzc4MD
EsMTUzODU5MzkxNSwtMTk1Nzc3NjY1MSwxMzQwNDA0ODgyXX0=

-->