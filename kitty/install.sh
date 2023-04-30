#!/bin/sh

wd=$(pwd)

mkdir -p "$HOME/.config/kitty"
rm -f "$HOME/.config/kitty/kitty.conf"
ln -s "$wd/kitty.conf" "$HOME/.config/kitty/kitty.conf"

echo "Done"
