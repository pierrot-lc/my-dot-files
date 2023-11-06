{ config, pkgs, lib, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = mini-nvim;
      config = ''
        require("mini.comment").setup({
            mappings = {
                comment = "gc",
                comment_line = "gcc",
                textobject = "gc",
            }
        })
      '';
      type = "lua";
    }
  ];
}
