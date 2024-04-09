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
  ### Workflow ###
  vim-surround # Keybinds for quickly changing surroundings
  auto-pairs # Autopairs for '(' '[' '{'
  vim-commentary # Commenting keybinds
  vim-repeat # Allows for repeating plugin binds
  vim-highlightedyank # Highlights yanked region
  rnvimr # Ranger inside of nvim
  suda-vim # Sudo password inside nvim
]
