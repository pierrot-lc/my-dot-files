{ config, pkgs, ... }:

{

  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          own-onedark-nvim = prev.vimUtils.buildVimPlugin {
            name = "onedark";
            src = inputs.plugin-onedark;
          };
        };
      })
    ];
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;  # Using dedicated overlay.

    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.neovim.plugins = with pkgs; [
    pkgs.vimPlugins.nvim-treesitter.withAllGrammars
  ];

  programs.neovim.extraPackages = with pkgs; [
      # Dependencies.
      fd  # telescope-repo.nvim
      gcc  # treesitter
      git  # lazy.nvim
      gnumake  # telescope-fzf-native.nvim
      mlocate  # telescope-repo.nvim
      ranger  # ranger.nvim
      ripgrep  # telescope.nvim

      # Formatters, linters and other LSP's related packages.
      # Everything that `Mason` usually handle itself.
      black
      codespell
      isort
      jq
      ltex-ls
      lua-language-server
      marksman
      nodePackages_latest.bash-language-server
      nodePackages_latest.markdownlint-cli
      proselint
      python311Packages.debugpy
      python311Packages.python-lsp-server
      ruff-lsp
      shellcheck
      shfmt
      stylua
      yamllint
  ];
}
