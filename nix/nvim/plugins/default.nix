{
  # Maybe auto-detect all nix files?
  # Can use `builtins.readDir`, `lib.filterAttrs`, and `lib.mapAttrsToList`.
  imports = [
    ./dial.nix
    ./treesitter.nix
    ./nvim-ufo.nix
    ./nvim-tree.nix
  ];
}
