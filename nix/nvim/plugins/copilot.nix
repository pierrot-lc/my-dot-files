{ config, pkgs, lib, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = copilot-lua;
      config = ''
        require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = false, -- Start suggesting as soon as you start typing.
                keymap = {
                    accept = "<M-h>",
                    accept_word = "<M-l>",
                    accept_line = false,
                    next = "<M-k>",
                    prev = "<M-j>",
                    dismiss = false,
                },
            },
            panel = {
                enabled = false,
            },
        })
      '';
      type = "lua";
    }
  ];
}
