{ config, pkgs, lib, ... }:

let
  # Thanks to https://github.com/vimjoyer/nvim-nix-video/blob/main/home.nix
  # and https://gist.github.com/nat-418/493d40b807132d2643a7058188bff1ca.
  fromGitHub = repo: pkgs.vimUtils.buildVimPlugin {
    name = "${lib.strings.sanitizeDerivationName repo}";
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
    };
  };
in {
  # Add neovim-nightly to the packages.
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;

    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withPython3 = true;
  };

  programs.neovim.extraLuaConfig = builtins.concatStringsSep "\n" [
    (builtins.readFile ./init.lua)
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    (fromGitHub "fladson/vim-kitty")
  ];

  programs.neovim.extraPackages = with pkgs; [
      # Dependencies.
      fd  # telescope-repo.nvim
      gcc  # treesitter
      git  # lazy.nvim
      gnumake  # telescope-fzf-native.nvim
      mlocate  # telescope-repo.nvim
      ranger  # ranger.nvim
      ripgrep  # telescope.nvim

      # Formatters, linters and other LSP's related packages.
      # Everything that `Mason` usually handle itself.
      black
      codespell
      isort
      jq
      ltex-ls
      lua-language-server
      marksman
      nodePackages_latest.bash-language-server
      nodePackages_latest.markdownlint-cli
      proselint
      python311Packages.debugpy
      python311Packages.python-lsp-server
      ruff-lsp
      shellcheck
      shfmt
      stylua
      yamllint
  ];

  # TODO: Find a way to import all files inside the `plugins` directory.
  # Maybe combine `builtins.readDir` and `builtins.map`?
  imports =
    [
      ./plugins/treesitter.nix
      ./plugins/dial.nix
    ];
}
