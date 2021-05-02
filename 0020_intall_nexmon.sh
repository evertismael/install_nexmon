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
git clone https://github.com/seemoo-lab/nexmon_csi.git
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
cd brcmfmac_4.19.y-nexmon
mv $(modinfo brcmfmac -n) ./brcmfmac.ko.orig
cp ./brcmfmac.ko $(modinfo brcmfmac -n)
depmod -a
echo 'end patches'

setStatus "Downloading additional scripts"
cd /home/pi
wget https://raw.githubusercontent.com/nexmonster/nexmon_csi/pi-4.19.97/reinstall.sh -O reinstall.sh
setStatus "Completed"
echo 'done 0020'
