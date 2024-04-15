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

  ### Workflow ###
  vim-surround          # Keybinds for quickly changing surroundings
  auto-pairs            # Autopairs for '(' '[' '{'
  comment-nvim          # Commenting keybinds but lua
  vim-repeat            # Allows for repeating plugin binds
  vim-highlightedyank   # Highlights yanked region
  rnvimr                # Ranger inside of nvim
  suda-vim              # Sudo password inside nvim
  plenary-nvim          # Some lua shit required by telescope
  guess-indent-nvim     # Tries to guess indent (shocking)
  telescope-nvim
  telescope-fzf-native-nvim

  ### Coding ###
  nvim-lspconfig        # Nvim lsp
  nvim-cmp              # Completion
  cmp-nvim-lsp          # Cmp source for nvim-lsp
  cmp-buffer            # Cmp source for buffer words
  cmp-path              # Cmp source for path
  cmp-cmdline           # Cmp source for vim cmd
  vim-vsnip             # Snippet engine
  cmp-vsnip             # Cmp source for snippets
  #coq_nvim              # Completion
  yuck-vim              # Yuck syntax highlighting
  vim-nix
  nvim-treesitter.withAllGrammars
]
