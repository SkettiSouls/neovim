{ fetchFromGitHub
, vimPlugins
, vimUtils
}:
let
  inherit (vimUtils) buildVimPlugin;
in
with vimPlugins; [
  ### Ricing ###
  fidget-nvim           # possibly shit idfk
  vim-airline           # Vim bar
  vim-airline-clock     # Adds time to airline
  vim-startify          # Start screen
  nvim-colorizer-lua    # ???
  nvim-web-devicons     # Dev Icons
  lspkind-nvim          # Completion Icons

  ### Workflow ###
  auto-pairs            # Autopairs for '(' '[' '{'
  comment-nvim          # Commenting keybinds but lua
  guess-indent-nvim     # Tries to guess indent (shocking)
  plenary-nvim          # Some lua shit required by telescope
  rnvimr                # Ranger inside of nvim
  telescope-fzf-native-nvim
  telescope-nvim
  toggleterm-nvim
  vim-highlightedyank   # Highlights yanked region
  vim-repeat            # Allows for repeating plugin binds
  vim-suda              # Sudo password inside nvim
  vim-surround          # Keybinds for quickly changing surroundings

  ### Coding ###
  nvim-lspconfig        # Nvim lsp
  nvim-cmp              # Completion
  cmp-nvim-lsp          # Cmp source for nvim-lsp
  cmp-buffer            # Cmp source for buffer words
  cmp-path              # Cmp source for path
  cmp-cmdline           # Cmp source for vim cmd
  vim-vsnip             # Snippet engine
  cmp-vsnip             # Cmp source for snippets
  hover-nvim            # Hover framework
  yuck-vim              # Yuck syntax highlighting
  vim-nix
  nvim-treesitter.withAllGrammars
  markdown-preview-nvim
]
