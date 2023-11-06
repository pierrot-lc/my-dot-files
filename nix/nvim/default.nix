{ config, pkgs, lib, ... }:

{
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
    (builtins.readFile ./options.lua)
    (builtins.readFile ./commands.lua)
    (builtins.readFile ./keybindings.lua)
    ''
-- ========================================================================== --
-- ==                             PLUGINS                                  == --
-- ========================================================================== --
    ''
  ];

  programs.neovim.extraPackages = with pkgs; [
      # Dependencies.
      fd  # telescope-repo.nvim
      git  # lazy.nvim
      gnumake  # telescope-fzf-native.nvim
      mlocate  # telescope-repo.nvim
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

  imports = [
    ./plugins
  ];
}
