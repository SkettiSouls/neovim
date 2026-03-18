{ config, pkgs, ... }:
let
  inherit (pkgs) vimPlugins;
  inherit (pkgs.vimUtils) buildVimPlugin;
  inherit (config.nvim-lib) neovimPlugins;

  direnv-nvim = {
    data = neovimPlugins.direnv;
    name = "direnv-nvim";
  };

  oil-pushd-nvim = {
    data = vimPlugins.oil-pushd-nvim;
    after = [ "oil-nvim" ];
  };
in
{
  config.specs = {
    core = {
      extraPackages = with pkgs; [ git ];
      data = with vimPlugins; [
        plenary-nvim
        nvim-treesitter.withAllGrammars
        vim-suda
      ];
    };

    editing = {
      after = [ "core" ];
      data = with vimPlugins; [
        comment-nvim
        nvim-autopairs
        vim-repeat
        vim-surround
      ];
    };

    lsp = {
      after = [ "core" "editing" "tree" "visuals" ];
      extraPackages = with pkgs; [
        lua-language-server
        nixd
        rust-analyzer
      ];
      data = with vimPlugins; [
        blink-cmp
        nvim-lspconfig
        vim-nix
      ];
    };

    lze = [
      config.nvim-lib.neovimPlugins.lze
      {
        data = config.nvim-lib.neovimPlugins.lzextras;
        name = "lzextras";
      }
    ];

    tree = {
      after = [ "core" ];
      extraPackages = with pkgs; [ ripgrep lazygit ];
      data = with vimPlugins; [
        direnv-nvim
        luagit
        oil-nvim
        oil-pushd-nvim
        telescope-nvim
        telescope-fzf-native-nvim
      ];
    };

    visuals = {
      after = [ "core" "editing" "tree" ];
      extraPackages = [ pkgs.imagemagick ];
      data = with vimPlugins; [
        lualine-nvim           # Status Bar
        vim-startify           # Start Screen
        image-nvim             # Image rendering
        render-markdown-nvim   # Markdown rendering
        markdown-preview-nvim  # Open Markdown File in Browser
      ];
    };
  };
}
