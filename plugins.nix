{ fetchFromGitHub
, vimPlugins
, vimUtils
}:
let
  inherit (vimUtils) buildVimPlugin;
in
with vimPlugins; [
  ### Ricing ###
  vim-airline                        # Vim bar
  vim-airline-clock                  # Adds time to airline
  vim-startify                       # Start screen
  lspkind-nvim                       # Completion Type Icons
  nvim-web-devicons                  # Dev Icons
  nvim-treesitter.withAllGrammars    # Better highlighting

  ### Workflow ###
  auto-pairs                         # Autopairs for '(' '[' '{'
  guess-indent-nvim                  # Indention correction
  comment-nvim                       # Commenting keybinds
  rnvimr                             # Ranger inside of nvim
  toggleterm-nvim                    # Better terminal
  vim-highlightedyank                # Highlights yanked region
  vim-repeat                         # Allows for repeating plugin binds
  vim-suda                           # Sudo password inside nvim
  vim-surround                       # Keybinds for quickly changing surroundings
  plenary-nvim                       # Treesitter dep
  telescope-fzf-native-nvim          # Telescope's fzf rewrite
  telescope-nvim                     # NVim search engine

  ### Coding ###
  nvim-lspconfig                     # Nvim lsp
  nvim-cmp                           # Completion
  cmp-nvim-lsp                       # Cmp source for nvim-lsp
  cmp-buffer                         # Cmp source for buffer words
  cmp-path                           # Cmp source for path
  cmp-cmdline                        # Cmp source for vim cmd
  cmp-vsnip                          # Cmp source for snippets
  vim-vsnip                          # Snippet engine
  hover-nvim                         # Hover framework
  yuck-vim                           # Yuck syntax highlighting
  vim-nix                            # Nix niceties (i.e. indention)
  markdown-preview-nvim              # Markdown preview in a browser tab
]
