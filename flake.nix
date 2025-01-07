{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs @ { self, nixpkgs, flake-parts, ... }:
  flake-parts.lib.mkFlake { inherit inputs; }
  ({ config, flake-parts-lib, ... }:
  {
    systems = import inputs.systems;

    perSystem = { pkgs, ... }: {
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

        luaConfigs = source "lua" "config";
        luaLibs = source "lua" "lib";
        # Load global.lua before all other files
        luaInputs = (resolvePaths "${neovimConfigs}/lua" [ "global.lua" ]) ++ luaLibs ++ luaConfigs;

        vimInputs = [];

        # The stolen bit:
        neovimConfigs = callPackage ./config {};
        neovimPlugins = callPackage ./plugins.nix {};
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
      };
    };
  });
}
