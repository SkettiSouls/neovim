{ fetchFromGitHub
, vimPlugins
, vimUtils
}:
let
  inherit (vimUtils) buildVimPlugin;
in
with vimPlugins; [
  ### Rice ###
  lualine-nvim
  vim-startify                       # Start screen
  lspkind-nvim                       # Completion Type Icons
  nvim-web-devicons                  # Dev Icons
  nvim-treesitter.withAllGrammars    # Better highlighting
  image-nvim                         # Render images in neovim

  ### Workflow ###
  nvim-autopairs                     # Autopairs for '(' '[' '{'
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
  oil-nvim                           # Buffer like file management (mega based)

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

  # Render markdown in neovim
  (buildVimPlugin {
    pname = "render-markdown-nvim";
    version = "2024-12-29";
    src = fetchFromGitHub {
      owner = "MeanderingProgrammer";
      repo = "render-markdown.nvim";
      rev = "6fbd1491abc104409f119685de5353c35c97c005";
      hash = "sha256-ncFqBv0JITX3pTsLON+HctLUaKXhLRMBUrRWmI8KOSA=";
    };
  })
]
