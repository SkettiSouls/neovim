{ fetchFromGitHub
, vimPlugins
, vimUtils
}:
let
  inherit (vimUtils) buildVimPlugin;
in
with vimPlugins; [
  ### Ricing ###
  fidget-nvim # possibly shit idfk
  vim-airline # Vim bar
  vim-airline-clock # Adds time to airline
  vim-startify # Start screen
  nvim-colorizer-lua # ???
  nvim-web-devicons # Dev Icons

  ### Workflow ###
  vim-surround # Keybinds for quickly changing surroundings
  auto-pairs # Autopairs for '(' '[' '{'
  #vim-commentary # Commenting keybinds
  comment-nvim # Commenting keybinds but lua
  vim-repeat # Allows for repeating plugin binds
  vim-highlightedyank # Highlights yanked region
  rnvimr # Ranger inside of nvim
  suda-vim # Sudo password inside nvim
  telescope-nvim
  telescope-fzf-native-nvim
  plenary-nvim # Some lua shit required by telescope

  ### Coding ###
  nvim-lspconfig # Nvim lsp
  coq_nvim # Completion
  nvim-treesitter.withAllGrammars # Treeshitter
  yuck-vim # Yuck syntax highlighting
  vim-nix
]
