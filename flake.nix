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
  };

  outputs = inputs@{ flake-parts, ... }:
  flake-parts.lib.mkFlake { inherit inputs; }
  {
    config = {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      perSystem = { pkgs, system, ... }: let
        inherit (inputs.utils.lib) readDirs;
        inherit (pkgs) callPackage wrapNeovimUnstable neovim-unwrapped;

        plugins = callPackage ./nix/plugins.nix {};
        runtimeDeps = callPackage ./nix/runtime.nix {};
        config-files = callPackage ./nix/package.nix {};

        luaInit = pkgs.writeText "init.lua" ''
          -- init.lua goes here
          bind = vim.keymap.set
        '';

        vimInit = ''
          " init.vim goes here
          luafile ${luaInit}
        '' + builtins.concatStringsSep "\n"
          (map (path: "luafile ${path}") (readDirs config-files));

        neovimWrapped = wrapNeovimUnstable neovim-unwrapped {
          inherit plugins;
          neovimRcContent = vimInit;
        };

        neovim = neovimWrapped.overrideAttrs (_: _: { inherit runtimeDeps; });
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
          inherit neovim;
          default = neovim;
        };
      };
    };
  };
}
