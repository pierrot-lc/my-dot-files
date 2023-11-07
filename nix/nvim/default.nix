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

  # `nixpkgs` has a `programs.neovim.runtime` that is better suited for this.
  # But `home-manager` does not so we fall back to this `home.file` solution.
  # Ideally, the config path should not be hardcoded.
  home.file = {
    ".config/nvim/ftplugin/lua.lua".source = ./ftplugin/lua.lua;
    ".config/nvim/ftplugin/markdown.lua".source = ./ftplugin/markdown.lua;
    ".config/nvim/ftplugin/nix.lua".source = ./ftplugin/nix.lua;
    ".config/nvim/ftplugin/norg.lua".source = ./ftplugin/norg.lua;
    ".config/nvim/ftplugin/tex.lua".source = ./ftplugin/tex.lua;
  };

  imports = [
    ./plugins
  ];
}
