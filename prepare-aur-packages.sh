#!/bin/sh

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
DIR="$SCRIPT_DIR/tmp"

echo "Create dir ${DIR}"
mkdir -p "$DIR"

packages=("apple_cursor" "albafetch" "xiccd" "xss-lock-session" "xfce-polkit" "xstow")
for f in "${packages[@]}"; do
    cd "$DIR" || exit
    # git clone --branch "$f" --single-branch https://github.com/archlinux/aur.git "$f"
    curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/"$f".tar.gz
    tar -xvf "$f".tar.gz
    echo "making package ${f}"
    # Will not run if no directories are available
    cd "$DIR/$f" && makepkg -f -d && mv ./*.pkg.tar.zst "$SCRIPT_DIR"/x86_64/
done

cd "$SCRIPT_DIR" || exit
rm -rf "$DIR"

cd "$SCRIPT_DIR"/x86_64/ && ./rebuild.sh
