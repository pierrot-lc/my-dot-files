{ config, pkgs, lib, ... }:

let
  fromGitHub = import ./build-plugin.nix {inherit pkgs; inherit lib;};
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = fromGitHub "folke/zen-mode.nvim";
      config = ''
        require("zen-mode").setup({
          window = {
            options = {
              number = false, -- Disable number column.
              signcolumn = "no",
              cursorline = false,
              cursorcolumn = false,
              foldcolumn = "0", -- Disable fold column.
            },
          },
          plugins = {
            tmux = {
              enabled = true,
            },
            gitsigns = {
              enabled = true,
            },
          },
          on_open = function(_)
            vim.diagnostic.disable()
          end,
          on_close = function()
            vim.diagnostic.enable()
          end,
        })
      '';
      type = "lua";
    }

    {
      plugin = fromGitHub "folke/twilight.nvim";
      config = ''
        require("twilight").setup({
            context = 55,
            treesitter = false,
            expand = {
                "function",
                "method",
            },
        })
      '';
      type = "lua";
    }
  ];
}
