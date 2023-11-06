{ config, pkgs, lib, ... }:

let
  fromGitHub = import ./build-plugin.nix {inherit pkgs; inherit lib;};
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = fromGitHub "kelly-lin/ranger.nvim";
      config = ''
        require("ranger-nvim").setup({
            replace_netrw = true,
        })


        vim.api.nvim_create_user_command(
            "Ranger",
            "<cmd>lua require('ranger-nvim').open()<cr>",
            { desc = "Open ranger" }
        )
      '';
      type = "lua";
    }
  ];

  programs.neovim.extraPackages = with pkgs; [
      ranger
  ];
}
