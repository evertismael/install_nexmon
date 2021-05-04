#!/bin/sh
# @author: Aravind Voggu @zeroby0

function setStatus () {
  if { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
    tmux set status-right "Status: $1"
  else
    echo "Status: $1"
  fi
}

cd nexmon
NEXDIR=$(pwd)

setStatus "Setting up Build Environment"
cd $NEXDIR
source setup_env.sh
make
echo 'setting up environment'

setStatus "Build patches"
cd $NEXDIR/patches/bcm43455c0/7_45_206/nexmon/
make
make backup-firmware
make install-firmware
cd $NEXDIR/utilities/nexutil/
make && make install

apt-get remove wpasupplicant

echo 'end build'


setStatus "create mon0"
iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor
ifconfig mon0 up

echo "end mon0"


#setStatus "Setting up Persistance"
cd $NEXDIR/patches/bcm43455c0/7_45_206/nexmon/
cd brcmfmac_5.4.y-nexmon
mv $(modinfo brcmfmac -n) ./brcmfmac.ko.orig  #copy firmawe-backup.
cp ./brcmfmac.ko $(modinfo brcmfmac -n)

FILE_TXT="$NEXDIR/../brcmfmac43455-sdio.raspberrypi,4-model-b.txt"

DEST1="/lib/modules/5.4.83-v7l+/kernel/drivers/net/wireless/broadcom/brcm80211/brcmfmac/"

DEST2="/lib/firmware/brcm/"

cp $FILE_TXT $DEST1

cp $FILE_TXT $DEST2

depmod -a
#echo 'end patches'

setStatus "Completed"
echo 'done 0020'
