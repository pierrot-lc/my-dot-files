#!/bin/sh

wd=$(pwd)

echo "Copying the kitty configuration files..."
rm -rf "$HOME/.config/kitty"
mkdir -p "$HOME/.config/kitty"

# Iterate over all ".conf" files using globs
for file in "$wd"/*.conf; do
    filename=$(basename "$file")
    ln -s "$wd/$filename" "$HOME/.config/kitty/$filename"
done

echo "Symlinks to ~/.local/bin/ if necessary..."
if [ -d "$HOME/.local/kitty.app/" ]; then
    ln -s "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/kitty"
    ln -s "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/kitten"

    echo "Copying .desktop file..."
    cp "./kitty.desktop" "$HOME/.local/share/applications/kitty.desktop"
    echo "Icon=$HOME/.local/kitty.app/share/icons/hicolor/scalable/apps/kitty.svg" >> "$HOME/.local/share/applications/kitty.desktop"
fi


echo "Done"
