{
  # Maybe auto-detect all nix files?
  # Can use `builtins.readDir`, `lib.filterAttrs`, and `lib.mapAttrsToList`.
  imports = [
    ./alpha-nvim.nix
    ./autopairs.nix
    ./dial.nix
    ./dressing.nix
    ./mini-comment.nix
    ./mini-indentscope.nix
    ./mini-splitjoin.nix
    ./nordic.nix
    ./nvim-linefly.nix
    ./nvim-rooter.nix
    ./nvim-surround.nix
    ./nvim-tree.nix
    ./nvim-ufo.nix
    ./ranger.nix
    ./todo-comments.nix
    ./toggleterm.nix
    ./treesitter.nix
    ./vim-characterize.nix
    ./which-key.nix
  ];
}
