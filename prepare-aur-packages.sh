#!/bin/sh

DIR="$(dirname "${0}")/tmp"

echo "Create dir ${DIR}"
mkdir -p "$DIR"

cd "$DIR" && yay -G apple_cursor checkupdates+aur albafetch nordic-darker-theme xiccd xss-lock-session
for f in *; do
    if [ -d "$f" ]; then
        echo "making package ${f}"
        # Will not run if no directories are available
        cd "$f" && makepkg -f -d && cp -f ./*.pkg.tar.zst ../../x86_64/ && cd ..
    fi
done

cd ..
# rm -rf "$DIR"

cd x86_64 && repo-add ./urban-disco-repo.db.tar.gz ./*.pkg.tar.zst
