#!/bin/sh

rm -rf "$HOME/.config/hypr"
mkdir -p "$HOME/.config/hypr"
cp ./*.conf "$HOME/.config/hypr"
echo "Done"
