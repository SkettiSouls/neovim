{ pkgs }:
with pkgs; [
  fzf
  git
  imagemagick
  nil
  ripgrep
  tree-sitter
  # We use a wrapped lazygit to bring in a config that supports opening files in the current window.
  self.lazygit
]
