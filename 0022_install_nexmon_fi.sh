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

echo 'end build'


setStatus "create mon0"
iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor
echo "end mon0"


#setStatus "Setting up Persistance"
#cd $NEXDIR/patches/bcm43455c0/7_45_206/nexmon_csi/
#cd brcmfmac_4.19.y-nexmon
#mv $(modinfo brcmfmac -n) ./brcmfmac.ko.orig
#cp ./brcmfmac.ko $(modinfo brcmfmac -n)
#depmod -a
#echo 'end patches'

setStatus "Completed"
echo 'done 0020'
