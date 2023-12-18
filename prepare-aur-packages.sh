#!/bin/sh

DIR="$(dirname "${0}")/tmp"

echo "Create dir ${DIR}"
mkdir -p "$DIR"

cd "$DIR" || exit
packages=("apple_cursor" "albafetch" "nordic-darker-theme" "xiccd" "xss-lock-session" "xfce-polkit" "papirus-folders-catppuccin-git")
for f in "${packages[@]}"; do
    # git clone --branch "$f" --single-branch https://github.com/archlinux/aur.git "$f"
    curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/"$f".tar.gz
    tar -xvf "$f".tar.gz
    echo "making package ${f}"
    # Will not run if no directories are available
    cd "$f" && makepkg -f -d && cp -f ./*.pkg.tar.zst ../../x86_64/ && cd ..
done

cd ..
rm -rf "$DIR"

cd x86_64 && repo-add ./urban-disco-repo.db.tar.gz ./*.pkg.tar.zst
