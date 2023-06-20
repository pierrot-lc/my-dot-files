#!/bin/sh

echo "Deleting old neovim config"
mkdir -p "$HOME/.config/nvim/"
rm -rf "$HOME/.config/nvim/init.lua" "$HOME/.config/nvim/lua/" "$HOME/.config/nvim/ftplugin/"

cp "init.lua" "$HOME/.config/nvim/init.lua"
cp -r "lua/" "$HOME/.config/nvim/lua/"
cp -r "ftplugin/" "$HOME/.config/nvim/ftplugin/"

echo "Done"
