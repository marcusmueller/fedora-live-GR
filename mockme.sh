#!/bin/bash

if [ $# -eq 0 -o $# -gt 2 ]; then
    echo "Usage: $0 kickstart_file.ks [version suffix]"
    exit -1
fi

if [ $# -eq 1 ]; then
    DESC=$(git describe --tags)
    VERSION="$DESC"
else
    DESC="$2"
    VERSION="version $2"
fi

if groups | grep -v  &>/dev/null '\bmock\b'; then
    echo "You're not in the 'mock' group; please make sure mock is installed, add yourself to the 'mock' group, and log out and in again."
    exit -2
fi

KICKSTART=$1
KS_FILE=$(basename "$1")
KS_TARGET=/usr/share/spin-kickstarts/$KS_FILE
OUTIMAGE_NAME="GNU_Radio-live-$DESC.iso"

MFLAGS="-r fedora-25-x86_64"
MOCK="mock $MFLAGS"
#MOCK="echo $MFLAGS"

echo =========================
echo "initializing mock chroot"
echo =========================
$MOCK --init

echo =========================
echo "installing build dependencies"
echo =========================
$MOCK --install lorax-lmc-novirt git pykickstart spin-kickstarts

echo =========================
echo "copying over kickstart file"
echo =========================
$MOCK --copyin "$1" "$KS_TARGET"

echo =========================
echo "invoking livemedia-creator"
echo =========================
$MOCK --shell "livemedia-creator --ks '$KS_TARGET' --no-virt --resultdir /var/lmc --project GNU_Radio-live --make-iso --volid GNU-Radio-live --iso-only --iso-name GNU_Radio-live.iso --releasever 25 --title 'GNURadioLiveSystem'"

echo =========================
echo "copying out resuling ISO"
echo =========================
$MOCK --copyout "/var/lmc/GNU_Radio-live.iso" "./$OUTIMAGE_NAME"
