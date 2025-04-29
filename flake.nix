{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    plugins = {
      url = "git+https://codeberg.org/skettisouls/neovim-plugins";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };

    utils = {
      url = "git+https://codeberg.org/skettisouls/nix-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, self, ... }:
  flake-parts.lib.mkFlake { inherit inputs; }
  {
    config = {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      perSystem = { pkgs, system, ... }: let
        inherit (inputs.utils) readDirs;
        config-files = pkgs.callPackage ./nix/package.nix {};

        luaInit = pkgs.writeText "init.lua" ''
          -- init.lua goes here
          bind = vim.keymap.set
        '';

        vimInit = ''
          " init.vim goes here
          luafile ${luaInit}
        '' + builtins.concatStringsSep "\n"
          (map (path: "luafile ${path}") (readDirs config-files));
      in {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              vimPlugins = prev.vimPlugins // inputs.plugins.packages.${system};
            })
          ];
        };

        packages = {
          default = self.packages.${system}.neovim;
        } //
        (inputs.wrapper-manager.lib.eval {
          inherit pkgs;
          modules = [{
            wrappers.neovim = {
              pathAdd = pkgs.callPackage ./nix/runtime.nix {};
              basePackage = pkgs.wrapNeovim pkgs.neovim-unwrapped {
                configure = {
                  customRC = vimInit;
                  packages.all.start = pkgs.callPackage ./nix/plugins.nix {};
                };
              };
            };
          }];
        }).config.build.packages;
      };
    };
  };
}
