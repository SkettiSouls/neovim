{ clang-tools
, fish
, fzf
, gcc
, git
, lazygit
, libqalculate
, nil
, nodejs
, nodePackages
, python3Packages
, ripgrep
, rust-analyzer
, rust-bin
, tree-sitter
}:
[
  clang-tools
  fish
  fzf
  gcc
  git
  lazygit
  libqalculate
  nil
  nodejs
  nodePackages.typescript-language-server
  python3Packages.jedi-language-server
  ripgrep
  rust-analyzer
  (rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  })
  tree-sitter
]
