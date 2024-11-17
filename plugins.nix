{ fetchFromGitHub
, vimPlugins
, vimUtils
}:
let
  inherit (vimUtils) buildVimPlugin;
in
with vimPlugins; [
  ### Ricing ###
  lualine-nvim
  vim-startify                       # Start screen
  lspkind-nvim                       # Completion Type Icons
  nvim-web-devicons                  # Dev Icons
  nvim-treesitter.withAllGrammars    # Better highlighting

  ### Workflow ###
  auto-pairs                         # Autopairs for '(' '[' '{'
  guess-indent-nvim                  # Indention correction
  comment-nvim                       # Commenting keybinds
  toggleterm-nvim                    # Better terminal
  vim-highlightedyank                # Highlights yanked region
  vim-repeat                         # Allows for repeating plugin binds
  vim-suda                           # Sudo password inside nvim
  vim-surround                       # Keybinds for quickly changing surroundings
  plenary-nvim                       # Treesitter dep
  telescope-fzf-native-nvim          # Telescope's fzf rewrite
  telescope-nvim                     # NVim search engine
  direnv-vim                         # Direnv integration

  ### Coding ###
  nvim-lspconfig                     # Nvim lsp
  nvim-cmp                           # Completion
  cmp-nvim-lsp                       # Cmp source for nvim-lsp
  cmp-buffer                         # Cmp source for buffer words
  cmp-path                           # Cmp source for path
  cmp-cmdline                        # Cmp source for vim cmd
  cmp-vsnip                          # Cmp source for snippets
  vim-vsnip                          # Snippet engine
  yuck-vim                           # Yuck syntax highlighting
  vim-nix                            # Nix niceties (i.e. indention)
  markdown-preview-nvim              # Markdown preview in a browser tab

  # Lualine clock
  (buildVimPlugin {
    pname = "lualine-time";
    version = "2024-03-04";
    src = fetchFromGitHub {
      owner = "archibate";
      repo = "lualine-time";
      rev = "71e368674ec59279e8429504074b15fecd758ea8";
      hash = "sha256-5vZVku4btbwGaPPev+bkWG4R7hLavP5ixN4v/FyJb4c=";
    };
  })

  (buildVimPlugin {
    pname = "tfm-nvim";
    version = "2024-04-23";
    src = fetchFromGitHub {
      owner = "Rolv-Apneseth";
      repo = "tfm.nvim";
      rev = "fb0de2c96bf303216ac5d91ce9bdb7f430030f8b";
      hash = "sha256-LiIPVNFEbbkCmqTU+fD23xtTVTIkf6Z5zb+E4Xuz9ps=";
    };
  })
]
