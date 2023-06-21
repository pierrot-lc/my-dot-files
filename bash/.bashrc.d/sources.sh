#!/bin/sh

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

if command -v bob > /dev/null 2>&1; then
    export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
    # cargo install bob-nvim
fi

if command -v starship > /dev/null 2>&1; then
    eval "$(starship init bash)"
    # cargo install starship
fi
