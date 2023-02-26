#!/bin/sh

# ls formatting
alias ls="ls --group-directories-first -v -r --color=auto"
alias ll="ls -la"
alias l=ls
alias l.="ls -d .*"

# Git
alias g="git"
alias ga="git add"
alias gc="git commit"
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias gds="git diff --staged"


# Ask confirmation before deletion
alias cp="cp -i"
alias mv="mv -i"

# Preserve root
alias chown="chown --preserve-root"
alias chmod="chmod --preserve-root"
alias chgrp="chgrp --preserve-root"
alias rm="rm --preserve-root"

# Become root
alias su="sudo -i"

# Resume wget by default
alias wget="wget -c"

# Show the fat ducks in the current dir
alias ducks="du -h --max-depth=1 | sort -hr | head"
alias df="df -h"

# Find a file from the current directory
alias ff="find . -name "

# Typos
alias sl=ls
alias kk=ll

# Bashrc
alias bashrc="vim ~/.bashrc && source ~/.bashrc"

# Replace old commands with new ones
alias grep=riprep  # cargo install ripgrep
alias vim=nvim  # nvim is better
alias ls=exa  # cargo install exa
alias du=dust  # cargo install du-dust
alias cat=bat  # cargo install bat
alias top=htop

# Miscs
alias forecast="curl wttr.in"  # Show meteo
alias wn="watch -n 0.5 nvidia-smi"  # Monitor nvidia GPUs
alias hsi="history | grep -i"  # Search in history
alias env="env | sort"
alias ip4="curl -s https://api.ipify.org"
alias ip6="curl -s https://api6.ipify.org"
