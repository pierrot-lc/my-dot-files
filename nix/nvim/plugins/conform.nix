{ config, pkgs, lib, ... }:

let
  fromGitHub = import ./build-plugin.nix {inherit pkgs; inherit lib;};
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = fromGitHub "stevearc/conform.nvim";
      config = ''
        require("conform").setup({
          formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            sh = { "shfmt" },
            json = { "jq" },
            latex = { "latexindent" },
          },
        })

        vim.keymap.set(
          "n",
          "<leader>F",
          require("conform").format,
          { desc = "Format" }
        )
      '';
      type = "lua";
    }
  ];

  programs.neovim.extraPackages = with pkgs; [
    black
    isort
    jq
    perl538Packages.LatexIndent
    shfmt
    stylua
  ];
}
