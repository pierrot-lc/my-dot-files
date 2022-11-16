#!/bin/sh

echo "Deleting old neovim config"
mkdir -p "$HOME/.config/nvim/"
rm -rf "$HOME/.config/nvim/init.lua" "$HOME/.config/nvim/lua/" "$HOME/.config/nvim/ftplugin/"

echo "Making symlinks for neovim"
wd=$(pwd)

ln -s "$wd/init.lua" "$HOME/.config/nvim/init.lua"

mkdir "$HOME/.config/nvim/lua"
for file in "$wd/lua/"*; do
    file=$(basename "$file")
    ln -s "$wd/lua/$file" "$HOME/.config/nvim/lua/$file"
done

mkdir "$HOME/.config/nvim/ftplugin"
for file in "$wd/ftplugin/"*; do
    file=$(basename "$file")
    ln -s "$wd/ftplugin/$file" "$HOME/.config/nvim/ftplugin/$file"
done

echo "Done"
