#!/bin/sh

export PATH="$HOME/.local/bin:$PATH"

# Bob-nvim sources.
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

if command -v starship > /dev/null 2>&1; then
    eval "$(starship init bash)"
    # cargo install starship
fi
