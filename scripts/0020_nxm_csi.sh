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

setStatus "Downloading Nexmon_CSI"
cd $NEXDIR/patches/bcm43455c0/7_45_189/
echo 'end download nexmon_csi'

setStatus "Building and installing Nexmon_CSI"
cd nexmon_csi
make install-firmware
echo 'end build'

setStatus "Installing makecsiparams"
cd utils/makecsiparams
make
ln -s $PWD/makecsiparams /usr/local/bin/mcp
echo 'end mcp'

setStatus "Installing nexutil"
cd $NEXDIR/utilities/nexutil
make
make install
echo 'end nexutil'

setStatus "Setting up Persistance"
cd $NEXDIR/patches/bcm43455c0/7_45_189/nexmon_csi/
cd brcmfmac_5.4.y-nexmon
mv $(modinfo brcmfmac -n) ./brcmfmac.ko.orig
cp ./brcmfmac.ko $(modinfo brcmfmac -n)

FILE_TXT="$NEXDIR/patches/bcm43455c0/7_45_189/brcmfmac43455-sdio.raspberrypi,4-model-b.txt"

DEST1="/lib/modules/5.4.83-v7l+/kernel/drivers/net/wireless/broadcom/brcm80211/brcmfmac/"
DEST2="/lib/firmware/brcm/"
cp $FILE_TXT $DEST1
cp $FILE_TXT $DEST2

depmod -a
echo 'end patches'

# $(modinfo brcmfmac -n) = /lib/modules/5.4.83-v7l+/kernel/drivers/net/wireless/broadcom/brcm80211/brcmfmac/brcmfmac.ko

echo 'done 0020'
