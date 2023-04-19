#!/bin/sh

PACKAGES="apple_cursor checkupdates+aur macchina-bin nordic-darker-theme whitesur-icon-theme xiccd"
DIR="$(dirname ${0})/tmp"

mkdir -p "$DIR"

cd "$DIR" && yay -G $PACKAGES

for f in *; do
    if [ -d "$f" ]; then
        # Will not run if no directories are available
        cd "$f" && makepkg -f && cp ./*.pkg.tar.zst ../../x86_64/ && cd ..
    fi
done

cd ..
rm -rf "$DIR"

cd x86_64 && repo-add ./urban-disco-repo.db.tar.gz ./*.pkg.tar.zst

