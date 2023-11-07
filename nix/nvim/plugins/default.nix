{
  # Maybe auto-detect all nix files?
  # Can use `builtins.readDir`, `lib.filterAttrs`, and `lib.mapAttrsToList`.
  imports = [
    ./alpha-nvim.nix
    ./autopairs.nix
    ./copilot.nix
    ./data-viewer.nix
    ./dial.nix
    ./dressing.nix
    ./gitsigns.nix
    ./leap.nix
    ./mini-comment.nix
    ./mini-indentscope.nix
    ./mini-splitjoin.nix
    ./neogit.nix
    ./neorg.nix
    ./nordic.nix
    ./nvim-linefly.nix
    ./nvim-rooter.nix
    ./nvim-spider.nix
    ./nvim-surround.nix
    ./nvim-tree.nix
    ./nvim-ufo.nix
    ./ranger.nix
    ./telescope.nix
    ./todo-comments.nix
    ./toggleterm.nix
    ./treesitter.nix
    ./vim-characterize.nix
    ./vim-kitty.nix
    ./vim-lastplace.nix
    ./which-key.nix
    ./nvim-puppeteer.nix
    ./zen-mode.nix
  ];
}
