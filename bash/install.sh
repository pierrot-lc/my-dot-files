#!/bin/sh

wd=$(pwd)

echo "
# >>>> Loading my .bashrc.d files
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f \"\$rc\" ]; then
			. \"\$rc\"
		fi
	done
fi

unset rc
# <<<<" >> "$HOME/.bashrc"

echo "Create .bashrc.d directory"
rm -rf "$HOME/.bashrc.d/"
mkdir -p "$HOME/.bashrc.d"

echo "Create symlinks"
for file in ./.bashrc.d/*; do
    if [ -f "$file" ]; then
        file=$(basename "$file")
        echo "$file"
        ln -s "$wd/.bashrc.d/$file" "$HOME/.bashrc.d/$file"
    fi
done
