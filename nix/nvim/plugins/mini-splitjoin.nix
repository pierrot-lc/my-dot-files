{ config, pkgs, lib, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = mini-nvim;
      config = ''
        require("mini.splitjoin").setup({
            mappings = {
                toggle = "gS",
            }
        })
      '';
      type = "lua";
    }
  ];
}
