{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs:
    with inputs;
    let
      eachSystem = nixpkgs.lib.genAttrs (import systems);

      # We add all other files to a singleton list to ensure global.lua is loaded before all other files
      luaInputs = [
        "global.lua"
      ] ++ (with builtins; filter (n: n != "global.lua") (attrNames (readDir ./config/lua)));

      vimInputs = [];
    in {
      packages = eachSystem (system:
        let
          inherit (pkgs)
            callPackage
            neovim-unwrapped
            wrapNeovim
            writeShellApplication
            ;

          inherit (pkgs.lib) concatStringsSep;

          pkgs = import nixpkgs { inherit system; };

          neovimConfigs = callPackage ./config { };
          neovimPlugins = callPackage ./plugins.nix { };
          neovimRuntime = callPackage ./runtime.nix { };

          resolvePaths = root: paths: map (relpath: "${root}/${relpath}") paths;

          sourcedLuaConfigs = map (path: "luafile ${path}") (resolvePaths "${neovimConfigs}/lua" luaInputs);
          sourcedVimConfigs = map (path: "source ${path}") (resolvePaths "${neovimConfigs}/vimscript" vimInputs);
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
        }
      );
    };
}
