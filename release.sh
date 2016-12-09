#!/bin/sh

if [ "$1" == "" ]; then
    echo "USAGE: ./release.sh NAME"
    echo "Typically, the name is something like r29."
    exit 1
fi

# Check the file size of pak000-Nonfree.pak in case the user forgot to
# install git-lfs
PAKSIZE=$(wc -c < Nonfree/pak000-Nonfree.pak)
if [ $PAKSIZE -lt 1000000 ]; then
    echo "FATAL: pak000-Nonfree.pak is too small."
    echo
    echo "It's very likely that you've git-cloned this respository without"
    echo "installing git-lfs, or have downloaded this via GitHub's 'Download ZIP'"
    echo "which doesn't support LFS yet."
    echo
    echo "Please see this website for instructions to install git-lfs:"
    echo "https://git-lfs.github.com"
    exit 2
fi

OUTFILE="OpenSpadesDevPackage-$1.zip"

rm -f "$OUTFILE"
zip "$OUTFILE" \
    Nonfree/LICENSE.md \
    Nonfree/pak000-Nonfree.pak \
    OfficialMods/LICENSE.md \
    OfficialMods/font-unifont.pak

echo "$OUTFILE was created."
