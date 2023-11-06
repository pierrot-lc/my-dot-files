{ config, pkgs, lib, ... }:

let
  fromGitHub = import ./build-plugin.nix {inherit pkgs; inherit lib;};
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = fromGitHub "akinsho/toggleterm.nvim";
      config = ''
        require("toggleterm").setup({
            open_mapping = "<C-g>",
            direction = "float",
            shade_terminals = true,
        })
      '';
      type = "lua";
    }
  ];
}
