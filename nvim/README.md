# Neovim configuration files

<p float="center">
  <img src="./.images/tree-and-suggestions.png" width="500" />
  <img src="./.images/linters.png" width="500" />
  <img src="./.images/start-screen-and-which-key.png" width="500" />
  <img src="./.images/telescope.png" width="500" />
</p>

Main components are:

* Use [lazy.nvim](https://github.com/folke/lazy.nvim) as a package manager.
Lazy load the plugins as much as possible.
* LSP configuration providing autocompletion, signatures, diagnostics and formatters.
* Use [mason.nvim](https://github.com/williamboman/mason.nvim) to download LSP packages.
* Use [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
to search for different files.
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
for code parsing and code actions.
* Copilot completions.
* [Neorg](https://github.com/nvim-neorg/neorg) for note taking.

I put a lot of comments so that the configuration is easier to maintain and to understand.
The plugins are organized into multiple files such that each file can be deleted
without affecting (too much) the plugins of the files.

## Install

You can use :

```sh
./install.sh
```

**Note that the will remove your neovim config files if there are any!**

## Dependencies

Use `:checkhealth` to make sure everything is working properly.

### Install neovim nightly

It is recommended to use [bob](https://github.com/MordechaiHadad/bob) as a
neovim version manager.

```sh
cargo install bob-nvim
bob install nightly
```

You will need nerdfont icons.
You can use [getnf](https://github.com/ronniedroid/getnf) to install such a font.

### Lazy package manager

Requires `git`. Lazy will be installed automatically when launching neovim
for the first time, and the plugins will be installed as well.

### Mason packages

The current Mason config needs [pip](https://pip.pypa.io/en/stable/installation/),
[npm](https://github.com/nvm-sh/nvm) and [cargo](https://www.rust-lang.org/tools/install).

### GitHub Copilot completions

You will need a subscription to [GitHub Copilot](https://github.com/features/copilot).
If you have a subscription, you can then use
the [completion plugin](https://github.com/zbirenbaum/copilot.lua)
by setting it up with `:Copilot auth`.

### Other plugins dependencies

* [ranger](https://github.com/ranger/ranger): [kelly-lin/ranger.nvim](https://github.com/kelly-lin/ranger.nvim)
* [fd](https://github.com/sharkdp/fd) & [locate](https://wiki.archlinux.org/title/Locate):
[cljoly/telescope-repo.nvim](https://github.com/nvim-telescope/telescope.nvim)
* make: [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)

```sh
pipx install ranger-fm
cargo install ripgrep fd-find
sudo zypper install mlocate make
```
