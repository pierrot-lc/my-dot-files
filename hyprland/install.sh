#!/bin/sh

wd=$(pwd)

rm -rf "$HOME/.config/hypr"
mkdir -p "$HOME/.config/hypr"

# Iterate over all ".conf" files using globs
for file in "$wd"/*.conf; do
    filename=$(basename "$file")
    ln -s "$wd/$filename" "$HOME/.config/hypr/$filename"
done

echo "Done"
