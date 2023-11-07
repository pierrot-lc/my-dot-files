{ config, pkgs, lib, ... }:

let
  fromGitHub = import ./build-plugin.nix {inherit pkgs; inherit lib;};
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-cmp;
      config = builtins.readFile ./cmp.lua;
      type = "lua";
    }

    nvim-lspconfig
    cmp-nvim-lsp
    cmp-path
    cmp-calc
    (fromGitHub "lukas-reineke/cmp-rg")
  ];

  programs.neovim.extraPackages = with pkgs; [
    ripgrep  # For `cmp-rg`.
  ];
}
