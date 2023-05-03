#!/bin/sh

wd=$(pwd)

rm -rf "$HOME/.config/kitty"
mkdir -p "$HOME/.config/kitty"

# Iterate over all ".conf" files using globs
for file in "$wd"/*.conf; do
    filename=$(basename "$file")
    ln -s "$wd/$filename" "$HOME/.config/kitty/$filename"
done

echo "Done"
