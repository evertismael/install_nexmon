#!/bin/sh
# @author: Aravind Voggu @zeroby0

function setStatus () {
  if { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
    tmux set status-right "Status: $1"
  else
    echo "Status: $1"
  fi
}

setStatus "Downloading Nexmon"
cd nexmon
# git checkout f9db9abcac8f40a7f8a8408429e34e1c51f33c97
NEXDIR=$(pwd)
echo 'pwd'

setStatus "Building libISL"
cd $NEXDIR/buildtools/isl-0.10
autoreconf -f -i
./configure
make
make install
ln -s /usr/local/lib/libisl.so /usr/lib/arm-linux-gnueabihf/libisl.so.10
echo 'libISL'

setStatus "Building libMPFR"
cd $NEXDIR/buildtools/mpfr-3.1.4
autoreconf -f -i
./configure
make
make install
ln -s /usr/local/lib/libmpfr.so /usr/lib/arm-linux-gnueabihf/libmpfr.so.4
echo 'libMPFR'

setStatus "Completed 0010"
echo 'completed 0010'
