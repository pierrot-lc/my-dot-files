{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "pierrot-lc";
  home.homeDirectory = "/home/pierrot-lc";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # TUI
    kitty
    starship
    ranger
    ripgrep
    fd
    bottom
    bat
    exa
    zip
    unzip
    gnutar

    # Development tools.
    python3Full
    python310Packages.pynvim
    python310Packages.pip
    nodejs_20
    gcc
    gnumake
    cmake
    pdm
    just

    # GUI.
    firefox
    thunderbird
    vlc
    caprine-bin
    discord
    keepassxc
    newsflash
    qbittorrent
    zotero
    drawio
    blanket
    foliate
    popcorntime
    mullvad-vpn

    # Installers.
    rustup
    pipx

    # Gnome extensions.
    gnome-extension-manager
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.weather-oclock
    gnomeExtensions.workspace-indicator
    gnomeExtensions.places-status-indicator
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    gnomeExtensions.material-you-color-theming
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.runcat
    gnomeExtensions.no-activities-button

    # Fonts.
    (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
    emojione
    twitter-color-emoji
    twemoji-color-font
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/kitty".source = ./kitty;
    ".config/nvim".source = ./nvim;
    ".bashrc.d".source = ./.bashrc.d;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pierrot-lc/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;  # Using dedicated overlay.
    defaultEditor = true;
    extraPackages = with pkgs; [
      # Dependencies.
      git  # lazy.nvim
      gcc  # treesitter
      gnumake  # telescope-fzf-native.nvim
      fd  # telescope-repo.nvim
      mlocate  # telescope-repo.nvim
      ranger  # ranger.nvim
      ripgrep  # telescope.nvim

      # Formatters, linters and other LSP's related packages.
      ruff
      black
      isort
      stylua
      codespell
      proselint
      shellcheck
      beautysh
      nodePackages_latest.markdownlint-cli
      jq
      yamllint
      python310Packages.python-lsp-server
      python310Packages.debugpy
      marksman
      lua-language-server
    ];
  };

  programs.git = {
    enable = true;
    userEmail = "pstmrtem@outlook.com";
    userName = "Pierrot LC";
  };

  # Discover installed fonts by home-manager and enable them.
  # But it masks already installed fonts :(.
  fonts.fontconfig.enable = false;
}
