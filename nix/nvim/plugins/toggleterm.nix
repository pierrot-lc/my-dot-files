{ config, pkgs, lib, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = toggleterm-nvim;
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
