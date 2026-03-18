{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugins = {
      url = "git+https://codeberg.org/skettisouls/neovim-plugins";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };

    plugins-direnv = {
      url = "github:actionshrimp/direnv.nvim";
      flake = false;
    };

    # Demo on fetching plugins from outside nixpkgs
    plugins-lze = {
      url = "github:BirdeeHub/lze";
      flake = false;
    };

    # These 2 are already in nixpkgs, however this ensures you always fetch the most up to date version!
    plugins-lzextras = {
      url = "github:BirdeeHub/lzextras";
      flake = false;
    };
  };

  outputs = inputs@{ flake-parts, nixpkgs, wrappers, ... }:
  flake-parts.lib.mkFlake { inherit inputs; }
  (let
    module = nixpkgs.lib.modules.importApply ./nix/module.nix inputs;
    wrapper = wrappers.lib.evalModule module;
  in
  {
    config = {
      systems = nixpkgs.lib.platforms.all;
      flake.wrappers.neovim = wrapper.config;

      perSystem = { pkgs, system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              vimPlugins = prev.vimPlugins // inputs.plugins.packages.${system};
            })
          ];
        };

        packages = rec {
          neovim-impure = wrapper.config.wrap { inherit pkgs; };
          neovim = (neovim-impure.apply { settings.config_directory = ./.; }).wrap {};
          default = neovim;
        };
      };
    };
  });
}
