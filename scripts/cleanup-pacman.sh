#!/bin/bash

: '
This is a rescue script that was used to fix pacman'\''s broken state,
caused from a corrupted system update.

It must be only used if no other solution works to restore pacman'\''s functionality.

Try these first:
- sudo pacman -D -k # check db integrity
- sudo pacman -Qk # check for problems with installed package files
'

directory='/var/lib/pacman/local'
pkg_pattern='-[0-9]+([.:][0-9]+)*-[0-9]+$'

sudo cp -r $directory $directory.bak
cd $directory || exit 1

for pkg in $(
    ls -1 \
        | grep -E ".+$pkg_pattern" \
        | sed -E "s/$pkg_pattern//" \
        | sort | uniq -d
    ); do
    echo -e "Package: $pkg\n"

    mapfile -t versions < <(ls -1 | grep -E "^$pkg$pkg_pattern$" | sort -V)

    echo "Versions:"
    echo -e "${versions[@]}\n"

    for v in "${versions[@]:0:${#versions[@]}-1}"; do
        echo "Removing: $v"
        sudo rm -rf "$directory/$v"
    done

    echo ''
done

echo "Duplicate cleanup complete."

