{ config, pkgs, lib, ... }:

let
  fromGitHub = import ./build-plugin.nix {inherit pkgs; inherit lib;};
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = fromGitHub "ggandor/leap.nvim";
      config = ''
        local leap_jump = function()
            require("leap").leap({ target_windows = { vim.fn.win_getid() } })
        end

        vim.keymap.set(
            "n",
            "<leader>s",
            leap_jump,
            { desc = "Leap jump" }
        )
      '';
      type = "lua";
    }
  ];
}
