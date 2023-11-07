{ config, pkgs, lib, ... }:

let
  fromGitHub = import ./build-plugin.nix {inherit pkgs; inherit lib;};
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = fromGitHub "mfussenegger/nvim-lint";
      config = ''
        require("lint").linters_by_ft = {
          markdown = { "markdownlint", "proselint" },
          norg = { "proselint" },
          sh = { "shellcheck" },
          yaml = { "yamllint" },
        }

        vim.diagnostic.config({ update_in_insert = false })

        vim.api.nvim_create_autocmd({
          "BufWritePost",
          "BufReadPost"
        }, {
          callback = function()
            require("lint").try_lint()
          end,
        })
      '';
      type = "lua";
    }
  ];

  programs.neovim.extraPackages = with pkgs; [
      nodePackages_latest.markdownlint-cli
      proselint
      shellcheck
      yamllint
  ];
}
