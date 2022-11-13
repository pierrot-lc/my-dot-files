#!/bin/sh

echo "Delete old neovim config"
mkdir -p "$HOME/.config/nvim/"
rm -rf "$HOME/.config/nvim/init.lua" "$HOME/.config/nvim/lua/" "$HOME/.config/nvim/ftplugin/"

echo "Making symlinks for neovim"
wd=$(pwd)

ln -s "$wd/init.lua" "$wd/init.lua.link"
mv "$wd/init.lua.link" "$HOME/.config/nvim/init.lua"

ln -s "$wd/lua" "$wd/lua.link"
mv "$wd/lua.link" "$HOME/.config/nvim/lua"

ln -s "$wd/ftplugin" "$wd/ftplugin.link"
mv "$wd/ftplugin.link" "$HOME/.config/nvim/ftplugin"

echo "Done"
