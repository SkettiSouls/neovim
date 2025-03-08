{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";

    luagit = {
      url = "git+https://codeberg.org/skettisouls/luagit";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, flake-parts, ... }:
  flake-parts.lib.mkFlake { inherit inputs; }
  ({ withSystem, ... }:
  {
    systems = import inputs.systems;

    perSystem = { pkgs, system, ... }: {
      _module.args.pkgs = (import inputs.nixpkgs {
        inherit system;
        overlays = [
          (final: prev: withSystem system ({ config, ... }: {
            self = config.packages;
          }))
        ];
      });

      packages = let
        inherit (pkgs)
          callPackage
          neovim-unwrapped
          wrapNeovim
          writeShellApplication
          ;

        inherit (pkgs.lib) concatStringsSep;

        source = lang: dir:
          resolvePaths
            "${neovimConfigs}/${lang}/${dir}"
            (with builtins; attrNames (readDir ./config/${lang}/${dir}))
            ;

        luaDirs = with builtins; attrNames (nixpkgs.lib.filterAttrs (_: v: v == "directory") (readDir ./config/lua));
        luaFiles = nixpkgs.lib.flatten (map (dir: source "lua" dir) luaDirs);
        # Load global.lua before all other files
        luaInputs = (resolvePaths "${neovimConfigs}/lua" [ "global.lua" ]) ++ luaFiles;

        vimInputs = [];

        # The stolen bit:
        neovimConfigs = callPackage ./config {};
        neovimPlugins = callPackage ./plugins.nix { luagit = inputs.luagit.packages.${system}.luagit; };
        neovimRuntime = callPackage ./runtime.nix {};

        resolvePaths = root: paths:  map (relpath: "${root}/${relpath}") paths;
        sourcedLuaConfigs = map (path: "luafile ${path}") luaInputs;
        sourcedVimConfigs = map (path: "source ${path}") vimInputs;
        sourcedConfigs = sourcedVimConfigs ++ sourcedLuaConfigs;
        sourceString = concatStringsSep "\n" sourcedConfigs;

        neovimWrapped = wrapNeovim neovim-unwrapped {
          configure = {
            customRC = sourceString;
            packages.all.start = neovimPlugins;
          };
        };
      in {
        default = writeShellApplication {
          name = "nvim";
          runtimeInputs = neovimRuntime;
          text = ''
            ${neovimWrapped}/bin/nvim "$@"
          '';
        };

      } //
      (inputs.wrapper-manager.lib.eval {
        inherit pkgs;
        modules = map (dir: ./wrappers/${dir}) (with builtins; attrNames (readDir ./wrappers));
      }).config.build.packages;
    };
  });
}
